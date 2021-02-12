module FluxRM

include("api.jl")

function version()
    major = Ref{Cint}()
    minor = Ref{Cint}()
    patch = Ref{Cint}()

    API.flux_core_version(major, minor, patch)
    Base.VersionNumber(major[], minor[], patch[])
end

end # module
