# Julia wrapper for header: _core_preproc.h
# Automatically generated using Clang.jl


function flux_match_init(typemask, matchtag, topic_glob)
    ccall((:flux_match_init, libflux_core), flux_match, (Cint, UInt32, Cstring), typemask, matchtag, topic_glob)
end

function flux_match_free(m)
    ccall((:flux_match_free, libflux_core), Cvoid, (flux_match,), m)
end

function flux_msg_create(type)
    ccall((:flux_msg_create, libflux_core), Ptr{flux_msg_t}, (Cint,), type)
end

function flux_msg_destroy(msg)
    ccall((:flux_msg_destroy, libflux_core), Cvoid, (Ptr{flux_msg_t},), msg)
end

function flux_msg_aux_set(msg, name, aux, destroy)
    ccall((:flux_msg_aux_set, libflux_core), Cint, (Ptr{flux_msg_t}, Cstring, Ptr{Cvoid}, flux_free_f), msg, name, aux, destroy)
end

function flux_msg_aux_get(msg, name)
    ccall((:flux_msg_aux_get, libflux_core), Ptr{Cvoid}, (Ptr{flux_msg_t}, Cstring), msg, name)
end

function flux_msg_copy(msg, payload)
    ccall((:flux_msg_copy, libflux_core), Ptr{flux_msg_t}, (Ptr{flux_msg_t}, Bool), msg, payload)
end

function flux_msg_incref(msg)
    ccall((:flux_msg_incref, libflux_core), Ptr{flux_msg_t}, (Ptr{flux_msg_t},), msg)
end

function flux_msg_decref(msg)
    ccall((:flux_msg_decref, libflux_core), Cvoid, (Ptr{flux_msg_t},), msg)
end

function flux_msg_encode_size(msg)
    ccall((:flux_msg_encode_size, libflux_core), Csize_t, (Ptr{flux_msg_t},), msg)
end

function flux_msg_encode(msg, buf, size)
    ccall((:flux_msg_encode, libflux_core), Cint, (Ptr{flux_msg_t}, Ptr{Cvoid}, Csize_t), msg, buf, size)
end

function flux_msg_frames(msg)
    ccall((:flux_msg_frames, libflux_core), Cint, (Ptr{flux_msg_t},), msg)
end

function flux_msg_decode(buf, size)
    ccall((:flux_msg_decode, libflux_core), Ptr{flux_msg_t}, (Ptr{Cvoid}, Csize_t), buf, size)
end

function flux_msg_sendzsock(dest, msg)
    ccall((:flux_msg_sendzsock, libflux_core), Cint, (Ptr{Cvoid}, Ptr{flux_msg_t}), dest, msg)
end

function flux_msg_recvzsock(dest)
    ccall((:flux_msg_recvzsock, libflux_core), Ptr{flux_msg_t}, (Ptr{Cvoid},), dest)
end

function flux_msg_set_type(msg, type)
    ccall((:flux_msg_set_type, libflux_core), Cint, (Ptr{flux_msg_t}, Cint), msg, type)
end

function flux_msg_get_type(msg, type)
    ccall((:flux_msg_get_type, libflux_core), Cint, (Ptr{flux_msg_t}, Ptr{Cint}), msg, type)
end

function flux_msg_set_private(msg)
    ccall((:flux_msg_set_private, libflux_core), Cint, (Ptr{flux_msg_t},), msg)
end

function flux_msg_is_private(msg)
    ccall((:flux_msg_is_private, libflux_core), Bool, (Ptr{flux_msg_t},), msg)
end

function flux_msg_set_streaming(msg)
    ccall((:flux_msg_set_streaming, libflux_core), Cint, (Ptr{flux_msg_t},), msg)
end

function flux_msg_is_streaming(msg)
    ccall((:flux_msg_is_streaming, libflux_core), Bool, (Ptr{flux_msg_t},), msg)
end

function flux_msg_set_noresponse(msg)
    ccall((:flux_msg_set_noresponse, libflux_core), Cint, (Ptr{flux_msg_t},), msg)
end

function flux_msg_is_noresponse(msg)
    ccall((:flux_msg_is_noresponse, libflux_core), Bool, (Ptr{flux_msg_t},), msg)
end

function flux_msg_set_topic(msg, topic)
    ccall((:flux_msg_set_topic, libflux_core), Cint, (Ptr{flux_msg_t}, Cstring), msg, topic)
end

function flux_msg_get_topic(msg, topic)
    ccall((:flux_msg_get_topic, libflux_core), Cint, (Ptr{flux_msg_t}, Ptr{Cstring}), msg, topic)
end

function flux_msg_get_payload(msg, buf, size)
    ccall((:flux_msg_get_payload, libflux_core), Cint, (Ptr{flux_msg_t}, Ptr{Ptr{Cvoid}}, Ptr{Cint}), msg, buf, size)
end

function flux_msg_set_payload(msg, buf, size)
    ccall((:flux_msg_set_payload, libflux_core), Cint, (Ptr{flux_msg_t}, Ptr{Cvoid}, Cint), msg, buf, size)
end

function flux_msg_has_payload(msg)
    ccall((:flux_msg_has_payload, libflux_core), Bool, (Ptr{flux_msg_t},), msg)
end

function flux_msg_get_flags(msg, flags)
    ccall((:flux_msg_get_flags, libflux_core), Cint, (Ptr{flux_msg_t}, Ptr{UInt8}), msg, flags)
end

function flux_msg_set_flags(msg, flags)
    ccall((:flux_msg_set_flags, libflux_core), Cint, (Ptr{flux_msg_t}, UInt8), msg, flags)
end

function flux_msg_set_string(msg, arg1)
    ccall((:flux_msg_set_string, libflux_core), Cint, (Ptr{flux_msg_t}, Cstring), msg, arg1)
end

function flux_msg_get_string(msg, s)
    ccall((:flux_msg_get_string, libflux_core), Cint, (Ptr{flux_msg_t}, Ptr{Cstring}), msg, s)
end

function flux_msg_last_error(msg)
    ccall((:flux_msg_last_error, libflux_core), Cstring, (Ptr{flux_msg_t},), msg)
end

function flux_msg_set_nodeid(msg, nodeid)
    ccall((:flux_msg_set_nodeid, libflux_core), Cint, (Ptr{flux_msg_t}, UInt32), msg, nodeid)
end

function flux_msg_get_nodeid(msg, nodeid)
    ccall((:flux_msg_get_nodeid, libflux_core), Cint, (Ptr{flux_msg_t}, Ptr{UInt32}), msg, nodeid)
end

function flux_msg_set_userid(msg, userid)
    ccall((:flux_msg_set_userid, libflux_core), Cint, (Ptr{flux_msg_t}, UInt32), msg, userid)
end

function flux_msg_get_userid(msg, userid)
    ccall((:flux_msg_get_userid, libflux_core), Cint, (Ptr{flux_msg_t}, Ptr{UInt32}), msg, userid)
end

function flux_msg_set_rolemask(msg, rolemask)
    ccall((:flux_msg_set_rolemask, libflux_core), Cint, (Ptr{flux_msg_t}, UInt32), msg, rolemask)
end

function flux_msg_get_rolemask(msg, rolemask)
    ccall((:flux_msg_get_rolemask, libflux_core), Cint, (Ptr{flux_msg_t}, Ptr{UInt32}), msg, rolemask)
end

function flux_msg_get_cred(msg, cred)
    ccall((:flux_msg_get_cred, libflux_core), Cint, (Ptr{flux_msg_t}, Ptr{flux_msg_cred}), msg, cred)
end

function flux_msg_set_cred(msg, cred)
    ccall((:flux_msg_set_cred, libflux_core), Cint, (Ptr{flux_msg_t}, flux_msg_cred), msg, cred)
end

function flux_msg_cred_authorize(cred, userid)
    ccall((:flux_msg_cred_authorize, libflux_core), Cint, (flux_msg_cred, UInt32), cred, userid)
end

function flux_msg_authorize(msg, userid)
    ccall((:flux_msg_authorize, libflux_core), Cint, (Ptr{flux_msg_t}, UInt32), msg, userid)
end

function flux_msg_set_errnum(msg, errnum)
    ccall((:flux_msg_set_errnum, libflux_core), Cint, (Ptr{flux_msg_t}, Cint), msg, errnum)
end

function flux_msg_get_errnum(msg, errnum)
    ccall((:flux_msg_get_errnum, libflux_core), Cint, (Ptr{flux_msg_t}, Ptr{Cint}), msg, errnum)
end

function flux_msg_set_seq(msg, seq)
    ccall((:flux_msg_set_seq, libflux_core), Cint, (Ptr{flux_msg_t}, UInt32), msg, seq)
end

function flux_msg_get_seq(msg, seq)
    ccall((:flux_msg_get_seq, libflux_core), Cint, (Ptr{flux_msg_t}, Ptr{UInt32}), msg, seq)
end

function flux_msg_set_status(msg, status)
    ccall((:flux_msg_set_status, libflux_core), Cint, (Ptr{flux_msg_t}, Cint), msg, status)
end

function flux_msg_get_status(msg, status)
    ccall((:flux_msg_get_status, libflux_core), Cint, (Ptr{flux_msg_t}, Ptr{Cint}), msg, status)
end

function flux_msg_set_matchtag(msg, matchtag)
    ccall((:flux_msg_set_matchtag, libflux_core), Cint, (Ptr{flux_msg_t}, UInt32), msg, matchtag)
end

function flux_msg_get_matchtag(msg, matchtag)
    ccall((:flux_msg_get_matchtag, libflux_core), Cint, (Ptr{flux_msg_t}, Ptr{UInt32}), msg, matchtag)
end

function flux_msg_cmp_matchtag(msg, matchtag)
    ccall((:flux_msg_cmp_matchtag, libflux_core), Bool, (Ptr{flux_msg_t}, UInt32), msg, matchtag)
end

function flux_msg_cmp(msg, match)
    ccall((:flux_msg_cmp, libflux_core), Bool, (Ptr{flux_msg_t}, flux_match), msg, match)
end

function flux_msg_fprint(f, msg)
    ccall((:flux_msg_fprint, libflux_core), Cvoid, (Ptr{FILE}, Ptr{flux_msg_t}), f, msg)
end

function flux_msg_typestr(type)
    ccall((:flux_msg_typestr, libflux_core), Cstring, (Cint,), type)
