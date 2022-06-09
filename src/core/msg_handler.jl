function FLUX_MATCH_ANY()
    API.flux_match_init(
        API.FLUX_MSGTYPE_ANY,
        API.FLUX_MATCHTAG_NONE,
        C_NULL)
end

function FLUX_MATCH_EVENT()
    API.flux_match_init(
        API.FLUX_MSGTYPE_EVENT,
        API.FLUX_MATCHTAG_NONE,
        C_NULL)
end

function FLUX_MATCH_REQUEST()
    API.flux_match_init(
        API.FLUX_MSGTYPE_REQUEST,
        API.FLUX_MATCHTAG_NONE,
        C_NULL)
end

function FLUX_MATCH_RESPONSE()
    API.flux_match_init(
        API.FLUX_MSGTYPE_RESPONSE,
        API.FLUX_MATCHTAG_NONE,
        C_NULL)
end

function handler_callback(flux, mh, msg, arg)
    handler = Base.unsafe_pointer_to_objref(arg)::MsgHandler
    handler.callback(Flux(flux, own=false), msg)
    return nothing
end

mutable struct MsgHandler
    handle::Ptr{API.flux_msg_handler_t}
    callback::Function

    function MsgHandler(flux::Flux, callback, match=FLUX_MATCH_ANY())
        this = new(C_NULL)
        handle = API.flux_msg_handler_create(
            flux,
            match,
            @cfunction(handler_callback, Cvoid, (Ptr{API.flux_t}, Ptr{API.flux_msg_handler_t}, Ptr{API.flux_msg_t}, Ptr{Cvoid})),
            Base.pointer_from_objref(this))
        this.handle = handle

        finalizer(this) do this
            API.flux_msg_handler_destroy(this)
        end
        return this
    end
end
Base.unsafe_convert(::Type{Ptr{API.flux_msg_handler_t}}, msg_handler::MsgHandler) = msg_handler.handle


function start(msg_handler::MsgHandler)
    API.flux_msg_handler_start(msg_handler)
end

function stop(msg_handler::MsgHandler)
    API.flux_msg_handler_stop(msg_handler)
end
