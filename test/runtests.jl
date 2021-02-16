using FluxRM
using Test

@test FluxRM.version() >= v"0.1.0"

@testset "Outside Flux sessions" begin
    @test_throws SystemError Broker()
end

flux_available = success(`flux env`)

if !flux_available
    @error "flux-core is not installed, skipping further tests"
    exit()
end

function flux_broker(size)
    inp = Pipe()
    out = Pipe()

    process = run(pipeline(`flux start --size=$size -- bash`, stdin=inp, stdout=out, stderr=stderr), wait=false)
    close(out.in)

    t = @async write(inp, "printenv FLUX_URI\n")
    uri = fetch(@async readline(out))

    return uri, process
end

@testset "Basic" begin
    uri, fluxp = flux_broker(4)
    flux = Broker(uri)

    @test parse(Int, flux["size"]) == 4
    @test_throws SystemError flux["size"] = "5"

    close(fluxp)
end