end

function flux_msg_enable_route(msg)
    ccall((:flux_msg_enable_route, libflux_core), Cint, (Ptr{flux_msg_t},), msg)
end

function flux_msg_clear_route(msg)
    ccall((:flux_msg_clear_route, libflux_core), Cint, (Ptr{flux_msg_t},), msg)
end

function flux_msg_push_route(msg, id)
    ccall((:flux_msg_push_route, libflux_core), Cint, (Ptr{flux_msg_t}, Cstring), msg, id)
end

function flux_msg_pop_route(msg, id)
    ccall((:flux_msg_pop_route, libflux_core), Cint, (Ptr{flux_msg_t}, Ptr{Cstring}), msg, id)
end

function flux_msg_get_route_first(msg, id)
    ccall((:flux_msg_get_route_first, libflux_core), Cint, (Ptr{flux_msg_t}, Ptr{Cstring}), msg, id)
end

function flux_msg_get_route_last(msg, id)
    ccall((:flux_msg_get_route_last, libflux_core), Cint, (Ptr{flux_msg_t}, Ptr{Cstring}), msg, id)
end

function flux_msg_get_route_count(msg)
    ccall((:flux_msg_get_route_count, libflux_core), Cint, (Ptr{flux_msg_t},), msg)
end

function flux_msg_get_route_string(msg)
    ccall((:flux_msg_get_route_string, libflux_core), Cstring, (Ptr{flux_msg_t},), msg)
end

function flux_open(uri, flags)
    ccall((:flux_open, libflux_core), Ptr{flux_t}, (Cstring, Cint), uri, flags)
end

function flux_close(h)
    ccall((:flux_close, libflux_core), Cvoid, (Ptr{flux_t},), h)
end

function flux_incref(h)
    ccall((:flux_incref, libflux_core), Ptr{flux_t}, (Ptr{flux_t},), h)
end

function flux_decref(h)
    ccall((:flux_decref, libflux_core), Cvoid, (Ptr{flux_t},), h)
end

function flux_clone(orig)
    ccall((:flux_clone, libflux_core), Ptr{flux_t}, (Ptr{flux_t},), orig)
end

function flux_opt_set(h, option, val, len)
    ccall((:flux_opt_set, libflux_core), Cint, (Ptr{flux_t}, Cstring, Ptr{Cvoid}, Csize_t), h, option, val, len)
end

function flux_opt_get(h, option, val, len)
    ccall((:flux_opt_get, libflux_core), Cint, (Ptr{flux_t}, Cstring, Ptr{Cvoid}, Csize_t), h, option, val, len)
end

function flux_fatal_set(h, fun, arg)
    ccall((:flux_fatal_set, libflux_core), Cvoid, (Ptr{flux_t}, flux_fatal_f, Ptr{Cvoid}), h, fun, arg)
end

function flux_fatal_error(h, fun, msg)
    ccall((:flux_fatal_error, libflux_core), Cvoid, (Ptr{flux_t}, Cstring, Cstring), h, fun, msg)
end

function flux_fatality(h)
    ccall((:flux_fatality, libflux_core), Bool, (Ptr{flux_t},), h)
end

function flux_aux_get(h, name)
    ccall((:flux_aux_get, libflux_core), Ptr{Cvoid}, (Ptr{flux_t}, Cstring), h, name)
end

function flux_aux_set(h, name, aux, destroy)
    ccall((:flux_aux_set, libflux_core), Cint, (Ptr{flux_t}, Cstring, Ptr{Cvoid}, flux_free_f), h, name, aux, destroy)
end

function flux_flags_set(h, flags)
    ccall((:flux_flags_set, libflux_core), Cvoid, (Ptr{flux_t}, Cint), h, flags)
end

function flux_flags_unset(h, flags)
    ccall((:flux_flags_unset, libflux_core), Cvoid, (Ptr{flux_t}, Cint), h, flags)
end

function flux_flags_get(h)
    ccall((:flux_flags_get, libflux_core), Cint, (Ptr{flux_t},), h)
end

function flux_matchtag_alloc(h)
    ccall((:flux_matchtag_alloc, libflux_core), UInt32, (Ptr{flux_t},), h)
end

function flux_matchtag_free(h, matchtag)
    ccall((:flux_matchtag_free, libflux_core), Cvoid, (Ptr{flux_t}, UInt32), h, matchtag)
end

function flux_matchtag_avail(h)
    ccall((:flux_matchtag_avail, libflux_core), UInt32, (Ptr{flux_t},), h)
end

function flux_send(h, msg, flags)
    ccall((:flux_send, libflux_core), Cint, (Ptr{flux_t}, Ptr{flux_msg_t}, Cint), h, msg, flags)
end

function flux_recv(h, match, flags)
    ccall((:flux_recv, libflux_core), Ptr{flux_msg_t}, (Ptr{flux_t}, flux_match, Cint), h, match, flags)
end

function flux_requeue(h, msg, flags)
    ccall((:flux_requeue, libflux_core), Cint, (Ptr{flux_t}, Ptr{flux_msg_t}, Cint), h, msg, flags)
end

function flux_requeue_nocopy(h, msg, flags)
    ccall((:flux_requeue_nocopy, libflux_core), Cint, (Ptr{flux_t}, Ptr{flux_msg_t}, Cint), h, msg, flags)
end

function flux_pollevents(h)
    ccall((:flux_pollevents, libflux_core), Cint, (Ptr{flux_t},), h)
end

function flux_pollfd(h)
    ccall((:flux_pollfd, libflux_core), Cint, (Ptr{flux_t},), h)
end

function flux_event_subscribe(h, topic)
    ccall((:flux_event_subscribe, libflux_core), Cint, (Ptr{flux_t}, Cstring), h, topic)
end

function flux_event_unsubscribe(h, topic)
    ccall((:flux_event_unsubscribe, libflux_core), Cint, (Ptr{flux_t}, Cstring), h, topic)
end

function flux_get_msgcounters(h, mcs)
    ccall((:flux_get_msgcounters, libflux_core), Cvoid, (Ptr{flux_t}, Ptr{flux_msgcounters_t}), h, mcs)
end

function flux_clr_msgcounters(h)
    ccall((:flux_clr_msgcounters, libflux_core), Cvoid, (Ptr{flux_t},), h)
end

function flux_buffer_create(size)
    ccall((:flux_buffer_create, libflux_core), Ptr{flux_buffer_t}, (Cint,), size)
end

function flux_buffer_destroy(fb)
    ccall((:flux_buffer_destroy, libflux_core), Cvoid, (Ptr{Cvoid},), fb)
end

function flux_buffer_size(fb)
    ccall((:flux_buffer_size, libflux_core), Cint, (Ptr{flux_buffer_t},), fb)
end

function flux_buffer_bytes(fb)
    ccall((:flux_buffer_bytes, libflux_core), Cint, (Ptr{flux_buffer_t},), fb)
end

function flux_buffer_space(fb)
    ccall((:flux_buffer_space, libflux_core), Cint, (Ptr{flux_buffer_t},), fb)
end

function flux_buffer_readonly(fb)
    ccall((:flux_buffer_readonly, libflux_core), Cint, (Ptr{flux_buffer_t},), fb)
end

function flux_buffer_is_readonly(fb)
    ccall((:flux_buffer_is_readonly, libflux_core), Bool, (Ptr{flux_buffer_t},), fb)
end

function flux_buffer_drop(fb, len)
    ccall((:flux_buffer_drop, libflux_core), Cint, (Ptr{flux_buffer_t}, Cint), fb, len)
end

function flux_buffer_peek(fb, len, lenp)
    ccall((:flux_buffer_peek, libflux_core), Ptr{Cvoid}, (Ptr{flux_buffer_t}, Cint, Ptr{Cint}), fb, len, lenp)
end

function flux_buffer_read(fb, len, lenp)
    ccall((:flux_buffer_read, libflux_core), Ptr{Cvoid}, (Ptr{flux_buffer_t}, Cint, Ptr{Cint}), fb, len, lenp)
end

function flux_buffer_write(fb, data, len)
    ccall((:flux_buffer_write, libflux_core), Cint, (Ptr{flux_buffer_t}, Ptr{Cvoid}, Cint), fb, data, len)
end

function flux_buffer_lines(fb)
    ccall((:flux_buffer_lines, libflux_core), Cint, (Ptr{flux_buffer_t},), fb)
end

function flux_buffer_has_line(fb)
    ccall((:flux_buffer_has_line, libflux_core), Bool, (Ptr{flux_buffer_t},), fb)
end

function flux_buffer_drop_line(fb)
    ccall((:flux_buffer_drop_line, libflux_core), Cint, (Ptr{flux_buffer_t},), fb)
end

function flux_buffer_peek_line(fb, lenp)
    ccall((:flux_buffer_peek_line, libflux_core), Ptr{Cvoid}, (Ptr{flux_buffer_t}, Ptr{Cint}), fb, lenp)
end

function flux_buffer_peek_trimmed_line(fb, lenp)
    ccall((:flux_buffer_peek_trimmed_line, libflux_core), Ptr{Cvoid}, (Ptr{flux_buffer_t}, Ptr{Cint}), fb, lenp)
end

function flux_buffer_read_line(fb, lenp)
    ccall((:flux_buffer_read_line, libflux_core), Ptr{Cvoid}, (Ptr{flux_buffer_t}, Ptr{Cint}), fb, lenp)
end

function flux_buffer_read_trimmed_line(fb, lenp)
    ccall((:flux_buffer_read_trimmed_line, libflux_core), Ptr{Cvoid}, (Ptr{flux_buffer_t}, Ptr{Cint}), fb, lenp)
end

function flux_buffer_write_line(fb, data)
    ccall((:flux_buffer_write_line, libflux_core), Cint, (Ptr{flux_buffer_t}, Cstring), fb, data)
end

function flux_buffer_peek_to_fd(fb, fd, len)
    ccall((:flux_buffer_peek_to_fd, libflux_core), Cint, (Ptr{flux_buffer_t}, Cint, Cint), fb, fd, len)
end

function flux_buffer_read_to_fd(fb, fd, len)
    ccall((:flux_buffer_read_to_fd, libflux_core), Cint, (Ptr{flux_buffer_t}, Cint, Cint), fb, fd, len)
end

function flux_buffer_write_from_fd(fb, fd, len)
    ccall((:flux_buffer_write_from_fd, libflux_core), Cint, (Ptr{flux_buffer_t}, Cint, Cint), fb, fd, len)
