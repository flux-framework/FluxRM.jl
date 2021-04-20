mutable struct HostList
    handle::Ptr{API.hostlist}

    function HostList(arg::String)
        handle = API.hostlist_decode(arg)
        Libc.systemerror("hostlist_decode", handle == C_NULL)
        this = new(handle)

        finalizer(this) do this
            API.hostlist_destroy(this)
        end

        return this
    end
end
Base.unsafe_convert(::Type{Ptr{API.hostlist}}, hostlist::HostList) = hostlist.handle

Base.IteratorSize(::Type{HostList}) = Base.HasLength()
Base.IteratorEltype(::Type{HostList}) = Base.HasEltype()

Base.length(hostlist::HostList) = API.hostlist_count(hostlist)
Base.eltype(::HostList) = String

function Base.getindex(hostlist::HostList, idx)
    @boundscheck if !(1 <= idx <= length(hostlist))
        throw(BoundsError(hostlist, idx))
    end
    ptr = API.hostlist_nth(hostlist, idx-1)
    Base.unsafe_string(ptr)
end

function Base.iterate(hostlist::HostList, state=1)
    if state <= length(hostlist)
        return (hostlist[state], state+1)
    else
        return nothing
    end
end




