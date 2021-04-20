module FluxRM

using JSON3

include("api.jl")

export Flux

function version()
    major = Ref{Cint}()
    minor = Ref{Cint}()
    patch = Ref{Cint}()

    API.flux_core_version(major, minor, patch)
    Base.VersionNumber(major[], minor[], patch[])
end

mutable struct Flux
    handle::Ptr{API.flux_t}

    function Flux(handle::Ptr{API.flux_t})
        @assert handle != C_NULL
        this = new(handle)
        finalizer(this) do flux
            API.flux_close(flux)
        end
        return this
    end
end
Base.unsafe_convert(::Type{Ptr{API.flux_t}}, flux::Flux) = flux.handle
# flux_fatal_set

function Flux(uri = nothing; flags = 0)
    if uri === nothing
        uri = C_NULL
    end
    handle = API.flux_open(uri, flags)
    Libc.systemerror("flux_open", handle == C_NULL)
    Flux(handle)
end

function Base.copy(flux::Flux)
    handle = API.flux_clone(flux)
    Flux(handle)
end

function rank(flux::Flux)
    r_rank = Ref{UInt32}()
    API.flux_get_rank(flux, r_rank)
    r_rank[]
end

function size(flux::Flux)
    r_size = Ref{UInt32}()
    API.flux_get_size(flux, r_size)
    r_size[]
end

function Base.getindex(flux::Flux, key::String)
    str = API.flux_attr_get(flux, key)
    Base.unsafe_string(str)
end

function Base.setindex!(flux::Flux, value::String, key::String)
    err = API.flux_attr_set(flux, key, value)
    Libc.systemerror("flux_attr_set", err == -1)
    value
end

include("core/future.jl")
include("core/kvs.jl")
include("core/rpc.jl")

include("jobspec.jl")
include("core/job.jl")

end # module
