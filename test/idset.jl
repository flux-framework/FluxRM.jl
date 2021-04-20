@testset "IDSet" begin
    @test_throws SystemError FluxRM.IDSet("-1")
    let idset = FluxRM.IDSet("0-10")
        @test 3 ∈ idset
        @test 11 ∉ idset
        @test length(idset) == 11
        @test length(collect(idset)) == 11
    end
end