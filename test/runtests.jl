using FluxRM
using Test

@test FluxRM.version() >= v"0.1.0"

@testset "Outside Flux sessions" begin
    @test_throws SystemError Flux()
end

flux_available = success(`flux env`)

if !flux_available
    @error "flux-core is not installed, skipping further tests"
    exit()
end

function start_flux(size)
    inp = Pipe()
    out = Pipe()

    process = run(pipeline(`flux start --size=$size -- bash`, stdin=inp, stdout=out, stderr=stderr), wait=false)
    close(out.in)

    t = @async write(inp, "printenv FLUX_URI\n")
    uri = fetch(@async readline(out))

    return uri, process
end
function with_flux(f, size)
    uri, fluxp = start_flux(size)
    try
        flux = Flux(uri)
        f(flux)
    finally
        close(fluxp)
    end
end

@testset "Basic" begin
    with_flux(4) do flux
        @test FluxRM.size(flux) == 4
        @test parse(Int, flux["size"]) == 4
        @test_throws SystemError flux["size"] = "5"
    end
end

include("jobspec.jl")

@testset "KVS" begin
    with_flux(1) do flux
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

    with_flux(1) do flux
        jobsub = FluxRM.submit(flux, jobspec)
        job = FluxRM.Job(jobsub)
        wait(job)
    end

    jobspec = JobSpec.from_command(`sleep inf`, num_tasks=2)

    # with_flux(1) do flux
    #     jobsub = FluxRM.submit(flux, jobspec)
    #     job = FluxRM.Job(jobsub)
    #     kill(job) # fails with Invalid argument
    # end

    with_flux(1) do flux
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

    with_flux(1) do flux
        jobsub = FluxRM.submit(flux, jobspec)
        job = FluxRM.Job(jobsub)
        @test job.id > 0
        wait(job)
    end
end

@testset "from_nest_command launch" begin
    jobspec = JobSpec.from_nest_command(`sleep 0`)

    with_flux(1) do flux
        jobsub = FluxRM.submit(flux, jobspec)
        job = FluxRM.Job(jobsub)
        @test job.id > 0
        wait(job)
    end
end
