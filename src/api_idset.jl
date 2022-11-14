using CEnum

mutable struct idset end

function idset_subtract(a, b)
    ccall((:idset_subtract, libflux_idset), Cint, (Ptr{idset}, Ptr{idset}), a, b)
end

@cenum idset_flags::UInt32 begin
    IDSET_FLAG_AUTOGROW = 1
    IDSET_FLAG_BRACKETS = 2
    IDSET_FLAG_RANGE = 4
end

function idset_create(size, flags)
    ccall((:idset_create, libflux_idset), Ptr{idset}, (Csize_t, Cint), size, flags)
end

function idset_destroy(idset_)
    ccall((:idset_destroy, libflux_idset), Cvoid, (Ptr{idset},), idset_)
end

function idset_copy(idset_)
    ccall((:idset_copy, libflux_idset), Ptr{idset}, (Ptr{idset},), idset_)
end

function idset_encode(idset_, flags)
    ccall((:idset_encode, libflux_idset), Ptr{Cchar}, (Ptr{idset}, Cint), idset_, flags)
end

function idset_decode(s)
    ccall((:idset_decode, libflux_idset), Ptr{idset}, (Ptr{Cchar},), s)
end

function idset_ndecode(s, len)
    ccall((:idset_ndecode, libflux_idset), Ptr{idset}, (Ptr{Cchar}, Csize_t), s, len)
end

function idset_set(idset_, id)
    ccall((:idset_set, libflux_idset), Cint, (Ptr{idset}, Cuint), idset_, id)
end

function idset_range_set(idset_, lo, hi)
    ccall((:idset_range_set, libflux_idset), Cint, (Ptr{idset}, Cuint, Cuint), idset_, lo, hi)
end

function idset_clear(idset_, id)
    ccall((:idset_clear, libflux_idset), Cint, (Ptr{idset}, Cuint), idset_, id)
end

function idset_range_clear(idset_, lo, hi)
    ccall((:idset_range_clear, libflux_idset), Cint, (Ptr{idset}, Cuint, Cuint), idset_, lo, hi)
end

function idset_test(idset_, id)
    ccall((:idset_test, libflux_idset), Bool, (Ptr{idset}, Cuint), idset_, id)
end

function idset_first(idset_)
    ccall((:idset_first, libflux_idset), Cuint, (Ptr{idset},), idset_)
end

function idset_next(idset_, prev)
    ccall((:idset_next, libflux_idset), Cuint, (Ptr{idset}, Cuint), idset_, prev)
end

function idset_last(idset_)
    ccall((:idset_last, libflux_idset), Cuint, (Ptr{idset},), idset_)
end

function idset_count(idset_)
    ccall((:idset_count, libflux_idset), Csize_t, (Ptr{idset},), idset_)
end

function idset_equal(a, arg2)
    ccall((:idset_equal, libflux_idset), Bool, (Ptr{idset}, Ptr{idset}), a, arg2)
end

function idset_union(a, b)
    ccall((:idset_union, libflux_idset), Ptr{idset}, (Ptr{idset}, Ptr{idset}), a, b)
end

function idset_add(a, b)
    ccall((:idset_add, libflux_idset), Cint, (Ptr{idset}, Ptr{idset}), a, b)
end

function idset_difference(a, b)
    ccall((:idset_difference, libflux_idset), Ptr{idset}, (Ptr{idset}, Ptr{idset}), a, b)
end

function idset_intersect(a, b)
    ccall((:idset_intersect, libflux_idset), Ptr{idset}, (Ptr{idset}, Ptr{idset}), a, b)
end

function idset_has_intersection(a, b)
    ccall((:idset_has_intersection, libflux_idset), Bool, (Ptr{idset}, Ptr{idset}), a, b)
end

const IDSET_INVALID_ID = UINT_MAX - 1

