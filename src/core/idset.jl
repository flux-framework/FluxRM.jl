mutable struct IDSet
    handle::Ptr{API.idset}

    function IDSet(arg::String)
        handle = API.idset_decode(arg)
        Libc.systemerror("idset_decode", handle == C_NULL)
        this = new(handle)

        finalizer(this) do this
            API.idset_destroy(this)
        end

        return this
    end
end
Base.unsafe_convert(::Type{Ptr{API.idset}}, idset::IDSet) = idset.handle

Base.IteratorSize(::Type{IDSet}) = Base.HasLength()
Base.IteratorEltype(::Type{IDSet}) = Base.HasEltype()

Base.length(idset::IDSet) = API.idset_count(idset)
Base.eltype(::IDSet) = Cuint

Base.in(item, idset::IDSet) = API.idset_test(idset, item)

function Base.iterate(idset::IDSet, state=nothing)
    if state === nothing
        value = API.idset_first(idset)
    else
        value = API.idset_next(idset, state)
    end

    if value == API.IDSET_INVALID_ID
        return nothing
    else
        return (value, value)
    end
end
