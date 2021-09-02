mutable struct KVS
    flux::Flux
    function KVS(flux::Flux)
        new(flux)
    end
end

function lookup(kvs::KVS, key)
    handle = API.flux_kvs_lookup(kvs.flux, C_NULL, 0, key)
    Libc.systemerror("flux_kvs_lookup", handle == C_NULL)
    future = Future(handle)
    wait(future) # Cooperative waiting

    r_buf = Ref{Ptr{Cvoid}}()
    r_len = Ref{Cint}()
    err = API.flux_kvs_lookup_get_raw(future, r_buf, r_len)
    Libc.systemerror("flux_kvs_lookup_get_raw", err == -1)

    ptr = r_buf[]
    if ptr == C_NULL
        return nothing
    end

    data = GC.@preserve future begin
        buf = Base.unsafe_wrap(Array, Base.unsafe_convert(Ptr{UInt8}, ptr), r_len[])
        copy(buf) # lifetime of buf ends with future
    end
    return JSON3.read(data)
end

mutable struct Transaction
    handle::Ptr{API.flux_kvs_txn_t}
    kvs::KVS
    function Transaction(kvs::KVS)
        handle = API.flux_kvs_txn_create()
        this = new(handle, kvs)
        finalizer(this) do txn
            API.flux_kvs_txn_destroy(txn.handle)
        end
        return this
    end
end
Base.unsafe_convert(::Type{Ptr{API.flux_kvs_txn_t}}, txn::Transaction) = txn.handle

function commit(flux::Flux, txn::Transaction, ns=C_NULL; flags=0)
    handle = API.flux_kvs_commit(flux, ns, flags, txn)
    Libc.systemerror("flux_kvs_commit", handle == C_NULL)
    fut = Future(handle)
    fut.refs[txn] = nothing # root txn in fut
    return fut
end

function fence(flux::Flux, txn::Transaction, name, nprocs, ns=C_NULL; flags=0)
    handle = API.flux_kvs_fence(flux, ns, flags, name, nprocs, txn)
    Libc.systemerror("flux_kvs_fence", handle == C_NULL)
    fut = Future(handle)
    fut.refs[txn] = nothing # root txn in fut
    return fut
end

function transaction(f, kvs::KVS)
    txn = Transaction(kvs)
    f(txn)
    future = commit(kvs.flux, txn, C_NULL)
    wait(future) # Cooperative waiting
    # TODO: add success API
    err = API.flux_future_get(future, C_NULL)
    Libc.systemerror("flux_future_get", err == -1)
end

function transaction(f, kvs::KVS, name, nprocs)
    txn = Transaction(kvs)
    f(txn)
    future = fence(kvs.flux, txn, name, nprocs, C_NULL)
    wait(future) # Cooperative waiting
    # TODO: add success API
    err = API.flux_future_get(future, C_NULL)
    Libc.systemerror("flux_future_get", err == -1)
end

function put!(txn::Transaction, key, value)
    if value === nothing
        value = C_NULL
    else
        value = JSON3.write(value)
    end

    err = API.flux_kvs_txn_put(txn, 0, key, value)
    Libc.systemerror("flux_kvs_txn_put", err == -1)
end

function mkdir!(txn::Transaction, key)
    err = API.flux_kvs_txn_mkdir(txn, 0, key)
    Libc.systemerror("flux_kvs_txn_mkdir", err == -1)
end

function unlink!(txn::Transaction, key)
    err = API.flux_kvs_txn_unlink(txn, 0, key)
    Libc.systemerror("flux_kvs_txn_unlink", err == -1)
end

function symlink!(txn::Transaction, key, target, ns=C_NULL)
    err = API.flux_kvs_txn_symlink(txn, 0, key, ns, target)
    Libc.systemerror("flux_kvs_txn_unlink", err == -1)
end