end

function flux_reactor_create(flags)
    ccall((:flux_reactor_create, libflux_core), Ptr{flux_reactor_t}, (Cint,), flags)
end

function flux_reactor_destroy(r)
    ccall((:flux_reactor_destroy, libflux_core), Cvoid, (Ptr{flux_reactor_t},), r)
end

function flux_get_reactor(h)
    ccall((:flux_get_reactor, libflux_core), Ptr{flux_reactor_t}, (Ptr{flux_t},), h)
end

function flux_set_reactor(h, r)
    ccall((:flux_set_reactor, libflux_core), Cint, (Ptr{flux_t}, Ptr{flux_reactor_t}), h, r)
end

function flux_reactor_run(r, flags)
    ccall((:flux_reactor_run, libflux_core), Cint, (Ptr{flux_reactor_t}, Cint), r, flags)
end

function flux_reactor_stop(r)
    ccall((:flux_reactor_stop, libflux_core), Cvoid, (Ptr{flux_reactor_t},), r)
end

function flux_reactor_stop_error(r)
    ccall((:flux_reactor_stop_error, libflux_core), Cvoid, (Ptr{flux_reactor_t},), r)
end

function flux_reactor_now(r)
    ccall((:flux_reactor_now, libflux_core), Cdouble, (Ptr{flux_reactor_t},), r)
end

function flux_reactor_now_update(r)
    ccall((:flux_reactor_now_update, libflux_core), Cvoid, (Ptr{flux_reactor_t},), r)
end

function flux_reactor_time()
    ccall((:flux_reactor_time, libflux_core), Cdouble, ())
end

function flux_reactor_active_incref(r)
    ccall((:flux_reactor_active_incref, libflux_core), Cvoid, (Ptr{flux_reactor_t},), r)
end

function flux_reactor_active_decref(r)
    ccall((:flux_reactor_active_decref, libflux_core), Cvoid, (Ptr{flux_reactor_t},), r)
end

function flux_watcher_start(w)
    ccall((:flux_watcher_start, libflux_core), Cvoid, (Ptr{flux_watcher_t},), w)
end

function flux_watcher_stop(w)
    ccall((:flux_watcher_stop, libflux_core), Cvoid, (Ptr{flux_watcher_t},), w)
end

function flux_watcher_destroy(w)
    ccall((:flux_watcher_destroy, libflux_core), Cvoid, (Ptr{flux_watcher_t},), w)
end

function flux_watcher_next_wakeup(w)
    ccall((:flux_watcher_next_wakeup, libflux_core), Cdouble, (Ptr{flux_watcher_t},), w)
end

function flux_handle_watcher_create(r, h, events, cb, arg)
    ccall((:flux_handle_watcher_create, libflux_core), Ptr{flux_watcher_t}, (Ptr{flux_reactor_t}, Ptr{flux_t}, Cint, flux_watcher_f, Ptr{Cvoid}), r, h, events, cb, arg)
end

function flux_handle_watcher_get_flux(w)
    ccall((:flux_handle_watcher_get_flux, libflux_core), Ptr{flux_t}, (Ptr{flux_watcher_t},), w)
end

function flux_fd_watcher_create(r, fd, events, cb, arg)
    ccall((:flux_fd_watcher_create, libflux_core), Ptr{flux_watcher_t}, (Ptr{flux_reactor_t}, Cint, Cint, flux_watcher_f, Ptr{Cvoid}), r, fd, events, cb, arg)
end

function flux_fd_watcher_get_fd(w)
    ccall((:flux_fd_watcher_get_fd, libflux_core), Cint, (Ptr{flux_watcher_t},), w)
end

function flux_buffer_read_watcher_create(r, fd, size, cb, flags, arg)
    ccall((:flux_buffer_read_watcher_create, libflux_core), Ptr{flux_watcher_t}, (Ptr{flux_reactor_t}, Cint, Cint, flux_watcher_f, Cint, Ptr{Cvoid}), r, fd, size, cb, flags, arg)
end

function flux_buffer_read_watcher_get_buffer(w)
    ccall((:flux_buffer_read_watcher_get_buffer, libflux_core), Ptr{flux_buffer_t}, (Ptr{flux_watcher_t},), w)
end

function flux_buffer_write_watcher_create(r, fd, size, cb, flags, arg)
    ccall((:flux_buffer_write_watcher_create, libflux_core), Ptr{flux_watcher_t}, (Ptr{flux_reactor_t}, Cint, Cint, flux_watcher_f, Cint, Ptr{Cvoid}), r, fd, size, cb, flags, arg)
end

function flux_buffer_write_watcher_get_buffer(w)
    ccall((:flux_buffer_write_watcher_get_buffer, libflux_core), Ptr{flux_buffer_t}, (Ptr{flux_watcher_t},), w)
end

function flux_buffer_write_watcher_close(w)
    ccall((:flux_buffer_write_watcher_close, libflux_core), Cint, (Ptr{flux_watcher_t},), w)
end

function flux_buffer_write_watcher_is_closed(w, close_err)
    ccall((:flux_buffer_write_watcher_is_closed, libflux_core), Cint, (Ptr{flux_watcher_t}, Ptr{Cint}), w, close_err)
end

function flux_zmq_watcher_create(r, zsock, events, cb, arg)
    ccall((:flux_zmq_watcher_create, libflux_core), Ptr{flux_watcher_t}, (Ptr{flux_reactor_t}, Ptr{Cvoid}, Cint, flux_watcher_f, Ptr{Cvoid}), r, zsock, events, cb, arg)
end

function flux_zmq_watcher_get_zsock(w)
    ccall((:flux_zmq_watcher_get_zsock, libflux_core), Ptr{Cvoid}, (Ptr{flux_watcher_t},), w)
end

function flux_timer_watcher_create(r, after, repeat, cb, arg)
    ccall((:flux_timer_watcher_create, libflux_core), Ptr{flux_watcher_t}, (Ptr{flux_reactor_t}, Cdouble, Cdouble, flux_watcher_f, Ptr{Cvoid}), r, after, repeat, cb, arg)
end

function flux_timer_watcher_reset(w, after, repeat)
    ccall((:flux_timer_watcher_reset, libflux_core), Cvoid, (Ptr{flux_watcher_t}, Cdouble, Cdouble), w, after, repeat)
end

function flux_periodic_watcher_create(r, offset, interval, reschedule_cb, cb, arg)
    ccall((:flux_periodic_watcher_create, libflux_core), Ptr{flux_watcher_t}, (Ptr{flux_reactor_t}, Cdouble, Cdouble, flux_reschedule_f, flux_watcher_f, Ptr{Cvoid}), r, offset, interval, reschedule_cb, cb, arg)
end

function flux_periodic_watcher_reset(w, next_wakeup, interval, reschedule_cb)
    ccall((:flux_periodic_watcher_reset, libflux_core), Cvoid, (Ptr{flux_watcher_t}, Cdouble, Cdouble, flux_reschedule_f), w, next_wakeup, interval, reschedule_cb)
end

function flux_prepare_watcher_create(r, cb, arg)
    ccall((:flux_prepare_watcher_create, libflux_core), Ptr{flux_watcher_t}, (Ptr{flux_reactor_t}, flux_watcher_f, Ptr{Cvoid}), r, cb, arg)
end

function flux_check_watcher_create(r, cb, arg)
    ccall((:flux_check_watcher_create, libflux_core), Ptr{flux_watcher_t}, (Ptr{flux_reactor_t}, flux_watcher_f, Ptr{Cvoid}), r, cb, arg)
end

function flux_idle_watcher_create(r, cb, arg)
    ccall((:flux_idle_watcher_create, libflux_core), Ptr{flux_watcher_t}, (Ptr{flux_reactor_t}, flux_watcher_f, Ptr{Cvoid}), r, cb, arg)
end

function flux_child_watcher_create(r, pid, trace, cb, arg)
    ccall((:flux_child_watcher_create, libflux_core), Ptr{flux_watcher_t}, (Ptr{flux_reactor_t}, Cint, Bool, flux_watcher_f, Ptr{Cvoid}), r, pid, trace, cb, arg)
end

function flux_child_watcher_get_rpid(w)
    ccall((:flux_child_watcher_get_rpid, libflux_core), Cint, (Ptr{flux_watcher_t},), w)
end

function flux_child_watcher_get_rstatus(w)
    ccall((:flux_child_watcher_get_rstatus, libflux_core), Cint, (Ptr{flux_watcher_t},), w)
end

function flux_signal_watcher_create(r, signum, cb, arg)
    ccall((:flux_signal_watcher_create, libflux_core), Ptr{flux_watcher_t}, (Ptr{flux_reactor_t}, Cint, flux_watcher_f, Ptr{Cvoid}), r, signum, cb, arg)
end

function flux_signal_watcher_get_signum(w)
    ccall((:flux_signal_watcher_get_signum, libflux_core), Cint, (Ptr{flux_watcher_t},), w)
end

function flux_stat_watcher_create(r, path, interval, cb, arg)
    ccall((:flux_stat_watcher_create, libflux_core), Ptr{flux_watcher_t}, (Ptr{flux_reactor_t}, Cstring, Cdouble, flux_watcher_f, Ptr{Cvoid}), r, path, interval, cb, arg)
end

function flux_stat_watcher_get_rstat(w, stat, prev)
    ccall((:flux_stat_watcher_get_rstat, libflux_core), Cvoid, (Ptr{flux_watcher_t}, Ptr{stat}, Ptr{stat}), w, stat, prev)
end

function flux_watcher_create(r, data_size, ops, fn, arg)
    ccall((:flux_watcher_create, libflux_core), Ptr{flux_watcher_t}, (Ptr{flux_reactor_t}, Csize_t, Ptr{flux_watcher_ops}, flux_watcher_f, Ptr{Cvoid}), r, data_size, ops, fn, arg)
end

function flux_watcher_get_data(w)
    ccall((:flux_watcher_get_data, libflux_core), Ptr{Cvoid}, (Ptr{flux_watcher_t},), w)
end

function flux_watcher_get_ops(w)
    ccall((:flux_watcher_get_ops, libflux_core), Ptr{flux_watcher_ops}, (Ptr{flux_watcher_t},), w)
end

