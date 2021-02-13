module FluxRM

include("api.jl")

export Broker

function version()
    major = Ref{Cint}()
    minor = Ref{Cint}()
    patch = Ref{Cint}()

    API.flux_core_version(major, minor, patch)
    Base.VersionNumber(major[], minor[], patch[])
end

mutable struct Broker
    handle::Ptr{API.flux_t}

    function Broker(handle::Ptr{API.flux_t})
        @assert handle != C_NULL
        this = new(handle)
        finalizer(this) do broker
            API.flux_close(broker)
        end
        return this
    end
end
Base.unsafe_convert(::Type{Ptr{API.flux_t}}, broker::Broker) = broker.handle
# flux_fatal_set

function Broker(uri = nothing; flags = 0)
    if uri === nothing
        uri = C_NULL
    end
    handle = API.flux_open(uri, flags)
    Libc.systemerror("flux_open", handle == C_NULL)
    Broker(handle)
end

function Base.copy(broker::Broker)
    handle = API.flux_clone(broker)
    Broker(handle)
end

function rank(broker::Broker)
    r_rank = Ref{UInt32}()
    API.flux_get_rank(broker, r_rank)
    r_rank[]
end

function size(broker::Broker)
    r_size = Ref{UInt32}()
    API.flux_get_rank(broker, r_size)
    r_size[]
end

function Base.getindex(broker::Broker, key::String)
    str = API.flux_attr_get(broker, key)
    Base.unsafe_string(str)
end

function Base.setindex!(broker::Broker, value::String, key::String)
    err = API.flux_attr_set(broker, key, value)
    Libc.systemerror("flux_attr_set", err == -1)
    value
end

end # module
