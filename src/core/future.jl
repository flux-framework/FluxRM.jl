mutable struct Future
    handle::Ptr{API.flux_future_t}
    refs::IdDict{Any, Nothing}
    function Future(handle)
        @assert handle != C_NULL
        this = new(handle, IdDict{Any, Nothing}())
        finalizer(this) do future
            API.flux_future_destroy(future.handle)
        end
        return this
    end
end
Base.unsafe_convert(::Type{Ptr{API.flux_future_t}}, future::Future) = future.handle

function Base.wait(fut::Future)
    if API.flux_future_is_ready(fut)
        return
    end

    flux = let
        handle = API.flux_future_get_flux(fut)
        Flux(handle, own=false)
    end

    while !API.flux_future_is_ready(fut)
        wait(flux) # cooperative wait, using poll_fd,
        reactor = API.flux_future_get_reactor(fut)
        progress(reactor)
    end
    return nothing
end
