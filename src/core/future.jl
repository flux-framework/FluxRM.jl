const alive_futures = IdDict{Any, Nothing}()

function callback(fut, arg)
    future = Base.unsafe_pointer_to_objref(arg)::Future
    delete!(alive_futures, future)
    @assert fut == future.handle # TODO: GC handling
    err = API.flux_future_get(fut, C_NULL)
    if err == -1
        future.success = false
        future.errno   = Libc.errno()
    else
        future.success = true
    end
    future.handle  = C_NULL
    API.flux_future_destroy(fut)
    return nothing
end

mutable struct Future
    handle::Ptr{API.flux_future_t}
    refs::IdDict{Any, Nothing}
    success::Union{Nothing, Bool}
    errno::Int
    function Future(handle)
        @assert handle != C_NULL
        this = new(handle, IdDict{Any, Nothing}(), nothing, 0)
        alive_futures[this] = nothing
        API.flux_future_then(this,
            -1.0,
            @cfunction(callback, Cvoid, (Ptr{API.flux_future_t}, Ptr{Cvoid})),
            Base.pointer_from_objref(this))
        return this
    end
end
Base.unsafe_convert(::Type{Ptr{API.flux_future_t}}, future::Future) = future.handle

function Base.wait(fut::Future)
    if fut.success !== nothing
        @assert fut.handle === C_NULL
        if !fut.success
            systemerror("flux_future_get", fut.errno)
        end
        return
    end

    flux = let
        handle = API.flux_future_get_flux(fut)
        Flux(handle, own=false)
    end

    while fut.success === nothing
        wait(flux) # cooperative wait, using poll_fd,
        # The future reactor should never differ from the handle reactor
        # reactor = API.flux_future_get_reactor(fut)
        # progress(reactor)
    end
    if !fut.success
        systemerror("flux_future_get", fut.errno)
    end
    return
end
