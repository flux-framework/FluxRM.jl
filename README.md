# FluxRM.jl
Julia Bindings for the Flux Resource Manager (RM)

## Development

Use [`Revise.jl`](https://github.com/timholy/Revise.jl) to interactivly edit the package code.

### Using Spack

```
spack env create flux
spack activate flux # Choose the right operation for your shell

spack install flux-core
spack concretize
```
