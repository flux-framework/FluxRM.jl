module FluxRM

using JSON3
import Base.Libc: RawFD
import FileWatching: poll_fd

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
    fd::RawFD

    function Flux(handle::Ptr{API.flux_t}; own=true)
        @assert handle != C_NULL
        fd = API.flux_pollfd(handle)
        systemerror("flux_pollfd", fd < 0)

        this = new(handle, RawFD(fd))
        # alternative unique through WeakRefDict?
        if own
            finalizer(this) do flux
                API.flux_close(flux)
            end
        end
        return this
    end
end
Base.unsafe_convert(::Type{Ptr{API.flux_t}}, flux::Flux) = flux.handle
# flux_fatal_set

function progress(reactor)
    while true
        rc = API.flux_reactor_run(reactor, API.FLUX_REACTOR_NOWAIT)
        rc == 0 && break # No more events
        if rc < 0
            errno = Libc.errno()
            if errno == Libc.EWOULDBLOCK || errno == Libc.EAGAIN
                continue
            end
            systemerror("flux_reactor_run", errno)
        end
    end
end

function Base.wait(flux::Flux)
    poll_fd(flux.fd, writable=true, readable=true)
    events = API.flux_pollevents(flux)
    if events & API.FLUX_POLLERR != 0
        throw(FluxError("FLUX_POLLERR"))
    end
    if events & API.FLUX_POLLIN != 0
        reactor = API.flux_get_reactor(flux)
        systemerror("flux_get_reactor", reactor == C_NULL)
        progress(reactor)
    end
end

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

include("core/idset.jl")
include("core/hostlist.jl")

end # module
