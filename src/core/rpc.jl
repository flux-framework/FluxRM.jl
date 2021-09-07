struct RPC
    flux::Flux
    future::Ptr{API.flux_future_t}
    # future::Future

    function RPC(flux::Flux, topic, payload=nothing; nodeid=API.FLUX_NODEID_ANY, flags=0)
        if payload === nothing
            payload = C_NULL
        else
            payload = JSON3.write(payload)
        end
        handle = API.flux_rpc(flux, topic, payload, nodeid, flags)
        # new(flux, Future(handle))
        new(flux, handle)
    end
end

function Base.fetch(rpc::RPC)
    future = rpc.future

    # FIXME: Can't call wait since we will lose the data below
    # wait(future) # Cooperative waiting

    r_buf = Ref{Ptr{Cvoid}}()
    r_len = Ref{Cint}()
    err = API.flux_rpc_get_raw(future, r_buf, r_len)
    Libc.systemerror("flux_rpc_get_raw", err == -1)

    ptr = r_buf[]
    if ptr == C_NULL
        API.flux_future_destroy(future)
        return nothing
    end

    # data = GC.@preserve future begin
        buf = Base.unsafe_wrap(Array, Base.unsafe_convert(Ptr{UInt8}, ptr), r_len[])
        data = copy(buf) # lifetime of buf ends with future
    # end
    API.flux_future_destroy(future)
    return JSON3.read(data)
end
