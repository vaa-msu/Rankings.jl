module Rankings

using Tokenize

export @ranking_str, ⦸, @Ранжирование_str

include("op_obslash.jl")
include("parse_data.jl")

macro ranking_str(s::String) ; parse_ranking(s) ; end
macro Ранжирование_str(s::String) ; parse_ranking(s) ; end

end # module