function flux_msg_handler_create(h, match, cb, arg)
    ccall((:flux_msg_handler_create, libflux_core), Ptr{flux_msg_handler_t}, (Ptr{flux_t}, flux_match, flux_msg_handler_f, Ptr{Cvoid}), h, match, cb, arg)
end

function flux_msg_handler_destroy(mh)
    ccall((:flux_msg_handler_destroy, libflux_core), Cvoid, (Ptr{flux_msg_handler_t},), mh)
end

function flux_msg_handler_start(mh)
    ccall((:flux_msg_handler_start, libflux_core), Cvoid, (Ptr{flux_msg_handler_t},), mh)
end

function flux_msg_handler_stop(mh)
    ccall((:flux_msg_handler_stop, libflux_core), Cvoid, (Ptr{flux_msg_handler_t},), mh)
end

function flux_msg_handler_allow_rolemask(mh, rolemask)
    ccall((:flux_msg_handler_allow_rolemask, libflux_core), Cvoid, (Ptr{flux_msg_handler_t}, UInt32), mh, rolemask)
end

function flux_msg_handler_deny_rolemask(mh, rolemask)
    ccall((:flux_msg_handler_deny_rolemask, libflux_core), Cvoid, (Ptr{flux_msg_handler_t}, UInt32), mh, rolemask)
end

function flux_msg_handler_addvec(h, tab, arg, msg_handlers)
    ccall((:flux_msg_handler_addvec, libflux_core), Cint, (Ptr{flux_t}, Ptr{flux_msg_handler_spec}, Ptr{Cvoid}, Ptr{Ptr{Ptr{flux_msg_handler_t}}}), h, tab, arg, msg_handlers)
end

function flux_msg_handler_delvec(msg_handlers)
    ccall((:flux_msg_handler_delvec, libflux_core), Cvoid, (Ptr{Ptr{flux_msg_handler_t}},), msg_handlers)
end

function flux_dispatch_requeue(h)
    ccall((:flux_dispatch_requeue, libflux_core), Cint, (Ptr{flux_t},), h)
end

function flux_handle_create(impl, ops, flags)
    ccall((:flux_handle_create, libflux_core), Ptr{flux_t}, (Ptr{Cvoid}, Ptr{flux_handle_ops}, Cint), impl, ops, flags)
end

function flux_handle_destroy(hp)
    ccall((:flux_handle_destroy, libflux_core), Cvoid, (Ptr{flux_t},), hp)
end

function flux_request_decode(msg, topic, s)
    ccall((:flux_request_decode, libflux_core), Cint, (Ptr{flux_msg_t}, Ptr{Cstring}, Ptr{Cstring}), msg, topic, s)
end

function flux_request_decode_raw(msg, topic, data, len)
    ccall((:flux_request_decode_raw, libflux_core), Cint, (Ptr{flux_msg_t}, Ptr{Cstring}, Ptr{Ptr{Cvoid}}, Ptr{Cint}), msg, topic, data, len)
end

function flux_request_encode(topic, s)
    ccall((:flux_request_encode, libflux_core), Ptr{flux_msg_t}, (Cstring, Cstring), topic, s)
end

function flux_request_encode_raw(topic, data, len)
    ccall((:flux_request_encode_raw, libflux_core), Ptr{flux_msg_t}, (Cstring, Ptr{Cvoid}, Cint), topic, data, len)
end

function flux_response_decode(msg, topic, s)
    ccall((:flux_response_decode, libflux_core), Cint, (Ptr{flux_msg_t}, Ptr{Cstring}, Ptr{Cstring}), msg, topic, s)
end

function flux_response_decode_raw(msg, topic, data, len)
    ccall((:flux_response_decode_raw, libflux_core), Cint, (Ptr{flux_msg_t}, Ptr{Cstring}, Ptr{Ptr{Cvoid}}, Ptr{Cint}), msg, topic, data, len)
end

function flux_response_decode_error(msg, errstr)
    ccall((:flux_response_decode_error, libflux_core), Cint, (Ptr{flux_msg_t}, Ptr{Cstring}), msg, errstr)
end

function flux_response_encode(topic, s)
    ccall((:flux_response_encode, libflux_core), Ptr{flux_msg_t}, (Cstring, Cstring), topic, s)
end

function flux_response_encode_raw(topic, data, len)
    ccall((:flux_response_encode_raw, libflux_core), Ptr{flux_msg_t}, (Cstring, Ptr{Cvoid}, Cint), topic, data, len)
end

function flux_response_encode_error(topic, errnum, errstr)
    ccall((:flux_response_encode_error, libflux_core), Ptr{flux_msg_t}, (Cstring, Cint, Cstring), topic, errnum, errstr)
end

function flux_response_derive(request, errnum)
    ccall((:flux_response_derive, libflux_core), Ptr{flux_msg_t}, (Ptr{flux_msg_t}, Cint), request, errnum)
end

function flux_respond(h, request, s)
    ccall((:flux_respond, libflux_core), Cint, (Ptr{flux_t}, Ptr{flux_msg_t}, Cstring), h, request, s)
end

function flux_respond_raw(h, request, data, len)
    ccall((:flux_respond_raw, libflux_core), Cint, (Ptr{flux_t}, Ptr{flux_msg_t}, Ptr{Cvoid}, Cint), h, request, data, len)
end

function flux_respond_error(h, request, errnum, errstr)
    ccall((:flux_respond_error, libflux_core), Cint, (Ptr{flux_t}, Ptr{flux_msg_t}, Cint, Cstring), h, request, errnum, errstr)
end

function flux_keepalive_encode(errnum, status)
    ccall((:flux_keepalive_encode, libflux_core), Ptr{flux_msg_t}, (Cint, Cint), errnum, status)
end

function flux_keepalive_decode(msg, errnum, status)
    ccall((:flux_keepalive_decode, libflux_core), Cint, (Ptr{flux_msg_t}, Ptr{Cint}, Ptr{Cint}), msg, errnum, status)
end

function flux_log_set_appname(h, s)
    ccall((:flux_log_set_appname, libflux_core), Cvoid, (Ptr{flux_t}, Cstring), h, s)
end

function flux_log_set_procid(h, s)
    ccall((:flux_log_set_procid, libflux_core), Cvoid, (Ptr{flux_t}, Cstring), h, s)
end

function flux_log_set_redirect(h, fun, arg)
    ccall((:flux_log_set_redirect, libflux_core), Cvoid, (Ptr{flux_t}, flux_log_f, Ptr{Cvoid}), h, fun, arg)
end

function flux_dmesg(h, flags, fun, arg)
    ccall((:flux_dmesg, libflux_core), Cint, (Ptr{flux_t}, Cint, flux_log_f, Ptr{Cvoid}), h, flags, fun, arg)
end

function flux_log_fprint(buf, len, arg)
    ccall((:flux_log_fprint, libflux_core), Cvoid, (Cstring, Cint, Ptr{Cvoid}), buf, len, arg)
end

function flux_strerror(errnum)
    ccall((:flux_strerror, libflux_core), Cstring, (Cint,), errnum)
end

function flux_future_then(f, timeout, cb, arg)
    ccall((:flux_future_then, libflux_core), Cint, (Ptr{flux_future_t}, Cdouble, flux_continuation_f, Ptr{Cvoid}), f, timeout, cb, arg)
end

function flux_future_wait_for(f, timeout)
    ccall((:flux_future_wait_for, libflux_core), Cint, (Ptr{flux_future_t}, Cdouble), f, timeout)
end

function flux_future_is_ready(f)
    ccall((:flux_future_is_ready, libflux_core), Bool, (Ptr{flux_future_t},), f)
end

function flux_future_reset(f)
    ccall((:flux_future_reset, libflux_core), Cvoid, (Ptr{flux_future_t},), f)
end

function flux_future_destroy(f)
    ccall((:flux_future_destroy, libflux_core), Cvoid, (Ptr{flux_future_t},), f)
end

function flux_future_aux_get(f, name)
    ccall((:flux_future_aux_get, libflux_core), Ptr{Cvoid}, (Ptr{flux_future_t}, Cstring), f, name)
end

function flux_future_aux_set(f, name, aux, destroy)
    ccall((:flux_future_aux_set, libflux_core), Cint, (Ptr{flux_future_t}, Cstring, Ptr{Cvoid}, flux_free_f), f, name, aux, destroy)
end

function flux_future_create(cb, arg)
    ccall((:flux_future_create, libflux_core), Ptr{flux_future_t}, (flux_future_init_f, Ptr{Cvoid}), cb, arg)
end

function flux_future_get(f, result)
    ccall((:flux_future_get, libflux_core), Cint, (Ptr{flux_future_t}, Ptr{Ptr{Cvoid}}), f, result)
end

function flux_future_fulfill(f, result, free_fn)
    ccall((:flux_future_fulfill, libflux_core), Cvoid, (Ptr{flux_future_t}, Ptr{Cvoid}, flux_free_f), f, result, free_fn)
end

function flux_future_fulfill_error(f, errnum, errstr)
    ccall((:flux_future_fulfill_error, libflux_core), Cvoid, (Ptr{flux_future_t}, Cint, Cstring), f, errnum, errstr)
end

function flux_future_fulfill_with(f, p)
    ccall((:flux_future_fulfill_with, libflux_core), Cint, (Ptr{flux_future_t}, Ptr{flux_future_t}), f, p)
end

function flux_future_fatal_error(f, errnum, errstr)
    ccall((:flux_future_fatal_error, libflux_core), Cvoid, (Ptr{flux_future_t}, Cint, Cstring), f, errnum, errstr)
end

function flux_future_has_error(f)
    ccall((:flux_future_has_error, libflux_core), Bool, (Ptr{flux_future_t},), f)
end

function flux_future_error_string(f)
    ccall((:flux_future_error_string, libflux_core), Cstring, (Ptr{flux_future_t},), f)
end

function flux_future_set_flux(f, h)
    ccall((:flux_future_set_flux, libflux_core), Cvoid, (Ptr{flux_future_t}, Ptr{flux_t}), f, h)
end

function flux_future_get_flux(f)
    ccall((:flux_future_get_flux, libflux_core), Ptr{flux_t}, (Ptr{flux_future_t},), f)
end

function flux_future_set_reactor(f, r)
    ccall((:flux_future_set_reactor, libflux_core), Cvoid, (Ptr{flux_future_t}, Ptr{flux_reactor_t}), f, r)
end

