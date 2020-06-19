M(P) = [Int(sign(P[i]-P[j])) for i=1:length(P), j=1:length(P)]
preference(d::Dict{String,Int}) = [d[k] for k in sort([keys(d)...])]

"""
    ⦸(d₁, d₂[, dₛ...])

Return "light" preference matrix of given rankings.
A binary (infix) operation on two or more rankings.

# Examples
```jldoctest
julia> ranking"a₂,a₄,a₁,a₃" ⦸ 
       ranking"a₁,a₃∼a₄,a₂" ⦸
       ranking"a₂∼a₃,a₄,a₁" ⦸ 
       ranking"a₃,a₂,a₁∼a₄"
4×4 Array{Int64,2}:
  0   2  0   1
 -2   0  1  -2
  0  -1  0  -1
 -1   2  1   0

julia> ⦸(ranking"123",ranking"231",ranking"312")
3×3 Array{Int64,2}:
  0  -1   1
  1   0  -1
 -1   1   0
```
"""
function  ⦸(d₁::Dict{String,Int}, d₂::Dict{String,Int}, dₛ::Dict{String,Int}...)
    @assert length(d₁) == length(d₂)
    @assert sort([keys(d₁)...]) == sort([keys(d₂)...])
    R =  -M(preference(d₁))-M(preference(d₂))
    for d ∈ dₛ 
        @assert size(R)[1] == size(R)[2] == length(d)
        @assert sort([keys(d₁)...]) == sort([keys(d)...])
        R = ⦸(R, d)
    end
    return R
end

⦸(R::Matrix{Int}, d::Dict{String,Int}) = R - M(preference(d))

