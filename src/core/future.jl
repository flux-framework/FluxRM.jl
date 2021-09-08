const alive_futures = IdDict{Any, Nothing}()

function callback(fut::Ptr{API.flux_future_t}, arg::Ptr{Cvoid})
    future = Base.unsafe_pointer_to_objref(arg)::Future
    delete!(alive_futures, future)
    @assert fut == future.handle

    # Invoke user callback
    Base.invokelatest(future.callback, future)

    future.handle = C_NULL
    API.flux_future_destroy(fut)
    return
end

function default_callback(future)
    err = API.flux_future_get(future, C_NULL)
    if err == -1
        errno = Libc.errno()
        future.success = false
        future.result = SystemError("flux_job_wait_get_status", errno)
    else
        future.success = true
    end
    return
end

mutable struct Future
    handle::Ptr{API.flux_future_t}
    refs::IdDict{Any, Nothing}
    success::Union{Nothing, Bool}
    result::Any
    callback::Function
    function Future(handle, callback=default_callback)
        @assert handle != C_NULL
        this = new(handle, IdDict{Any, Nothing}(), nothing, nothing, callback)
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
            throw(fut.result)
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
        throw(fut.result)
    end
    return
end
