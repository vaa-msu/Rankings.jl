# Rankings.jl

A way to describe rankings in Julia converting human ranking descriptions to some score matrix.
Uses Julia package [Tokenize.jl](https://github.com/JuliaLang/Tokenize.jl). [README in russian](README.ru.md)

## Installation

Since the package is currently not registered you should install it with `Pkg.clone`.
Start a Julia session and type
```julia-repl
julia> using Pkg; Pkg.clone("https://github.com/vaa-msu/Rankings.jl")
```
After installation, the next command is
```julia-repl
julia> using Rankings
```

## Acknowledgement

This material is based upon the work supported by the Russian Fund of Basic Research (grant 18-07-00424).