function flux_future_get_reactor(f)
    ccall((:flux_future_get_reactor, libflux_core), Ptr{flux_reactor_t}, (Ptr{flux_future_t},), f)
end

function flux_future_incref(f)
    ccall((:flux_future_incref, libflux_core), Cvoid, (Ptr{flux_future_t},), f)
end

function flux_future_decref(f)
    ccall((:flux_future_decref, libflux_core), Cvoid, (Ptr{flux_future_t},), f)
end

function flux_future_wait_all_create()
    ccall((:flux_future_wait_all_create, libflux_core), Ptr{flux_future_t}, ())
end

function flux_future_wait_any_create()
    ccall((:flux_future_wait_any_create, libflux_core), Ptr{flux_future_t}, ())
end

function flux_future_push(cf, name, f)
    ccall((:flux_future_push, libflux_core), Cint, (Ptr{flux_future_t}, Cstring, Ptr{flux_future_t}), cf, name, f)
end

function flux_future_first_child(cf)
    ccall((:flux_future_first_child, libflux_core), Cstring, (Ptr{flux_future_t},), cf)
end

function flux_future_next_child(cf)
    ccall((:flux_future_next_child, libflux_core), Cstring, (Ptr{flux_future_t},), cf)
end

function flux_future_get_child(cf, name)
    ccall((:flux_future_get_child, libflux_core), Ptr{flux_future_t}, (Ptr{flux_future_t}, Cstring), cf, name)
end

function flux_future_and_then(f, cb, arg)
    ccall((:flux_future_and_then, libflux_core), Ptr{flux_future_t}, (Ptr{flux_future_t}, flux_continuation_f, Ptr{Cvoid}), f, cb, arg)
end

function flux_future_or_then(f, cb, arg)
    ccall((:flux_future_or_then, libflux_core), Ptr{flux_future_t}, (Ptr{flux_future_t}, flux_continuation_f, Ptr{Cvoid}), f, cb, arg)
end

function flux_future_continue(prev, f)
    ccall((:flux_future_continue, libflux_core), Cint, (Ptr{flux_future_t}, Ptr{flux_future_t}), prev, f)
end

function flux_future_continue_error(prev, errnum, errstr)
    ccall((:flux_future_continue_error, libflux_core), Cvoid, (Ptr{flux_future_t}, Cint, Cstring), prev, errnum, errstr)
end

function flux_rpc(h, topic, s, nodeid, flags)
    ccall((:flux_rpc, libflux_core), Ptr{flux_future_t}, (Ptr{flux_t}, Cstring, Cstring, UInt32, Cint), h, topic, s, nodeid, flags)
end

function flux_rpc_raw(h, topic, data, len, nodeid, flags)
    ccall((:flux_rpc_raw, libflux_core), Ptr{flux_future_t}, (Ptr{flux_t}, Cstring, Ptr{Cvoid}, Cint, UInt32, Cint), h, topic, data, len, nodeid, flags)
end

function flux_rpc_message(h, msg, nodeid, flags)
    ccall((:flux_rpc_message, libflux_core), Ptr{flux_future_t}, (Ptr{flux_t}, Ptr{flux_msg_t}, UInt32, Cint), h, msg, nodeid, flags)
end

function flux_rpc_get(f, s)
    ccall((:flux_rpc_get, libflux_core), Cint, (Ptr{flux_future_t}, Ptr{Cstring}), f, s)
end

function flux_rpc_get_raw(f, data, len)
    ccall((:flux_rpc_get_raw, libflux_core), Cint, (Ptr{flux_future_t}, Ptr{Ptr{Cvoid}}, Ptr{Cint}), f, data, len)
end

function flux_rpc_get_matchtag(f)
    ccall((:flux_rpc_get_matchtag, libflux_core), UInt32, (Ptr{flux_future_t},), f)
end

function flux_panic(h, nodeid, flags, reason)
    ccall((:flux_panic, libflux_core), Cint, (Ptr{flux_t}, UInt32, Cint, Cstring), h, nodeid, flags, reason)
end

function flux_event_decode(msg, topic, s)
    ccall((:flux_event_decode, libflux_core), Cint, (Ptr{flux_msg_t}, Ptr{Cstring}, Ptr{Cstring}), msg, topic, s)
end

function flux_event_encode(topic, s)
    ccall((:flux_event_encode, libflux_core), Ptr{flux_msg_t}, (Cstring, Cstring), topic, s)
end

function flux_event_encode_raw(topic, data, len)
    ccall((:flux_event_encode_raw, libflux_core), Ptr{flux_msg_t}, (Cstring, Ptr{Cvoid}, Cint), topic, data, len)
end

function flux_event_decode_raw(msg, topic, data, len)
    ccall((:flux_event_decode_raw, libflux_core), Cint, (Ptr{flux_msg_t}, Ptr{Cstring}, Ptr{Ptr{Cvoid}}, Ptr{Cint}), msg, topic, data, len)
end

function flux_event_publish(h, topic, flags, s)
    ccall((:flux_event_publish, libflux_core), Ptr{flux_future_t}, (Ptr{flux_t}, Cstring, Cint, Cstring), h, topic, flags, s)
end

function flux_event_publish_raw(h, topic, flags, data, len)
    ccall((:flux_event_publish_raw, libflux_core), Ptr{flux_future_t}, (Ptr{flux_t}, Cstring, Cint, Ptr{Cvoid}, Cint), h, topic, flags, data, len)
end

function flux_event_publish_get_seq(f, seq)
    ccall((:flux_event_publish_get_seq, libflux_core), Cint, (Ptr{flux_future_t}, Ptr{Cint}), f, seq)
end

function flux_modname(filename, cb, arg)
    ccall((:flux_modname, libflux_core), Cstring, (Cstring, Ptr{flux_moderr_f}, Ptr{Cvoid}), filename, cb, arg)
end

function flux_modfind(searchpath, modname, cb, arg)
    ccall((:flux_modfind, libflux_core), Cstring, (Cstring, Cstring, Ptr{flux_moderr_f}, Ptr{Cvoid}), searchpath, modname, cb, arg)
end

function flux_module_debug_test(h, flag, clear)
    ccall((:flux_module_debug_test, libflux_core), Bool, (Ptr{flux_t}, Cint, Bool), h, flag, clear)
end

function flux_module_set_running(h)
    ccall((:flux_module_set_running, libflux_core), Cint, (Ptr{flux_t},), h)
end

function flux_attr_get(h, name)
    ccall((:flux_attr_get, libflux_core), Cstring, (Ptr{flux_t}, Cstring), h, name)
end

function flux_attr_set(h, name, val)
    ccall((:flux_attr_set, libflux_core), Cint, (Ptr{flux_t}, Cstring, Cstring), h, name, val)
end

function flux_attr_set_cacheonly(h, name, val)
    ccall((:flux_attr_set_cacheonly, libflux_core), Cint, (Ptr{flux_t}, Cstring, Cstring), h, name, val)
end

function flux_get_rank(h, rank)
    ccall((:flux_get_rank, libflux_core), Cint, (Ptr{flux_t}, Ptr{UInt32}), h, rank)
end

function flux_get_size(h, size)
    ccall((:flux_get_size, libflux_core), Cint, (Ptr{flux_t}, Ptr{UInt32}), h, size)
end

function flux_conf_builtin_get(name, flags)
    ccall((:flux_conf_builtin_get, libflux_core), Cstring, (Cstring, flux_conf_flags), name, flags)
end

function flux_conf_create()
    ccall((:flux_conf_create, libflux_core), Ptr{flux_conf_t}, ())
end

function flux_conf_copy(conf)
    ccall((:flux_conf_copy, libflux_core), Ptr{flux_conf_t}, (Ptr{flux_conf_t},), conf)
end

function flux_conf_incref(conf)
    ccall((:flux_conf_incref, libflux_core), Ptr{flux_conf_t}, (Ptr{flux_conf_t},), conf)
end

function flux_conf_decref(conf)
    ccall((:flux_conf_decref, libflux_core), Cvoid, (Ptr{flux_conf_t},), conf)
end

function flux_conf_reload_decode(msg, conf)
    ccall((:flux_conf_reload_decode, libflux_core), Cint, (Ptr{flux_msg_t}, Ptr{Ptr{flux_conf_t}}), msg, conf)
end

function flux_conf_parse(path, error)
    ccall((:flux_conf_parse, libflux_core), Ptr{flux_conf_t}, (Cstring, Ptr{flux_conf_error_t}), path, error)
end

function flux_get_conf(h)
    ccall((:flux_get_conf, libflux_core), Ptr{flux_conf_t}, (Ptr{flux_t},), h)
end

function flux_set_conf(h, conf)
    ccall((:flux_set_conf, libflux_core), Cint, (Ptr{flux_t}, Ptr{flux_conf_t}), h, conf)
end

function flux_heartbeat_encode(epoch)
    ccall((:flux_heartbeat_encode, libflux_core), Ptr{flux_msg_t}, (Cint,), epoch)
end

function flux_heartbeat_decode(msg, epoch)
    ccall((:flux_heartbeat_decode, libflux_core), Cint, (Ptr{flux_msg_t}, Ptr{Cint}), msg, epoch)
end

function flux_content_load(h, blobref, flags)
    ccall((:flux_content_load, libflux_core), Ptr{flux_future_t}, (Ptr{flux_t}, Cstring, Cint), h, blobref, flags)
end

function flux_content_load_get(f, buf, len)
    ccall((:flux_content_load_get, libflux_core), Cint, (Ptr{flux_future_t}, Ptr{Ptr{Cvoid}}, Ptr{Cint}), f, buf, len)
end

function flux_content_store(h, buf, len, flags)
    ccall((:flux_content_store, libflux_core), Ptr{flux_future_t}, (Ptr{flux_t}, Ptr{Cvoid}, Cint, Cint), h, buf, len, flags)
end

function flux_content_store_get(f, blobref)
    ccall((:flux_content_store_get, libflux_core), Cint, (Ptr{flux_future_t}, Ptr{Cstring}), f, blobref)
end

function flux_barrier(h, name, nprocs)
    ccall((:flux_barrier, libflux_core), Ptr{flux_future_t}, (Ptr{flux_t}, Cstring, Cint), h, name, nprocs)
end

function flux_service_register(h, name)
    ccall((:flux_service_register, libflux_core), Ptr{flux_future_t}, (Ptr{flux_t}, Cstring), h, name)
