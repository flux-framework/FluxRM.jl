mutable struct Transaction
    handle::Ptr{API.flux_kvs_txn_t}
    function Transaction()
        handle = API.flux_kvs_txn_create()
        this = new(handle)
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

mutable struct KVS
    flux::Flux
    current_txn::Transaction
    lock::Base.ReentrantLock
    function KVS(flux::Flux)
        new(flux, Transaction(), Base.ReentrantLock())
    end
end
function exchange_transaction!(kvs::KVS)
    txn = lock(kvs.lock) do
        txn = kvs.current_txn
        kvs.current_txn = Transaction()
        txn
    end
    return txn
end

function commit(kvs::KVS)
    txn = exchange_transaction!(kvs)
    future = commit(kvs.flux, txn, C_NULL)
    API.flux_future_get(future, C_NULL)
end

function fence(kvs::KVS, name, nprocs)
    txn = exchange_transaction!(kvs)
    future = fence(kvs.flux, txn, name, nprocs, C_NULL)
    API.flux_future_get(future, C_NULL)
end

function lookup(kvs::KVS, key)
    handle = API.flux_kvs_lookup(kvs.flux, C_NULL, 0, key)
    Libc.systemerror("flux_kvs_lookup", handle == C_NULL)
    future = Future(handle)

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

function put!(kvs::KVS, key, value)
    if value === nothing
        value = C_NULL
    else
        value = JSON3.write(value)
    end

    lock(kvs.lock) do
        txn = kvs.current_txn

        err = API.flux_kvs_txn_put(txn, 0, key, value)
        Libc.systemerror("flux_kvs_txn_put", err == -1)
    end
end