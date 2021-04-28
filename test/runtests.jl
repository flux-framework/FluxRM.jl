using FluxRM
using Test

@test FluxRM.version() >= v"0.1.0"

if !haskey(ENV, "FLUX_URI")
    @testset "Outside Flux sessions" begin
        @test_throws SystemError Flux()
    end

    flux_available = try
        success(`flux env`)
    catch
        false
    end

    if !flux_available
        @error "flux-core is not installed, skipping further tests"
        exit()
    end

    @info "relaunching under Flux"
    current_file = @__FILE__ # bug in 1.5 can't be directly interpolated
    jlcmd = `$(Base.julia_cmd()) $(current_file)`
    cmd = `flux start -o,-Slog-forward-level=7 -- $jlcmd`
    @test success(pipeline(cmd, stdout=stdout, stderr=stderr))
    exit()
end

@testset "Basic" begin
    let flux = Flux()
        @test parse(Int, flux["size"]) == FluxRM.size(flux)
        @test_throws SystemError flux["size"] = "5"
    end
end

include("jobspec.jl")
include("idset.jl")
include("hostlist.jl")

@testset "KVS" begin
    let flux = Flux()
        kvs = FluxRM.KVS(flux)

        @test_throws SystemError FluxRM.lookup(kvs, "test")

        # Test fence transaction
        FluxRM.transaction(kvs, "fence", 1) do txn
            FluxRM.put!(txn, "test", "value")
        end
        @test FluxRM.lookup(kvs, "test") == "value"

        FluxRM.transaction(kvs) do txn
            FluxRM.put!(txn, "test", nothing)
        end
        @test FluxRM.lookup(kvs, "test") === nothing

        FluxRM.transaction(kvs) do txn
            FluxRM.mkdir!(txn, "testdir")
            FluxRM.put!(txn, "testdir.test", "value")
            FluxRM.unlink!(txn, "test")
            FluxRM.symlink!(txn, "test", "testdir.test")
        end
        @test FluxRM.lookup(kvs, "test") == "value"
    end
end

@testset "Job launch" begin
    jobspec = JobSpec.from_command(`sleep 1`, num_tasks=2)

    let flux = Flux()
        jobsub = FluxRM.submit(flux, jobspec)
        job = FluxRM.Job(jobsub)
        wait(job)
    end


    jobspec = JobSpec.from_command(`sleep inf`, num_tasks=2)

    let flux = Flux()
        jobsub = FluxRM.submit(flux, jobspec)
        job = FluxRM.Job(jobsub)
        kill(job)
    end

    let flux = Flux()
        jobsub = FluxRM.submit(flux, jobspec)
        job = FluxRM.Job(jobsub)
        FluxRM.cancel(job)

        jobsub = FluxRM.submit(flux, jobspec)
        job = FluxRM.Job(jobsub)
        jobstr = FluxRM.encode(job)
        @test isvalid(jobstr)
        job2 = FluxRM.Job(flux, jobstr)
        FluxRM.cancel(job2)
        @test_throws ErrorException wait(job)
    end
end

@testset "from_batch_command launch" begin
    @test_throws AssertionError JobSpec.from_batch_command("sleep 0", "missing shebang")

    script = """
    #!/bin/sh

    sleep 0
    """
    jobspec = JobSpec.from_batch_command(script, "nested_sleep")

    let flux = Flux()
        jobsub = FluxRM.submit(flux, jobspec)
        job = FluxRM.Job(jobsub)
        @test job.id > 0
        wait(job)
    end
end

@testset "from_nest_command launch" begin
    jobspec = JobSpec.from_nest_command(`sleep 0`)

    let flux = Flux()
        jobsub = FluxRM.submit(flux, jobspec)
        job = FluxRM.Job(jobsub)
        @test job.id > 0
        wait(job)
    end
end

@testset "RPC" begin
    let flux = Flux()
        rpc = FluxRM.RPC(Flux(), "broker.ping", Dict("seq"=>1, "pad"=>"stuff"))
        response = fetch(rpc)
        @test response.seq == 1
        @test response.pad == "stuff"
    end
end
