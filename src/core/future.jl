mutable struct Future
    handle::Ptr{API.flux_future_t}
    refs::IdDict{Any, Nothing}
    function Future(handle)
        this = new(handle, IdDict{Any, Nothing}())
        finalizer(this) do future
            API.flux_future_destroy(future.handle)
        end
        return this
    end
end
Base.unsafe_convert(::Type{Ptr{API.flux_future_t}}, future::Future) = future.handle