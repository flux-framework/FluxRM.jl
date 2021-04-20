using Clang.Generators

if length(ARGS) != 1
  error("Pass the path to the Flux headers as the first argument")
end

header_dir = ARGS[1]
isdir(header_dir) || error("$header_dir does not exist")

const FLUX_INCLUDE = normpath(header_dir)
const FLUX_DIR = joinpath(FLUX_INCLUDE, "flux")

args = ["-I$FLUX_INCLUDE"]

options = load_options(joinpath(@__DIR__, "wrap.toml"))

@add_def pid_t
@add_def UINT_MAX

ctx = create_context(joinpath(FLUX_DIR, "core.h"), args, options)
build!(ctx)

general = options["general"]
general["module_name"] = ""
general["prologue_file_path"] = ""

general["library_name"] = "libflux_hostlist"
general["output_file_path"] = "../src/api_hostlist.jl"
options["codegen"]["library_name"] = "libflux_hostlist"

ctx = create_context(joinpath(FLUX_DIR, "hostlist.h"), args, options)
build!(ctx)

general["library_name"] = "libflux_idset"
general["output_file_path"] = "../src/api_idset.jl"
options["codegen"]["library_name"] = "libflux_idset"

ctx = create_context(joinpath(FLUX_DIR, "idset.h"), args, options)
build!(ctx)
