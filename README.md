# Rankings.jl

[README in russian](README.ru.md). A way to describe rankings in Julia converting human ranking descriptions to some score matrix.
Uses Julia package [Tokenize.jl](https://github.com/JuliaLang/Tokenize.jl).

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

## Usage

```julia-repl
julia> Литвак1982_86 = ranking"a₂~a₅,a₄,a₁~a₃"⦸
                       ranking"a₁~a₃,a₂,a₅,a₄"⦸
                       ranking"a₁,a₄,a₃~a₅,a₂"⦸
                       ranking"a₄,a₃,a₁~a₂~a₅"⦸
                       ranking"a₃,a₅,a₄,a₁,a₂"
5×5 Array{Int64,2}:
  0  -2   1   1   0
  2   0   3   1   1
 -1  -3   0   1  -2
 -1  -1  -1   0   1
  0  -1   2  -1   0

julia> consensus(Литвак1982_86)
[ Info: Sum of negative values is -13.
┌ Warning: Unavoidable excess!
└ @ Rankings ~/.julia/packages/Rankings/GfcmE/src/consensus.jl:198
Δ⁺(score_mat) = 1
[ Info: col_optimize() stopped at [3, 5, 4, 1, 2].
[ Info: Upper-triangle sum is -11.
[ Info: Collecting equivalent permutations...
[ Info: row_optimize() stopped at [3, 5, 4, 1, 2].
[ Info: Upper-triangle sum is -11.
[ Info: Collecting equivalent permutations...
[ Info: Upper-triangle sum reached: -11
3-element Array{Array{Int64,1},1}:
 [3, 5, 4, 1, 2]
 [4, 3, 1, 5, 2]
 [4, 3, 5, 1, 2]

```

```julia-repl
julia> RankAggregEx = ranking"ABCDE"⦸
                      ranking"BDAEC"⦸
                      ranking"BAECD"⦸
                      ranking"ADBCE"
5×5 Array{Int64,2}:
 0  0  -4  -2  -4
 0  0  -4  -2  -4
 4  4   0   0   0
 2  2   0   0  -2
 4  4   0   2   0

julia> consensus(RankAggregEx)
[ Info: Sum of negative values is -22.
Δ⁺(score_mat) = 0
[ Info: col_optimize() stopped at [1, 2, 4, 3, 5].
[ Info: Upper-triangle sum is -22.
[ Info: Collecting equivalent permutations...
[ Info: row_optimize() stopped at [2, 1, 4, 5, 3].
[ Info: Upper-triangle sum is -22.
[ Info: Collecting equivalent permutations...
[ Info: Upper-triangle sum reached: -22
6-element Array{Array{Int64,1},1}:
 [1, 2, 3, 4, 5]
 [1, 2, 4, 3, 5]
 [1, 2, 4, 5, 3]
 [2, 1, 3, 4, 5]
 [2, 1, 4, 3, 5]
 [2, 1, 4, 5, 3]

```

```julia-repl
julia> Guénoche2017 = ranking"x₁,x₂,x₃,x₄,(x₅,x₆,x₇)"⦸
                      ranking"x₅,x₁,x₂,x₄,x₆,(x₃,x₇)"⦸
                      ranking"x₇,x₆,x₂,x₃,(x₁,x₄,x₅)"⦸
                      ranking"x₅,x₃,x₄,(x₁,x₂,x₆,x₇)"⦸
                      ranking"x₄,x₇,x₅,x₆,x₂,(x₁,x₃)"⦸
                      ranking"x₆,x₁,x₇,x₂,(x₃,x₄,x₅)"
7×7 Array{Int64,2}:
  0  -1  -1  -1   1   1  -1
  1   0  -4  -2   0   1   1
  1   4   0  -1   1   2   1
  1   2   1   0   0  -2  -2
 -1   0  -1   0   0  -1   1
 -1  -1  -2   2   1   0   0
  1  -1  -1   2  -1   0   0

julia> consensus(Guénoche2017)
[ Info: Sum of negative values is -25.
┌ Warning: Unavoidable excess!
└ @ Rankings ~/.julia/packages/Rankings/GfcmE/src/consensus.jl:198
Δ⁺(score_mat) = 2
[ Info: col_optimize() stopped at [5, 1, 2, 4, 6, 7, 3].
[ Info: Upper-triangle sum is -15.
[ Info: Collecting equivalent permutations...
[ Info: row_optimize() stopped at [4, 5, 6, 1, 7, 2, 3].
[ Info: Upper-triangle sum is -15.
[ Info: Collecting equivalent permutations...
[ Info: Upper-triangle sum reached: -15
13-element Array{Array{Int64,1},1}:
 [1, 2, 4, 7, 5, 6, 3]
 [1, 4, 7, 5, 6, 2, 3]
 [4, 5, 6, 1, 7, 2, 3]
 [4, 7, 5, 6, 1, 2, 3]
 [5, 1, 2, 4, 6, 7, 3]
 [5, 1, 2, 4, 7, 6, 3]
 [5, 1, 4, 6, 7, 2, 3]
 [5, 1, 4, 7, 6, 2, 3]
 [5, 4, 6, 1, 7, 2, 3]
 [5, 6, 1, 2, 3, 4, 7]
 [5, 6, 1, 2, 4, 7, 3]
 [5, 6, 1, 7, 2, 3, 4]
 [7, 5, 6, 1, 2, 3, 4]

```

## Acknowledgement

This material is based upon the work supported by the Russian Fund of Basic Research (grant 18-07-00424).
