module API

include(joinpath(@__DIR__, "..", "deps", "deps.jl"))
using CEnum

include("api/ctypes.jl")

include("api/libflux_common.jl")
include("api/libflux_h.jl")

end