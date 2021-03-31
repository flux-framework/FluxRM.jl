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

Base.@kwdef mutable struct CPUCore <: IntraNodeResource 
    type::String = "cpu"
    count::Int = 1
    unit::Union{Nothing, String} = nothing
end
StructTypes.StructType(::Type{CPUCore}) = StructTypes.Mutable()
StructTypes.omitempties(::Type{CPUCore}) = (:unit,)
CPUCore(count, unit=nothing) = CPUCore("core", count, unit)

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

Base.@kwdef mutable struct Node <: Resource
    type::String = "node"
    count::Int = 1
    with::Vector{Slot} = Slot[]
    unit::Union{Nothing, String} = nothing
end
StructTypes.StructType(::Type{Node}) = StructTypes.Mutable()
StructTypes.omitempties(::Type{Node}) = (:unit,)

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

struct Task
    command::Vector{String}
    slot::String
    count::Count
end
StructTypes.StructType(::Type{Task}) = StructTypes.Struct()

###
# Attributes
###
Base.@kwdef mutable struct System
    duration::Real = 0 # mandatory
    cwd::Union{Nothing, String} = nothing
    environment::Union{Nothing, Dict} = nothing
end
StructTypes.StructType(::Type{System}) = StructTypes.Mutable()
StructTypes.omitempties(::Type{System}) = (:cwd, :environment)

Base.@kwdef mutable struct Attributes
    system::System = System() # mandatory
    user::Union{Nothing, Dict} = nothing
end
StructTypes.StructType(::Type{Attributes}) = StructTypes.Mutable()
StructTypes.omitempties(::Type{Attributes}) = (:user,)

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

end # module
