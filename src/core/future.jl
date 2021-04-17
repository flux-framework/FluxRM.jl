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

# TODO: Integrate event loops

function Base.wait(fut::Future)
    r_result = Ref{Ptr{Cvoid}}()
    err = API.flux_future_get(fut, r_result)
    Libc.systemerror("flux_future_get", err == -1)
    return nothing
end