end

function flux_service_unregister(h, name)
    ccall((:flux_service_unregister, libflux_core), Ptr{flux_future_t}, (Ptr{flux_t}, Cstring), h, name)
end

function flux_core_version_string()
    ccall((:flux_core_version_string, libflux_core), Cstring, ())
end

function flux_core_version(major, minor, patch)
    ccall((:flux_core_version, libflux_core), Cint, (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), major, minor, patch)
end

function flux_plugin_create()
    ccall((:flux_plugin_create, libflux_core), Ptr{flux_plugin_t}, ())
end

function flux_plugin_destroy(p)
    ccall((:flux_plugin_destroy, libflux_core), Cvoid, (Ptr{flux_plugin_t},), p)
end

function flux_plugin_strerror(p)
    ccall((:flux_plugin_strerror, libflux_core), Cstring, (Ptr{flux_plugin_t},), p)
end

function flux_plugin_set_name(p, name)
    ccall((:flux_plugin_set_name, libflux_core), Cint, (Ptr{flux_plugin_t}, Cstring), p, name)
end

function flux_plugin_get_name(p)
    ccall((:flux_plugin_get_name, libflux_core), Cstring, (Ptr{flux_plugin_t},), p)
end

function flux_plugin_add_handler(p, topic, cb, arg)
    ccall((:flux_plugin_add_handler, libflux_core), Cint, (Ptr{flux_plugin_t}, Cstring, flux_plugin_f, Ptr{Cvoid}), p, topic, cb, arg)
end

function flux_plugin_remove_handler(p, topic)
    ccall((:flux_plugin_remove_handler, libflux_core), Cint, (Ptr{flux_plugin_t}, Cstring), p, topic)
end

function flux_plugin_get_handler(p, topic)
    ccall((:flux_plugin_get_handler, libflux_core), flux_plugin_f, (Ptr{flux_plugin_t}, Cstring), p, topic)
end

function flux_plugin_match_handler(p, topic)
    ccall((:flux_plugin_match_handler, libflux_core), flux_plugin_f, (Ptr{flux_plugin_t}, Cstring), p, topic)
end

function flux_plugin_register(p, name, t)
    ccall((:flux_plugin_register, libflux_core), Cint, (Ptr{flux_plugin_t}, Cstring, Ptr{flux_plugin_handler}), p, name, t)
end

function flux_plugin_aux_set(p, key, val, free_fn)
    ccall((:flux_plugin_aux_set, libflux_core), Cint, (Ptr{flux_plugin_t}, Cstring, Ptr{Cvoid}, flux_free_f), p, key, val, free_fn)
end

function flux_plugin_aux_get(p, key)
    ccall((:flux_plugin_aux_get, libflux_core), Ptr{Cvoid}, (Ptr{flux_plugin_t}, Cstring), p, key)
end

function flux_plugin_set_conf(p, json_str)
    ccall((:flux_plugin_set_conf, libflux_core), Cint, (Ptr{flux_plugin_t}, Cstring), p, json_str)
end

function flux_plugin_get_conf(p)
    ccall((:flux_plugin_get_conf, libflux_core), Cstring, (Ptr{flux_plugin_t},), p)
end

function flux_plugin_arg_create()
    ccall((:flux_plugin_arg_create, libflux_core), Ptr{flux_plugin_arg_t}, ())
end

function flux_plugin_arg_destroy(args)
    ccall((:flux_plugin_arg_destroy, libflux_core), Cvoid, (Ptr{flux_plugin_arg_t},), args)
end

function flux_plugin_arg_strerror(args)
    ccall((:flux_plugin_arg_strerror, libflux_core), Cstring, (Ptr{flux_plugin_arg_t},), args)
end

function flux_plugin_arg_set(args, flags, json_str)
    ccall((:flux_plugin_arg_set, libflux_core), Cint, (Ptr{flux_plugin_arg_t}, Cint, Cstring), args, flags, json_str)
end

function flux_plugin_arg_get(args, flags, json_str)
    ccall((:flux_plugin_arg_get, libflux_core), Cint, (Ptr{flux_plugin_arg_t}, Cint, Ptr{Cstring}), args, flags, json_str)
end

function flux_plugin_call(p, name, args)
    ccall((:flux_plugin_call, libflux_core), Cint, (Ptr{flux_plugin_t}, Cstring, Ptr{flux_plugin_arg_t}), p, name, args)
end

function flux_plugin_load_dso(p, path)
    ccall((:flux_plugin_load_dso, libflux_core), Cint, (Ptr{flux_plugin_t}, Cstring), p, path)
end

function flux_kvsdir_create(handle, rootref, key, json_str)
    ccall((:flux_kvsdir_create, libflux_core), Ptr{flux_kvsdir_t}, (Ptr{flux_t}, Cstring, Cstring, Cstring), handle, rootref, key, json_str)
end

function flux_kvsdir_destroy(dir)
    ccall((:flux_kvsdir_destroy, libflux_core), Cvoid, (Ptr{flux_kvsdir_t},), dir)
end

function flux_kvsdir_copy(dir)
    ccall((:flux_kvsdir_copy, libflux_core), Ptr{flux_kvsdir_t}, (Ptr{flux_kvsdir_t},), dir)
end

function flux_kvsdir_incref(dir)
    ccall((:flux_kvsdir_incref, libflux_core), Cvoid, (Ptr{flux_kvsdir_t},), dir)
end

function flux_kvsitr_create(dir)
    ccall((:flux_kvsitr_create, libflux_core), Ptr{flux_kvsitr_t}, (Ptr{flux_kvsdir_t},), dir)
end

function flux_kvsitr_destroy(itr)
    ccall((:flux_kvsitr_destroy, libflux_core), Cvoid, (Ptr{flux_kvsitr_t},), itr)
end

function flux_kvsitr_next(itr)
    ccall((:flux_kvsitr_next, libflux_core), Cstring, (Ptr{flux_kvsitr_t},), itr)
end

function flux_kvsitr_rewind(itr)
    ccall((:flux_kvsitr_rewind, libflux_core), Cvoid, (Ptr{flux_kvsitr_t},), itr)
end

function flux_kvsdir_get_size(dir)
    ccall((:flux_kvsdir_get_size, libflux_core), Cint, (Ptr{flux_kvsdir_t},), dir)
end

function flux_kvsdir_exists(dir, name)
    ccall((:flux_kvsdir_exists, libflux_core), Bool, (Ptr{flux_kvsdir_t}, Cstring), dir, name)
end

function flux_kvsdir_isdir(dir, name)
    ccall((:flux_kvsdir_isdir, libflux_core), Bool, (Ptr{flux_kvsdir_t}, Cstring), dir, name)
end

function flux_kvsdir_issymlink(dir, name)
    ccall((:flux_kvsdir_issymlink, libflux_core), Bool, (Ptr{flux_kvsdir_t}, Cstring), dir, name)
end

function flux_kvsdir_key(dir)
    ccall((:flux_kvsdir_key, libflux_core), Cstring, (Ptr{flux_kvsdir_t},), dir)
end

function flux_kvsdir_handle(dir)
    ccall((:flux_kvsdir_handle, libflux_core), Ptr{Cvoid}, (Ptr{flux_kvsdir_t},), dir)
end

function flux_kvsdir_rootref(dir)
    ccall((:flux_kvsdir_rootref, libflux_core), Cstring, (Ptr{flux_kvsdir_t},), dir)
end

function flux_kvsdir_key_at(dir, key)
    ccall((:flux_kvsdir_key_at, libflux_core), Cstring, (Ptr{flux_kvsdir_t}, Cstring), dir, key)
end

function flux_kvs_lookup(h, ns, flags, key)
    ccall((:flux_kvs_lookup, libflux_core), Ptr{flux_future_t}, (Ptr{flux_t}, Cstring, Cint, Cstring), h, ns, flags, key)
end

function flux_kvs_lookupat(h, flags, key, treeobj)
    ccall((:flux_kvs_lookupat, libflux_core), Ptr{flux_future_t}, (Ptr{flux_t}, Cint, Cstring, Cstring), h, flags, key, treeobj)
end

function flux_kvs_lookup_get(f, value)
    ccall((:flux_kvs_lookup_get, libflux_core), Cint, (Ptr{flux_future_t}, Ptr{Cstring}), f, value)
end

function flux_kvs_lookup_get_raw(f, data, len)
    ccall((:flux_kvs_lookup_get_raw, libflux_core), Cint, (Ptr{flux_future_t}, Ptr{Ptr{Cvoid}}, Ptr{Cint}), f, data, len)
end

function flux_kvs_lookup_get_treeobj(f, treeobj)
    ccall((:flux_kvs_lookup_get_treeobj, libflux_core), Cint, (Ptr{flux_future_t}, Ptr{Cstring}), f, treeobj)
end

function flux_kvs_lookup_get_dir(f, dir)
    ccall((:flux_kvs_lookup_get_dir, libflux_core), Cint, (Ptr{flux_future_t}, Ptr{Ptr{flux_kvsdir_t}}), f, dir)
end

function flux_kvs_lookup_get_symlink(f, ns, target)
    ccall((:flux_kvs_lookup_get_symlink, libflux_core), Cint, (Ptr{flux_future_t}, Ptr{Cstring}, Ptr{Cstring}), f, ns, target)
end

function flux_kvs_lookup_get_key(f)
    ccall((:flux_kvs_lookup_get_key, libflux_core), Cstring, (Ptr{flux_future_t},), f)
end

function flux_kvs_lookup_cancel(f)
    ccall((:flux_kvs_lookup_cancel, libflux_core), Cint, (Ptr{flux_future_t},), f)
end

function flux_kvs_getroot(h, ns, flags)
    ccall((:flux_kvs_getroot, libflux_core), Ptr{flux_future_t}, (Ptr{flux_t}, Cstring, Cint), h, ns, flags)
end

function flux_kvs_getroot_get_treeobj(f, treeobj)
    ccall((:flux_kvs_getroot_get_treeobj, libflux_core), Cint, (Ptr{flux_future_t}, Ptr{Cstring}), f, treeobj)
end

function flux_kvs_getroot_get_blobref(f, blobref)
    ccall((:flux_kvs_getroot_get_blobref, libflux_core), Cint, (Ptr{flux_future_t}, Ptr{Cstring}), f, blobref)
end

