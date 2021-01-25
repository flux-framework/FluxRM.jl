# Automatically generated using Clang.jl


const flux_free_f = Ptr{Cvoid}
const flux_msg = Cvoid
const flux_msg_t = flux_msg

struct flux_match
    typemask::Cint
    matchtag::UInt32
    topic_glob::Cstring
end

struct flux_msg_cred
    userid::UInt32
    rolemask::UInt32
end

const flux_handle_struct = Cvoid
const flux_t = flux_handle_struct

struct flux_msgcounters_t
    request_tx::Cint
    request_rx::Cint
    response_tx::Cint
    response_rx::Cint
    event_tx::Cint
    event_rx::Cint
    keepalive_tx::Cint
    keepalive_rx::Cint
end

const flux_fatal_f = Ptr{Cvoid}
const flux_buffer = Cvoid
const flux_buffer_t = flux_buffer
const flux_reactor = Cvoid
const flux_reactor_t = flux_reactor
const flux_watcher = Cvoid
const flux_watcher_t = flux_watcher
const flux_watcher_f = Ptr{Cvoid}
const flux_reschedule_f = Ptr{Cvoid}

struct flux_watcher_ops
    start::Ptr{Cvoid}
    stop::Ptr{Cvoid}
    destroy::Ptr{Cvoid}
end

const flux_msg_handler = Cvoid
const flux_msg_handler_t = flux_msg_handler
const flux_msg_handler_f = Ptr{Cvoid}

struct flux_msg_handler_spec
    typemask::Cint
    topic_glob::Cstring
    cb::flux_msg_handler_f
    rolemask::UInt32
end

# Skipping Typedef: CXType_FunctionProto connector_init_f

struct flux_handle_ops
    setopt::Ptr{Cvoid}
    getopt::Ptr{Cvoid}
    pollfd::Ptr{Cvoid}
    pollevents::Ptr{Cvoid}
    send::Ptr{Cvoid}
    recv::Ptr{Cvoid}
    event_subscribe::Ptr{Cvoid}
    event_unsubscribe::Ptr{Cvoid}
    impl_destroy::Ptr{Cvoid}
end

const flux_log_f = Ptr{Cvoid}
const flux_future = Cvoid
const flux_future_t = flux_future
const flux_continuation_f = Ptr{Cvoid}
const flux_future_init_f = Ptr{Cvoid}

@cenum event_flags::UInt32 begin
    FLUX_EVENT_PRIVATE = 1
end


# Skipping Typedef: CXType_FunctionProto mod_main_f
# Skipping Typedef: CXType_FunctionProto flux_moderr_f

@cenum flux_conf_flags::UInt32 begin
    FLUX_CONF_INSTALLED = 0
    FLUX_CONF_INTREE = 1
    FLUX_CONF_AUTO = 2
end


const flux_conf = Cvoid
const flux_conf_t = flux_conf

struct flux_conf_error_t
    filename::NTuple{80, UInt8}
    lineno::Cint
    errbuf::NTuple{160, UInt8}
end

const flux_plugin = Cvoid
const flux_plugin_t = flux_plugin
const flux_plugin_arg = Cvoid
const flux_plugin_arg_t = flux_plugin_arg
const flux_plugin_f = Ptr{Cvoid}
const flux_plugin_init_f = Ptr{Cvoid}

struct flux_plugin_handler
    topic::Cstring
    cb::flux_plugin_f
    data::Ptr{Cvoid}
end

const flux_kvsdir = Cvoid
const flux_kvsdir_t = flux_kvsdir
const flux_kvsitr = Cvoid
const flux_kvsitr_t = flux_kvsitr
const flux_kvs_txn = Cvoid
const flux_kvs_txn_t = flux_kvs_txn

@cenum kvs_commit_flags::UInt32 begin
    FLUX_KVS_NO_MERGE = 1
    FLUX_KVS_TXN_COMPACT = 2
end

@cenum kvs_op::UInt32 begin
    FLUX_KVS_READDIR = 1
    FLUX_KVS_READLINK = 2
    FLUX_KVS_WATCH = 4
    FLUX_KVS_WAITCREATE = 8
    FLUX_KVS_TREEOBJ = 16
    FLUX_KVS_APPEND = 32
    FLUX_KVS_WATCH_FULL = 64
    FLUX_KVS_WATCH_UNIQ = 128
    FLUX_KVS_WATCH_APPEND = 256
end


const flux_command = Cvoid
const flux_cmd_t = flux_command
const flux_subprocess = Cvoid
const flux_subprocess_t = flux_subprocess
const flux_subprocess_server = Cvoid
const flux_subprocess_server_t = flux_subprocess_server

@cenum flux_subprocess_state_t::UInt32 begin
    FLUX_SUBPROCESS_INIT = 0
    FLUX_SUBPROCESS_EXEC_FAILED = 1
    FLUX_SUBPROCESS_RUNNING = 2
    FLUX_SUBPROCESS_EXITED = 3
    FLUX_SUBPROCESS_FAILED = 4
end


const flux_subprocess_f = Ptr{Cvoid}
const flux_subprocess_output_f = Ptr{Cvoid}
const flux_subprocess_state_f = Ptr{Cvoid}
const flux_subprocess_hook_f = Ptr{Cvoid}

struct flux_subprocess_ops_t
    on_completion::flux_subprocess_f
    on_state_change::flux_subprocess_state_f
    on_channel_out::flux_subprocess_output_f
    on_stdout::flux_subprocess_output_f
    on_stderr::flux_subprocess_output_f
end

struct flux_subprocess_hooks_t
    pre_exec::flux_subprocess_hook_f
    pre_exec_arg::Ptr{Cvoid}
    post_fork::flux_subprocess_hook_f
    post_fork_arg::Ptr{Cvoid}
end

@cenum job_submit_flags::UInt32 begin
    FLUX_JOB_PRE_SIGNED = 1
    FLUX_JOB_DEBUG = 2
    FLUX_JOB_WAITABLE = 4
end

@cenum job_priority::UInt32 begin
    FLUX_JOB_PRIORITY_MIN = 0
    FLUX_JOB_PRIORITY_DEFAULT = 16
    FLUX_JOB_PRIORITY_MAX = 31
end

@cenum flux_job_state_t::UInt32 begin
    FLUX_JOB_NEW = 1
    FLUX_JOB_DEPEND = 2
    FLUX_JOB_SCHED = 4
    FLUX_JOB_RUN = 8
    FLUX_JOB_CLEANUP = 16
    FLUX_JOB_INACTIVE = 32
end

@cenum flux_job_result_t::UInt32 begin
    FLUX_JOB_RESULT_COMPLETED = 1
    FLUX_JOB_RESULT_FAILED = 2
    FLUX_JOB_RESULT_CANCELLED = 4
    FLUX_JOB_RESULT_TIMEOUT = 8
end


const flux_jobid_t = UInt64
