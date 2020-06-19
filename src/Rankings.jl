module Rankings

"""
    @ranking_str -> Dict

Parse human description of the ranking into dictionary
of alternatives' names as keys and their priorities
in the ranking as values.

# Examples
```jldoctest
julia> print(ranking"a₃,a₂,a₁∼a₄")
Dict("a₃"=>0,"a₁"=>-2,"a₄"=>-2,"a₂"=>-1)

julia> print(ranking"B (E A)(C D) F")
Dict("B"=>0,"A"=>-1,"C"=>-2,"D"=>-2,"E"=>-1,"F"=>-3)

julia> print(ranking"(O₂,O₃),O₄,(O₁,O₅)")
Dict("O₄"=>-1,"O₃"=>0,"O₁"=>-2,"O₅"=>-2,"O₂"=>0)

julia> print(ranking"a≻b≻d≻c")
Dict("c"=>-3,"b"=>-1,"a"=>0,"d"=>-2)

julia> print(ranking"AIFDHCBEJG")
Dict("B"=>-6,"A"=>0,"I"=>-1,"J"=>-8,"C"=>-5,"D"=>-3,"G"=>-9,"E"=>-7,"F"=>-2,"H"=>-4)

julia> print(ranking"54132")
Dict("4"=>-1,"1"=>-2,"5"=>0,"2"=>-4,"3"=>-3)
```
"""
:(ranking"")
:(Ранжирование"")


using Tokenize

export @ranking_str, ⦸, @Ранжирование_str

include("op_obslash.jl")
include("parse_data.jl")

macro ranking_str(s::String) ; parse_ranking(s) ; end
macro Ранжирование_str(s::String) ; parse_ranking(s) ; end

end # module

