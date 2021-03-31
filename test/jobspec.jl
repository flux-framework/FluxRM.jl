using FluxRM.JobSpec
using JSON3
using Test

roundtrip(x::T) where T = JSON3.read(JSON3.write(x), T)

@testset "JSON" begin
    @testset "IntraNodeResource" begin
        gpu = roundtrip(GPU(5))
        @test gpu.count == 5
        core = roundtrip(CPUCore(5))
        @test core.count == 5
    end

    @testset "Resources" begin
        slot = Slot(label="slot", count=5, exclusive=true, with=[CPUCore(16)])
        slot = roundtrip(slot)
        @test slot.exclusive == true
        @test slot.label == "slot"
        @test slot.count == 5
        core = first(slot.with)
        @test core isa CPUCore
        @test core.count == 16
        @test core.type == "core"

        slot = Slot(label="slot", count=5, with=[CPUCore(16), GPU(1)])
        slot = roundtrip(slot)
        @test slot.exclusive === nothing
        @test length(slot.with) == 2
        core = findfirst(r->r.type == "core", slot.with)
        gpu = findfirst(r->r.type == "gpu", slot.with)
        @test core !== nothing
        @test gpu !== nothing
        core = slot.with[core]
        gpu = slot.with[gpu]
        @test core isa CPUCore
        @test gpu isa GPU
        @test core.count == 16
        @test gpu.count == 1

        node = Node(count = 4, with=[slot])
        node = roundtrip(node)
        @test node.count == 4
        slot = first(node.with)
        @test slot isa Slot
    end

    @testset "Task" begin
        task = JobSpec.Task(["hostname"], "slot", Count(total=2))
        task = roundtrip(task)
        @test task.slot == "slot"
        @test task.count.per_slot === nothing
        @test task.count.total == 2
    end

    @testset "System" begin
        system = roundtrip(System(duration=3600)) 
        @test system.duration == 3600
    end

    @testset "Attributes" begin
        attr = roundtrip(Attributes(system=System(duration=3600)))
        @test attr.system.duration == 3600
    end

    @testset "JobSpec" begin
        slot = Slot(label="slot", count=5, with=[CPUCore(16)])
        task = JobSpec.Task(["hostname"], "slot", Count(total=2))
        jobspec = JobspecV1([slot], [task], Attributes(system=System(duration=3600)))
        jobspec = roundtrip(jobspec)

        jobspec = """
        {
            "version": 1,
            "resources": [
                {
                    "type": "node",
                    "count": 1,
                    "with": [
                        {
                            "type": "slot",
                            "label": "mylabel",
                            "count": 4,
                            "with": [
                                {
                                    "type": "core",
                                    "count": 1
                                }
                            ]
                        }
                    ]

                }
            ],
            "tasks": [
                {
                    "command": [ "whoami" ],
                    "slot": "mylabel",
                    "count": {
                        "total": 2
                    }
                }
            ],
            "attributes": {
                "system": {
                    "duration": 3600
                }
            }
        }
        """
        jobspec = JSON3.read(jobspec, Jobspec)
        command = first(jobspec.tasks).command
        @test first(command) == "whoami"
        @test first(jobspec.resources) isa Node
    end
end

