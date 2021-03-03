using Clang.Generators

if length(ARGS) != 1
  error("Pass the path to the Flux headers as the first argument")
end

header_dir = ARGS[1]
isdir(header_dir) || error("$header_dir does not exist")

const FLUX_INCLUDE = normpath(header_dir)
const FLUX_DIR = joinpath(FLUX_INCLUDE, "flux")
const FLUX_HEADERS = [joinpath(FLUX_DIR, header) for header in readdir(FLUX_DIR)]

args = ["-I$FLUX_INCLUDE"]

options = load_options(joinpath(@__DIR__, "wrap.toml"))

@add_def pid_t

ctx = create_context(FLUX_HEADERS, args, options)

build!(ctx)
