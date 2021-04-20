include(joinpath(@__DIR__, "..", "deps", "deps.jl"))

const pid_t = Cint
const UINT_MAX = typemax(Cuint)

include("api_hostlist.jl")
include("api_idset.jl")
