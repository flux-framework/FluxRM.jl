using Libdl

if haskey(ENV, "JULIA_FLUX_LIB")
    libflux_core = ENV["JULIA_FLUX_LIB"]
else
    libflux_core = Libdl.find_library(["libflux-core"], [])
    if libflux_core == ""
        error("Did not find libflux-core.so, please set the JULIA_FLUX_LIB environment variable.")
    end
end

deps = quote
    const libflux_core = $libflux_core
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
