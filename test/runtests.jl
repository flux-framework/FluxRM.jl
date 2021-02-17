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

@testset "Basic" begin
    uri, fluxp = start_flux(4)
    flux = Flux(uri)

    @test parse(Int, flux["size"]) == 4
    @test_throws SystemError flux["size"] = "5"

    close(fluxp)
end
