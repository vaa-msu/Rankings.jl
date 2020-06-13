M(P) = [Int(sign(P[i]-P[j])) for i=1:length(P), j=1:length(P)]
priority(d::Dict{String,Int}) = [d[k] for k in sort([keys(d)...])]

 ⦸(r) = -M(priority(r))
 ⦸(R::Matrix{Int}, r) = R +  ⦸(r)

function  ⦸(r₀, rₛ...)
    R =  ⦸(r₀)
    for r ∈ rₛ ; R =  ⦸(R,r) ; end
    return R
end
