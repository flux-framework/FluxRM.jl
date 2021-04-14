struct JobSubmission
    flux::Flux
    fut::Future
end

function submit(flux::Flux, jobspec::JobSpec.Jobspec, urgency=16)
    handle = API.flux_job_submit(flux, JSON3.write(jobspec), urgency, FluxRM.API.FLUX_JOB_DEBUG | FluxRM.API.FLUX_JOB_WAITABLE #= | FluxRM.API.FLUX_JOB_PRE_SIGNED=#)
    Libc.systemerror("flux_job_submit", handle == C_NULL)
    JobSubmission(flux, Future(handle))
end

struct Job
    flux::Flux
    id::API.flux_jobid_t
end

function Job(jobsub::JobSubmission)
    r_id = Ref{API.flux_jobid_t}()
    err = API.flux_job_submit_get_id(jobsub.fut, r_id)
    if err == -1
        errstr = API.flux_future_error_string(job)
        error(Base.unsafe_string(errstr))
    end
    Libc.systemerror("flux_job_submit_get_id", err == -1)
    Job(jobsub.flux, r_id[])
end

function Job(flux, id::String)
    r_id = Ref{API.flux_jobid_t}()
    err = API.flux_job_id_parse(id, r_id)
    Libc.systemerror("flux_job_id_parse", err == -1)
    Job(flux, r_id[])
end

function encode(job::Job, encoding="f58")
    buf = Array{UInt8}(undef, 128)
    err = API.flux_job_id_encode(job.id, encoding, buf, length(buf))
    Libc.systemerror("flux_job_id_encode", err == -1)
    i = findfirst(iszero, buf)
    if i !== nothing
        resize!(buf, i-1)
    end
    return String(buf)
end

function Base.wait(job::Job)
    handle = API.flux_job_wait(job.flux, job.id)
    fut = Future(handle)

    r_success = Ref{Bool}()
    r_errstr = Ref{Ptr{Cchar}}()
    err = API.flux_job_wait_get_status(fut, r_success, r_errstr)
    Libc.systemerror("flux_job_wait_get_status", err == -1)
    if !r_success[]
        error(Base.unsafe_string(r_errstr[]))
    end
    return 
end

function kill_async(job::Job, signum=Base.SIGTERM)
    handle = API.flux_job_kill(job.flux, job.id, signum)
    return Future(handle)
end

function Base.kill(job::Job, signum=Base.SIGTERM)
    wait(kill_async(job, signum))
end

function cancel_async(job::Job, reason=nothing)
    if reason === nothing
        reason = C_NULL
    end
    handle = API.flux_job_cancel(job.flux, job.id, reason)
    return Future(handle)
end

function cancel(job::Job, reason=nothing)
    wait(cancel_async(job, reason))
end

