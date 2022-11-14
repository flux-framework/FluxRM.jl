using FluxRM
import FluxRM: API, poll_fd

# double flux_reactor_resume_timeout(flux_reactor_t *r);
function flux_reactor_resume_timeout(r)
    ccall((:flux_reactor_resume_timeout, API.libflux_core), Cdouble, (Ptr{API.flux_reactor_t},), r)
end

function callback(flux, events)
    r = API.flux_get_reactor(flux)
    API.flux_reactor_run(r, API.FLUX_REACTOR_ONCE)
end

function check_start(flux::Flux)
    errormonitor(@async begin
        while true
            @show events = API.flux_pollevents(flux)
            callback(flux, events)

            @show to = flux_reactor_resume_timeout(API.flux_get_reactor(flux))

            GC.safepoint()
            if to < 1e-100
                yield() # idle
            else
                wait(Timer(to))
            end
        end
    end)
end

function default_callback(future, ctx)
    err = API.flux_future_get(future, C_NULL)
    @info "default callback" err
    if err == -1
        errno = Libc.errno()
        println("flux_job_wait_get_status", errno)
    else
        println("succss")
    end
    return
end

let flux = Flux()
    check_start(flux)
    fut = API.flux_kvs_lookup(flux, C_NULL, 0, "resource.R")
    Libc.systemerror("flux_kvs_lookup", flux == C_NULL)
    API.flux_future_then(
        fut, -1,
        @cfunction(default_callback, Cvoid, (Ptr{API.flux_future_t}, Ptr{Cvoid})), C_NULL)
    sleep(5)
end
