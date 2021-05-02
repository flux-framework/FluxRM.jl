module JobSpec

export GPU, CPUCore, Slot, Node, Task, Count, System, Attributes, Jobspec, JobspecV1

using StructTypes

###
# IntraNodeResource
###

abstract type IntraNodeResource end
StructTypes.StructType(::Type{IntraNodeResource}) = StructTypes.AbstractType()

Base.@kwdef mutable struct GPU <: IntraNodeResource 
    type::String = "gpu"
    count::Int = 1
    unit::Union{Nothing, String} = nothing
end
StructTypes.StructType(::Type{GPU}) = StructTypes.Mutable()
StructTypes.omitempties(::Type{GPU}) = (:unit,)
GPU(count, unit=nothing) = GPU("gpu", count, unit)

function validate(gpu::GPU, version)
    @assert gpu.type == "gpu"
    @assert gpu.count >= 1
    return true
end

Base.@kwdef mutable struct CPUCore <: IntraNodeResource 
    type::String = "core"
    count::Int = 1
    unit::Union{Nothing, String} = nothing
end
StructTypes.StructType(::Type{CPUCore}) = StructTypes.Mutable()
StructTypes.omitempties(::Type{CPUCore}) = (:unit,)
CPUCore(count, unit=nothing) = CPUCore("core", count, unit)

function validate(cpu::CPUCore, version)
    @assert cpu.type == "core"
    @assert cpu.count >= 1
    return true
end

StructTypes.subtypekey(::Type{IntraNodeResource}) = :type
StructTypes.subtypes(::Type{IntraNodeResource}) = (core=CPUCore, gpu=GPU)

###
# Resource
###

abstract type Resource end
StructTypes.StructType(::Type{Resource}) = StructTypes.AbstractType()

Base.@kwdef mutable struct Slot <: Resource
    type::String = "slot"
    count::Int = 1
    label::String = ""
    with::Vector{IntraNodeResource} = IntraNodeResource[]
    exclusive::Union{Nothing, Bool} = nothing
    unit::Union{Nothing, String} =  nothing
end
StructTypes.StructType(::Type{Slot}) = StructTypes.Mutable()
StructTypes.omitempties(::Type{Slot}) = (:exclusive, :unit)

function validate(slot::Slot, version)
    @assert slot.type == "slot"
    @assert slot.count >= 1
    @assert 1 <= length(slot.with) <= 2
    return all(x->validate(x, version), slot.with)
end

Base.@kwdef mutable struct Node <: Resource
    type::String = "node"
    count::Int = 1
    with::Vector{Slot} = Slot[]
    unit::Union{Nothing, String} = nothing
end
StructTypes.StructType(::Type{Node}) = StructTypes.Mutable()
StructTypes.omitempties(::Type{Node}) = (:unit,)

function validate(node::Node, version)
    @assert node.type == "node"
    @assert node.count >= 1
    @assert length(node.with) == 1
    return all(x->validate(x, version), node.with)
end


StructTypes.subtypekey(::Type{Resource}) = :type
StructTypes.subtypes(::Type{Resource}) = (node=Node, slot=Slot)

###
# Tasks
###
Base.@kwdef mutable struct Count
    per_slot::Union{Nothing, Int} = nothing
    total::Union{Nothing, Int} = nothing
end
StructTypes.StructType(::Type{Count}) = StructTypes.Mutable()
StructTypes.omitempties(::Type{Count}) = (:per_slot, :total)

function validate(count::Count, version)
    per_slot = count.per_slot
    total = count.total
    if per_slot !== nothing
        @assert per_slot >= 1
    end
    if total !== nothing
        @assert total >= 1
    end
    return true
end

struct Task
    command::Vector{String}
    slot::String
    count::Count
end
StructTypes.StructType(::Type{Task}) = StructTypes.Struct()

function validate(task::Task, version)
    @assert length(task.command) > 0
    @assert !isempty(task.slot)
    return validate(task.count, version)
end

function Task(cmd::Cmd, slot, count)
    Task(cmd.exec, slot, count)
end

###
# Attributes
###
Base.@kwdef mutable struct System
    duration::Real = 0 # mandatory
    cwd::Union{Nothing, String} = nothing
    environment::Union{Nothing, Dict} = nothing
    batch::Union{Nothing, Dict} = nothing
    shell::Union{Nothing, Dict} = nothing
