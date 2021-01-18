
col_negs(A::Matrix) = [sum(A[:,j].<0) for j=1:size(A)[2]]
row_negs(A::Matrix) = [sum(A[i,:].<0) for i=1:size(A)[1]]
negs(A) = (row_negs(A), col_negs(A))

straight_cols(A) = all(sort(col_negs(A)).==Vector(0:size(A)[2]-1))
straight_rows(A) = all(sort(row_negs(A)).==Vector(0:size(A)[1]-1))
is_straight(A) = straight_cols(A) && straight_rows(A)

crossing_cols(A) = any(sort(col_negs(A)).>Vector(0:size(A)[2]-1))
crossing_rows(A) = any(sort(row_negs(A)).>Vector(0:size(A)[1]-1))
is_crossing(A) = crossing_cols(A) || crossing_rows(A)


⊖(a::Vector, b::Vector, ⊟₁= >, ⊟₂= -) = (a.⊟₁b)⋅(a.⊟₂b)

Δᶜ⁺(A::Matrix) = sort(col_negs(A)) ⊖ Vector(0:size(A)[2]-1)
Δʳ⁺(A::Matrix) = reverse(sort(row_negs(A))) ⊖ Vector(size(A)[1]-1:-1:0)

Δ⁺(A) = max(Δᶜ⁺(A), Δʳ⁺(A))

Δᶜ⁻(A::Matrix) = Vector(0:size(A)[2]-1) ⊖ sort(col_negs(A))
Δʳ⁻(A::Matrix) = Vector(size(A)[1]-1:-1:0) ⊖ reverse(sort(row_negs(A)))


col_negs_sums(A::Matrix) = [sum(zeros(eltype(A),size(A)[2])⊖A[:,j]) for j=1:size(A)[2]]
row_negs_sums(A::Matrix) = [sum(zeros(eltype(A),size(A)[1])⊖A[i,:]) for i=1:size(A)[1]]
negs_sums(A) = (row_negs_sums(A), col_negs_sums(A))
