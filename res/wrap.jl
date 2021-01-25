using Clang

if length(ARGS) != 1
  error("Pass the path to the Flux headers as the first argument")
end

header_dir = ARGS[1]
isdir(header_dir) || error("$header_dir does not exist")

const FLUX_INCLUDE = normpath(header_dir)

# Fails with `include/flux/core/barrier.h:24:1: error: unknown type name 'flux_future_t'`
# as far as I can tell `barrier.h` is not including `future.h`
# headers = ["flux/core.h"]
# core_headers = readdir(joinpath(FLUX_INCLUDE, "flux/core"))
# filter!(h->endswith(h, ".h"), core_headers)
# core_headers = map(h->joinpath("flux/core", h), core_headers)
# append!(headers, core_headers)

# Flux comes with preprocessed bindings for Python
# they still come with some need for fixups
#
# Add: 
#include <stdint.h>
#include <stdbool.h>
#include <stddef.h>
#include <stdarg.h>
#include <unistd.h>
#include <stdio.h>
#
# Comment out: 
# `extern "Python"`
headers = ["flux/_binding/_core_preproc.h"]

FLUX_HEADERS = map(h->joinpath(FLUX_INCLUDE,h), headers)

wc = init(; headers = FLUX_HEADERS,
            output_file = "libflux_h.jl",
            common_file = "libflux_common.jl",
            clang_includes = [FLUX_INCLUDE, CLANG_INCLUDE],
            clang_args = ["-I", FLUX_INCLUDE],
            header_wrapped = (root, current)->root == current,
            header_library = x->"libflux_core",
            )

run(wc)
