using Libdl

paths = String[]
if haskey(ENV, "JULIA_FLUX_PATH")
    push!(paths, ENV["JULIA_FLUX_PATH"])
end

libflux_core = Libdl.find_library(["libflux-core"], paths)
libflux_hostlist = Libdl.find_library(["libflux-hostlist"], paths)
libflux_idset = Libdl.find_library(["libflux-idset"], paths)

if libflux_core == "" || libflux_hostlist == "" || libflux_idset == ""
    @error "Unable to find the libflux-* libraries" libflux_core libflux_hostlist libflux_idset
    error("Did not find necessary libraries, please set the JULIA_FLUX_PATH environment variable.")
end

deps = quote
    const libflux_core = $libflux_core
    const libflux_hostlist = $libflux_hostlist
    const libflux_idset = $libflux_idset
end

remove_line_numbers(x) = x
function remove_line_numbers(ex::Expr)
    if ex.head == :macrocall
        ex.args[2] = nothing
    else
        ex.args = [remove_line_numbers(arg) for arg in ex.args if !(arg isa LineNumberNode)]
    end
    return ex
end

# only update deps.jl if it has changed.
# allows users to call Pkg.build("FluxRM") without triggering another round of precompilation
deps_str = string(remove_line_numbers(deps))

if !isfile("deps.jl") || deps_str != read("deps.jl", String)
    write("deps.jl", deps_str)
end