function flux_kvs_getroot_get_sequence(f, seq)
    ccall((:flux_kvs_getroot_get_sequence, libflux_core), Cint, (Ptr{flux_future_t}, Ptr{Cint}), f, seq)
end

function flux_kvs_getroot_get_owner(f, owner)
    ccall((:flux_kvs_getroot_get_owner, libflux_core), Cint, (Ptr{flux_future_t}, Ptr{UInt32}), f, owner)
end

function flux_kvs_txn_create()
    ccall((:flux_kvs_txn_create, libflux_core), Ptr{flux_kvs_txn_t}, ())
end

function flux_kvs_txn_destroy(txn)
    ccall((:flux_kvs_txn_destroy, libflux_core), Cvoid, (Ptr{flux_kvs_txn_t},), txn)
end

function flux_kvs_txn_put(txn, flags, key, value)
    ccall((:flux_kvs_txn_put, libflux_core), Cint, (Ptr{flux_kvs_txn_t}, Cint, Cstring, Cstring), txn, flags, key, value)
end

function flux_kvs_txn_put_raw(txn, flags, key, data, len)
    ccall((:flux_kvs_txn_put_raw, libflux_core), Cint, (Ptr{flux_kvs_txn_t}, Cint, Cstring, Ptr{Cvoid}, Cint), txn, flags, key, data, len)
end

function flux_kvs_txn_put_treeobj(txn, flags, key, treeobj)
    ccall((:flux_kvs_txn_put_treeobj, libflux_core), Cint, (Ptr{flux_kvs_txn_t}, Cint, Cstring, Cstring), txn, flags, key, treeobj)
end

function flux_kvs_txn_mkdir(txn, flags, key)
    ccall((:flux_kvs_txn_mkdir, libflux_core), Cint, (Ptr{flux_kvs_txn_t}, Cint, Cstring), txn, flags, key)
end

function flux_kvs_txn_unlink(txn, flags, key)
    ccall((:flux_kvs_txn_unlink, libflux_core), Cint, (Ptr{flux_kvs_txn_t}, Cint, Cstring), txn, flags, key)
end

function flux_kvs_txn_symlink(txn, flags, key, ns, target)
    ccall((:flux_kvs_txn_symlink, libflux_core), Cint, (Ptr{flux_kvs_txn_t}, Cint, Cstring, Cstring, Cstring), txn, flags, key, ns, target)
end

function flux_kvs_commit(h, ns, flags, txn)
    ccall((:flux_kvs_commit, libflux_core), Ptr{flux_future_t}, (Ptr{flux_t}, Cstring, Cint, Ptr{flux_kvs_txn_t}), h, ns, flags, txn)
end

function flux_kvs_fence(h, ns, flags, name, nprocs, txn)
    ccall((:flux_kvs_fence, libflux_core), Ptr{flux_future_t}, (Ptr{flux_t}, Cstring, Cint, Cstring, Cint, Ptr{flux_kvs_txn_t}), h, ns, flags, name, nprocs, txn)
end

function flux_kvs_commit_get_treeobj(f, treeobj)
    ccall((:flux_kvs_commit_get_treeobj, libflux_core), Cint, (Ptr{flux_future_t}, Ptr{Cstring}), f, treeobj)
end

function flux_kvs_commit_get_sequence(f, rootseq)
    ccall((:flux_kvs_commit_get_sequence, libflux_core), Cint, (Ptr{flux_future_t}, Ptr{Cint}), f, rootseq)
end

function flux_kvs_copy(h, srcns, srckey, dstns, dstkey, commit_flags)
    ccall((:flux_kvs_copy, libflux_core), Ptr{flux_future_t}, (Ptr{flux_t}, Cstring, Cstring, Cstring, Cstring, Cint), h, srcns, srckey, dstns, dstkey, commit_flags)
end

function flux_kvs_move(h, srcns, srckey, dstns, dstkey, commit_flags)
    ccall((:flux_kvs_move, libflux_core), Ptr{flux_future_t}, (Ptr{flux_t}, Cstring, Cstring, Cstring, Cstring, Cint), h, srcns, srckey, dstns, dstkey, commit_flags)
end

function flux_kvs_namespace_create(h, ns, owner, flags)
    ccall((:flux_kvs_namespace_create, libflux_core), Ptr{flux_future_t}, (Ptr{flux_t}, Cstring, UInt32, Cint), h, ns, owner, flags)
end

function flux_kvs_namespace_remove(h, ns)
    ccall((:flux_kvs_namespace_remove, libflux_core), Ptr{flux_future_t}, (Ptr{flux_t}, Cstring), h, ns)
end

function flux_kvs_get_version(h, ns, versionp)
    ccall((:flux_kvs_get_version, libflux_core), Cint, (Ptr{flux_t}, Cstring, Ptr{Cint}), h, ns, versionp)
end

function flux_kvs_wait_version(h, ns, version)
    ccall((:flux_kvs_wait_version, libflux_core), Cint, (Ptr{flux_t}, Cstring, Cint), h, ns, version)
end

function flux_kvs_dropcache(h)
    ccall((:flux_kvs_dropcache, libflux_core), Cint, (Ptr{flux_t},), h)
end

function flux_subprocess_server_start(h, prefix, local_uri, rank)
    ccall((:flux_subprocess_server_start, libflux_core), Ptr{flux_subprocess_server_t}, (Ptr{flux_t}, Cstring, Cstring, UInt32), h, prefix, local_uri, rank)
end

function flux_subprocess_server_stop(s)
    ccall((:flux_subprocess_server_stop, libflux_core), Cvoid, (Ptr{flux_subprocess_server_t},), s)
end

function flux_subprocess_server_subprocesses_kill(s, signum, wait_time)
    ccall((:flux_subprocess_server_subprocesses_kill, libflux_core), Cint, (Ptr{flux_subprocess_server_t}, Cint, Cdouble), s, signum, wait_time)
end

function flux_subprocess_server_terminate_by_uuid(s, id)
    ccall((:flux_subprocess_server_terminate_by_uuid, libflux_core), Cint, (Ptr{flux_subprocess_server_t}, Cstring), s, id)
end

function flux_standard_output(p, stream)
    ccall((:flux_standard_output, libflux_core), Cvoid, (Ptr{flux_subprocess_t}, Cstring), p, stream)
end

function flux_cmd_create(argc, argv, env)
    ccall((:flux_cmd_create, libflux_core), Ptr{flux_cmd_t}, (Cint, Ptr{Cstring}, Ptr{Cstring}), argc, argv, env)
end

function flux_cmd_copy(cmd)
    ccall((:flux_cmd_copy, libflux_core), Ptr{flux_cmd_t}, (Ptr{flux_cmd_t},), cmd)
end

function flux_cmd_destroy(cmd)
    ccall((:flux_cmd_destroy, libflux_core), Cvoid, (Ptr{flux_cmd_t},), cmd)
end

function flux_cmd_argv_append(cmd, arg)
    ccall((:flux_cmd_argv_append, libflux_core), Cint, (Ptr{flux_cmd_t}, Cstring), cmd, arg)
end

function flux_cmd_argv_delete(cmd, n)
    ccall((:flux_cmd_argv_delete, libflux_core), Cint, (Ptr{flux_cmd_t}, Cint), cmd, n)
end

function flux_cmd_argv_insert(cmd, n, arg)
    ccall((:flux_cmd_argv_insert, libflux_core), Cint, (Ptr{flux_cmd_t}, Cint, Cstring), cmd, n, arg)
end

function flux_cmd_argc(cmd)
    ccall((:flux_cmd_argc, libflux_core), Cint, (Ptr{flux_cmd_t},), cmd)
end

function flux_cmd_arg(cmd, n)
    ccall((:flux_cmd_arg, libflux_core), Cstring, (Ptr{flux_cmd_t}, Cint), cmd, n)
end

function flux_cmd_stringify(cmd)
    ccall((:flux_cmd_stringify, libflux_core), Cstring, (Ptr{flux_cmd_t},), cmd)
end

function flux_cmd_unsetenv(cmd, name)
    ccall((:flux_cmd_unsetenv, libflux_core), Cvoid, (Ptr{flux_cmd_t}, Cstring), cmd, name)
end

function flux_cmd_getenv(cmd, name)
    ccall((:flux_cmd_getenv, libflux_core), Cstring, (Ptr{flux_cmd_t}, Cstring), cmd, name)
end

function flux_cmd_setcwd(cmd, cwd)
    ccall((:flux_cmd_setcwd, libflux_core), Cint, (Ptr{flux_cmd_t}, Cstring), cmd, cwd)
end

function flux_cmd_getcwd(cmd)
    ccall((:flux_cmd_getcwd, libflux_core), Cstring, (Ptr{flux_cmd_t},), cmd)
end

function flux_cmd_add_channel(cmd, name)
    ccall((:flux_cmd_add_channel, libflux_core), Cint, (Ptr{flux_cmd_t}, Cstring), cmd, name)
end

function flux_cmd_setopt(cmd, var, val)
    ccall((:flux_cmd_setopt, libflux_core), Cint, (Ptr{flux_cmd_t}, Cstring, Cstring), cmd, var, val)
end

function flux_cmd_getopt(cmd, var)
    ccall((:flux_cmd_getopt, libflux_core), Cstring, (Ptr{flux_cmd_t}, Cstring), cmd, var)
end

function flux_exec(h, flags, cmd, ops, hooks)
    ccall((:flux_exec, libflux_core), Ptr{flux_subprocess_t}, (Ptr{flux_t}, Cint, Ptr{flux_cmd_t}, Ptr{flux_subprocess_ops_t}, Ptr{flux_subprocess_hooks_t}), h, flags, cmd, ops, hooks)
end

function flux_local_exec(r, flags, cmd, ops, hooks)
    ccall((:flux_local_exec, libflux_core), Ptr{flux_subprocess_t}, (Ptr{flux_reactor_t}, Cint, Ptr{flux_cmd_t}, Ptr{flux_subprocess_ops_t}, Ptr{flux_subprocess_hooks_t}), r, flags, cmd, ops, hooks)
end

function flux_rexec(h, rank, flags, cmd, ops)
    ccall((:flux_rexec, libflux_core), Ptr{flux_subprocess_t}, (Ptr{flux_t}, Cint, Cint, Ptr{flux_cmd_t}, Ptr{flux_subprocess_ops_t}), h, rank, flags, cmd, ops)
end

