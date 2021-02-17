using Clang

if length(ARGS) != 1
  error("Pass the path to the Flux headers as the first argument")
end

header_dir = ARGS[1]
isdir(header_dir) || error("$header_dir does not exist")

const FLUX_INCLUDE = normpath(header_dir)

headers = ["flux/core.h"]
FLUX_HEADERS = map(h->joinpath(FLUX_INCLUDE,h), headers)

# To inlude all of the headers included by `core.h`
function wrapped(root, current)
  if dirname(current) == joinpath(FLUX_INCLUDE, "flux", "core")
    return true
  end
  return root == current
end

wc = init(; headers = FLUX_HEADERS,
            output_file = "libflux_h.jl",
            common_file = "libflux_common.jl",
            clang_includes = [FLUX_INCLUDE, CLANG_INCLUDE],
            clang_args = ["-I", FLUX_INCLUDE],
            header_wrapped = wrapped,
            header_library = x->"libflux_core",
            )

run(wc)