end
StructTypes.StructType(::Type{System}) = StructTypes.Mutable()
StructTypes.omitempties(::Type{System}) = (:cwd, :environment, :batch, :shell)

function validate(system::System, version)
    @assert system.duration >= 0
    return true
end

Base.@kwdef mutable struct Attributes
    system::System = System() # mandatory
    user::Union{Nothing, Dict} = nothing
end
StructTypes.StructType(::Type{Attributes}) = StructTypes.Mutable()
StructTypes.omitempties(::Type{Attributes}) = (:user,)

function validate(attr::Attributes, version)
    return validate(attr.system, version)
end

###
# JobSpec
###

struct Jobspec
    version::Int
    resources::Vector{Resource}
    tasks::Vector{Task}
    attributes::Attributes
end
StructTypes.StructType(::Type{Jobspec}) = StructTypes.Struct()
JobspecV1(resources, tasks, attributes) = Jobspec(1, resources, tasks, attributes)

function validate(jobspec::Jobspec, version)
    @assert jobspec.version == version
    @assert length(jobspec.resources) == 1
    @assert length(jobspec.tasks) <= 1
    isvalid = validate(jobspec.attributes, version)
    isvalid &= all(t->validate(t, version), jobspec.tasks)
    isvalid &= all(r->validate(r, version), jobspec.resources)
    return isvalid
end

function from_command(command; num_tasks::Int = 1, cores_per_task::Int = 1,
                               gpus_per_task::Union{Nothing, Int} = nothing, num_nodes::Union{Nothing, Int} = nothing)
    @assert num_tasks >= 1 
    @assert cores_per_task >= 1
    if gpus_per_task !== nothing
        @assert gpus_per_task >= 1
    end
    if num_nodes !== nothing
        @assert num_nodes >= 1
        @assert num_nodes <= num_tasks
    end

    children = IntraNodeResource[CPUCore(count=cores_per_task)]

    if gpus_per_task !== nothing
        push!(children, GPU(count=gpus_per_task))
    end

    if num_nodes === nothing
        count = Count(per_slot=1)
        slot = Slot(label="task", count=num_tasks, with=children)
        resource = slot
    else
        num_slots = ceil(Int, num_tasks / num_nodes)
        if num_tasks % num_nodes != 0
            count = Count(total=num_tasks)
        else
            count = Count(per_slot=1)
        end
        slot = Slot(label="task", count=num_slots, with=children)
        resource = Node(count=num_nodes, with=[slot])
    end

    tasks = [Task(command, "task", count)]
    resources = [resource]
    attrs = Attributes(system=System(duration=0))

    return JobspecV1(resources, tasks, attrs)
end

function from_batch_command(script, jobname; args=nothing, num_slots=1,
                                             cores_per_slot=1, gpus_per_slot=nothing,
                                             num_nodes=nothing, broker_opts=nothing)
    @assert startswith(script, "#!")
    args = args === nothing  ? () : args

    jobspec = from_command(
        `jobname $args`, # argv[0] will be replaced with the script
        num_tasks=num_slots,
        cores_per_task=cores_per_slot,
        gpus_per_task=gpus_per_slot,
        num_nodes=num_nodes
    )

    batch = Dict(
        "script" => script,
    )
    if broker_opts !== nothing
        batch["broker-opts"] = broker_opts
    end
    system = jobspec.attributes.system
    system.batch = batch
    system.shell = Dict(
        "options" => Dict(
            "per-resource.type" => "node"
        )
    )
    return jobspec
end

function from_nest_command(command; num_slots=1, cores_per_slot=1,
                                    gpus_per_slot=nothing, num_nodes=nothing, broker_opts=nothing)

    broker_opts = broker_opts === nothing ? () :  broker_opts
    jobspec = from_command(
        `flux broker $broker_opts $command`,
        num_tasks=num_slots,
        cores_per_task=cores_per_slot,
        gpus_per_task=gpus_per_slot,
        num_nodes=num_nodes
    )

    jobspec.attributes.system.shell = Dict(
        "options" => Dict(
            "per-resource.type" => "node"
        )
    )
    return jobspec
end

end # module