function flux_subprocess_stream_start(p, stream)
    ccall((:flux_subprocess_stream_start, libflux_core), Cint, (Ptr{flux_subprocess_t}, Cstring), p, stream)
end

function flux_subprocess_stream_stop(p, stream)
    ccall((:flux_subprocess_stream_stop, libflux_core), Cint, (Ptr{flux_subprocess_t}, Cstring), p, stream)
end

function flux_subprocess_stream_status(p, stream)
    ccall((:flux_subprocess_stream_status, libflux_core), Cint, (Ptr{flux_subprocess_t}, Cstring), p, stream)
end

function flux_subprocess_write(p, stream, buf, len)
    ccall((:flux_subprocess_write, libflux_core), Cint, (Ptr{flux_subprocess_t}, Cstring, Cstring, Csize_t), p, stream, buf, len)
end

function flux_subprocess_close(p, stream)
    ccall((:flux_subprocess_close, libflux_core), Cint, (Ptr{flux_subprocess_t}, Cstring), p, stream)
end

function flux_subprocess_read(p, stream, len, lenp)
    ccall((:flux_subprocess_read, libflux_core), Cstring, (Ptr{flux_subprocess_t}, Cstring, Cint, Ptr{Cint}), p, stream, len, lenp)
end

function flux_subprocess_read_line(p, stream, lenp)
    ccall((:flux_subprocess_read_line, libflux_core), Cstring, (Ptr{flux_subprocess_t}, Cstring, Ptr{Cint}), p, stream, lenp)
end

function flux_subprocess_read_trimmed_line(p, stream, lenp)
    ccall((:flux_subprocess_read_trimmed_line, libflux_core), Cstring, (Ptr{flux_subprocess_t}, Cstring, Ptr{Cint}), p, stream, lenp)
end

function flux_subprocess_read_stream_closed(p, stream)
    ccall((:flux_subprocess_read_stream_closed, libflux_core), Cint, (Ptr{flux_subprocess_t}, Cstring), p, stream)
end

function flux_subprocess_getline(p, stream, lenp)
    ccall((:flux_subprocess_getline, libflux_core), Cstring, (Ptr{flux_subprocess_t}, Cstring, Ptr{Cint}), p, stream, lenp)
end

function flux_subprocess_kill(p, signo)
    ccall((:flux_subprocess_kill, libflux_core), Ptr{flux_future_t}, (Ptr{flux_subprocess_t}, Cint), p, signo)
end

function flux_subprocess_ref(p)
    ccall((:flux_subprocess_ref, libflux_core), Cvoid, (Ptr{flux_subprocess_t},), p)
end

function flux_subprocess_unref(p)
    ccall((:flux_subprocess_unref, libflux_core), Cvoid, (Ptr{flux_subprocess_t},), p)
end

function flux_subprocess_state(p)
    ccall((:flux_subprocess_state, libflux_core), flux_subprocess_state_t, (Ptr{flux_subprocess_t},), p)
end

function flux_subprocess_state_string(state)
    ccall((:flux_subprocess_state_string, libflux_core), Cstring, (flux_subprocess_state_t,), state)
end

function flux_subprocess_rank(p)
    ccall((:flux_subprocess_rank, libflux_core), Cint, (Ptr{flux_subprocess_t},), p)
end

function flux_subprocess_fail_errno(p)
    ccall((:flux_subprocess_fail_errno, libflux_core), Cint, (Ptr{flux_subprocess_t},), p)
end

function flux_subprocess_status(p)
    ccall((:flux_subprocess_status, libflux_core), Cint, (Ptr{flux_subprocess_t},), p)
end

function flux_subprocess_exit_code(p)
    ccall((:flux_subprocess_exit_code, libflux_core), Cint, (Ptr{flux_subprocess_t},), p)
end

function flux_subprocess_signaled(p)
    ccall((:flux_subprocess_signaled, libflux_core), Cint, (Ptr{flux_subprocess_t},), p)
end

function flux_subprocess_pid(p)
    ccall((:flux_subprocess_pid, libflux_core), pid_t, (Ptr{flux_subprocess_t},), p)
end

function flux_subprocess_get_cmd(p)
    ccall((:flux_subprocess_get_cmd, libflux_core), Ptr{flux_cmd_t}, (Ptr{flux_subprocess_t},), p)
end

function flux_subprocess_get_reactor(p)
    ccall((:flux_subprocess_get_reactor, libflux_core), Ptr{flux_reactor_t}, (Ptr{flux_subprocess_t},), p)
end

function flux_subprocess_aux_set(p, name, ctx, free)
    ccall((:flux_subprocess_aux_set, libflux_core), Cint, (Ptr{flux_subprocess_t}, Cstring, Ptr{Cvoid}, flux_free_f), p, name, ctx, free)
end

function flux_subprocess_aux_get(p, name)
    ccall((:flux_subprocess_aux_get, libflux_core), Ptr{Cvoid}, (Ptr{flux_subprocess_t}, Cstring), p, name)
end

function flux_job_id_parse(s, id)
    ccall((:flux_job_id_parse, libflux_core), Cint, (Cstring, Ptr{flux_jobid_t}), s, id)
end

function flux_job_id_encode(id, type, buf, bufsz)
    ccall((:flux_job_id_encode, libflux_core), Cint, (flux_jobid_t, Cstring, Cstring, Csize_t), id, type, buf, bufsz)
end

function flux_job_statetostr(state, single_char)
    ccall((:flux_job_statetostr, libflux_core), Cstring, (flux_job_state_t, Bool), state, single_char)
end

function flux_job_strtostate(s, state)
    ccall((:flux_job_strtostate, libflux_core), Cint, (Cstring, Ptr{flux_job_state_t}), s, state)
end

function flux_job_resulttostr(result, abbrev)
    ccall((:flux_job_resulttostr, libflux_core), Cstring, (flux_job_result_t, Bool), result, abbrev)
end

function flux_job_strtoresult(s, result)
    ccall((:flux_job_strtoresult, libflux_core), Cint, (Cstring, Ptr{flux_job_result_t}), s, result)
end

function flux_job_submit(h, jobspec, priority, flags)
    ccall((:flux_job_submit, libflux_core), Ptr{flux_future_t}, (Ptr{flux_t}, Cstring, Cint, Cint), h, jobspec, priority, flags)
end

function flux_job_submit_get_id(f, id)
    ccall((:flux_job_submit_get_id, libflux_core), Cint, (Ptr{flux_future_t}, Ptr{flux_jobid_t}), f, id)
end

function flux_job_wait(h, id)
    ccall((:flux_job_wait, libflux_core), Ptr{flux_future_t}, (Ptr{flux_t}, flux_jobid_t), h, id)
end

function flux_job_wait_get_status(f, success, errstr)
    ccall((:flux_job_wait_get_status, libflux_core), Cint, (Ptr{flux_future_t}, Ptr{Bool}, Ptr{Cstring}), f, success, errstr)
end

function flux_job_wait_get_id(f, id)
    ccall((:flux_job_wait_get_id, libflux_core), Cint, (Ptr{flux_future_t}, Ptr{flux_jobid_t}), f, id)
end

function flux_job_list(h, max_entries, json_str, userid, states)
    ccall((:flux_job_list, libflux_core), Ptr{flux_future_t}, (Ptr{flux_t}, Cint, Cstring, UInt32, Cint), h, max_entries, json_str, userid, states)
end

function flux_job_list_inactive(h, max_entries, since, json_str)
    ccall((:flux_job_list_inactive, libflux_core), Ptr{flux_future_t}, (Ptr{flux_t}, Cint, Cdouble, Cstring), h, max_entries, since, json_str)
end

function flux_job_list_id(h, id, json_str)
    ccall((:flux_job_list_id, libflux_core), Ptr{flux_future_t}, (Ptr{flux_t}, flux_jobid_t, Cstring), h, id, json_str)
end

function flux_job_raise(h, id, type, severity, note)
    ccall((:flux_job_raise, libflux_core), Ptr{flux_future_t}, (Ptr{flux_t}, flux_jobid_t, Cstring, Cint, Cstring), h, id, type, severity, note)
end

function flux_job_cancel(h, id, reason)
    ccall((:flux_job_cancel, libflux_core), Ptr{flux_future_t}, (Ptr{flux_t}, flux_jobid_t, Cstring), h, id, reason)
end

function flux_job_kill(h, id, signum)
    ccall((:flux_job_kill, libflux_core), Ptr{flux_future_t}, (Ptr{flux_t}, flux_jobid_t, Cint), h, id, signum)
end

function flux_job_set_priority(h, id, priority)
    ccall((:flux_job_set_priority, libflux_core), Ptr{flux_future_t}, (Ptr{flux_t}, flux_jobid_t, Cint), h, id, priority)
end

function flux_job_kvs_key(buf, bufsz, id, key)
    ccall((:flux_job_kvs_key, libflux_core), Cint, (Cstring, Cint, flux_jobid_t, Cstring), buf, bufsz, id, key)
end

function flux_job_kvs_guest_key(buf, bufsz, id, key)
    ccall((:flux_job_kvs_guest_key, libflux_core), Cint, (Cstring, Cint, flux_jobid_t, Cstring), buf, bufsz, id, key)
end

function flux_job_kvs_namespace(buf, bufsz, id)
    ccall((:flux_job_kvs_namespace, libflux_core), Cint, (Cstring, Cint, flux_jobid_t), buf, bufsz, id)
end

function flux_job_event_watch(h, id, path, flags)
    ccall((:flux_job_event_watch, libflux_core), Ptr{flux_future_t}, (Ptr{flux_t}, flux_jobid_t, Cstring, Cint), h, id, path, flags)
end

function flux_job_event_watch_get(f, event)
    ccall((:flux_job_event_watch_get, libflux_core), Cint, (Ptr{flux_future_t}, Ptr{Cstring}), f, event)
end

function flux_job_event_watch_cancel(f)
    ccall((:flux_job_event_watch_cancel, libflux_core), Cint, (Ptr{flux_future_t},), f)
end

function MPIR_Breakpoint()
    ccall((:MPIR_Breakpoint, libflux_core), Cvoid, ())
end

function get_mpir_being_debugged()
    ccall((:get_mpir_being_debugged, libflux_core), Cint, ())
end

function set_mpir_being_debugged(v)
    ccall((:set_mpir_being_debugged, libflux_core), Cvoid, (Cint,), v)
end
