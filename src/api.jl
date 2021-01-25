module API

# using Flux_jll

# temporary hack
const libflux_core = "libflux-core"

using CEnum

include("api/ctypes.jl")

include("api/libflux_common.jl")
include("api/libflux_h.jl")

end