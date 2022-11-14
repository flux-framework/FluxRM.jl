using CEnum

mutable struct hostlist end

function hostlist_count(hl)
    ccall((:hostlist_count, libflux_hostlist), Cint, (Ptr{hostlist},), hl)
end

function hostlist_create()
    ccall((:hostlist_create, libflux_hostlist), Ptr{hostlist}, ())
end

function hostlist_destroy(hl)
    ccall((:hostlist_destroy, libflux_hostlist), Cvoid, (Ptr{hostlist},), hl)
end

function hostlist_decode(s)
    ccall((:hostlist_decode, libflux_hostlist), Ptr{hostlist}, (Ptr{Cchar},), s)
end

function hostlist_encode(hl)
    ccall((:hostlist_encode, libflux_hostlist), Ptr{Cchar}, (Ptr{hostlist},), hl)
end

function hostlist_copy(hl)
    ccall((:hostlist_copy, libflux_hostlist), Ptr{hostlist}, (Ptr{hostlist},), hl)
end

function hostlist_append(hl, hosts)
    ccall((:hostlist_append, libflux_hostlist), Cint, (Ptr{hostlist}, Ptr{Cchar}), hl, hosts)
end

function hostlist_append_list(hl1, hl2)
    ccall((:hostlist_append_list, libflux_hostlist), Cint, (Ptr{hostlist}, Ptr{hostlist}), hl1, hl2)
end

function hostlist_nth(hl, n)
    ccall((:hostlist_nth, libflux_hostlist), Ptr{Cchar}, (Ptr{hostlist}, Cint), hl, n)
end

function hostlist_find(hl, hostname)
    ccall((:hostlist_find, libflux_hostlist), Cint, (Ptr{hostlist}, Ptr{Cchar}), hl, hostname)
end

function hostlist_delete(hl, hosts)
    ccall((:hostlist_delete, libflux_hostlist), Cint, (Ptr{hostlist}, Ptr{Cchar}), hl, hosts)
end

function hostlist_sort(hl)
    ccall((:hostlist_sort, libflux_hostlist), Cvoid, (Ptr{hostlist},), hl)
end

function hostlist_uniq(hl)
    ccall((:hostlist_uniq, libflux_hostlist), Cvoid, (Ptr{hostlist},), hl)
end

function hostlist_first(hl)
    ccall((:hostlist_first, libflux_hostlist), Ptr{Cchar}, (Ptr{hostlist},), hl)
end

function hostlist_last(hl)
    ccall((:hostlist_last, libflux_hostlist), Ptr{Cchar}, (Ptr{hostlist},), hl)
end

function hostlist_next(hl)
    ccall((:hostlist_next, libflux_hostlist), Ptr{Cchar}, (Ptr{hostlist},), hl)
end

function hostlist_current(hl)
    ccall((:hostlist_current, libflux_hostlist), Ptr{Cchar}, (Ptr{hostlist},), hl)
end

function hostlist_remove_current(hl)
    ccall((:hostlist_remove_current, libflux_hostlist), Cint, (Ptr{hostlist},), hl)
end

