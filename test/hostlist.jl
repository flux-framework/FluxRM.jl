@testset "HostList" begin
    @test_throws SystemError FluxRM.HostList("[host]")

    let hostlist = FluxRM.HostList("host")
        @test length(hostlist) == 1
        @test collect(hostlist) == ["host"]

        @test_throws BoundsError hostlist[0]
        @test_throws BoundsError hostlist[2]
        @test hostlist[1] == "host"
    end
end
