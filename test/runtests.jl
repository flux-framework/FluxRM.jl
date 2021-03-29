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
        @test parse(Int, flux["size"]) == 4
        @test_throws SystemError flux["size"] = "5"
    end
end

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

