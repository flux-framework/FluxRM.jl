function rpc_callback(future)
    r_buf = Ref{Ptr{Cvoid}}()
    r_len = Ref{Cint}()
    err = API.flux_rpc_get_raw(future, r_buf, r_len)

    if err == -1
        errno = Libc.errno()
        future.success = false
        future.result = SystemError("flux_rpc_get_raw", errno)
        return
    end
    future.success = true

    ptr = r_buf[]
    if ptr == C_NULL
        future.result = nothing
        return
    end

    buf = Base.unsafe_wrap(Array, Base.unsafe_convert(Ptr{UInt8}, ptr), r_len[])
    future.result = copy(buf) # lifetime of buf ends with future handle

    return
end

struct RPC
    flux::Flux
    future::Future

    function RPC(flux::Flux, topic, payload=nothing; nodeid=API.FLUX_NODEID_ANY, flags=0)
        if payload === nothing
            payload = C_NULL
        else
            payload = JSON3.write(payload)
        end
        handle = API.flux_rpc(flux, topic, payload, nodeid, flags)
        new(flux, Future(handle, rpc_callback))
    end
end

function Base.fetch(rpc::RPC)
    future = rpc.future
    wait(future)

    result = future.result
    if result === nothing
        return nothing
    end
    result::Vector{UInt8}

    return JSON3.read(result)
end
