reorder(M::Matrix, V::Vector{Int}) = M[V,V]


function upper_sum(array::Matrix)
    S, (H,W) = 0, size(array)
    @assert W == H
    for i=1:H, j=i+1:W  S += array[i,j] end
    return S
end


function score_mat_cum_zeros(score_mat::Matrix, permutation::Vector,
                             to_shift = Array{Pair{Int,Int},1}())
    N = size(score_mat)[1]
    @assert size(score_mat)[2] == N
    @assert size(permutation)[1] == N
    @assert isperm(permutation) == true

    for u = 1:N
        perm_u = permutation[u]
        cumsum = score_mat[perm_u,perm_u]
        @assert cumsum == 0
        for v = u-1:-1:1
            cumsum += score_mat[perm_u,permutation[v]]
            cumsum == 0 && push!(to_shift, u=>v)
        end
        cumsum = score_mat[perm_u,perm_u]
        for v = u+1:N
            cumsum += score_mat[perm_u,permutation[v]]
            cumsum == 0 && push!(to_shift, u=>v)
        end
    end
    return to_shift
end


function rotate_part!(transformed::Vector, pair::Pair{Int,Int})
    (u, v) = pair; to_move = transformed[u]
    if u > v
        for k = u:-1:v+1 transformed[k] = transformed[k-1] end
    else
        for k = u:v-1 transformed[k] = transformed[k+1] end
    end
    transformed[v] = to_move
end


function slide_on_level(score_mat::Matrix, some_perm::Vector)
    N = size(score_mat)[1]
    @assert size(score_mat)[2] == N
    @assert size(some_perm)[1] == N
    @assert isperm(some_perm)
    visited, perms = 0, Vector{Vector{Int}}()

    @info "Collecting equivalent permutations..."
    push!(perms, some_perm)

    amount = length(perms)
    while visited < amount
        for i = visited+1:amount
            next_perm = perms[i]
            pairs = score_mat_cum_zeros(score_mat, next_perm)
            for pair in pairs
                permutation = copy(next_perm)
                rotate_part!(permutation, pair)
                in(permutation, perms) && continue
                push!(perms, permutation)
            end
        end
        visited = amount
        amount = length(perms)
        @debug "$amount\r"
        if amount > 20000
            @warn "More than 20k permutations!"
            break
        end
    end
    return sort(perms)
end


function is_refinable(array::Matrix)
    (N,M) = size(array)
    @assert N == M

    for i=1:N
        cumsum = 0
        for j=i-1:-1:1
            cumsum += array[i,j]
            if cumsum < 0
                array[i,j] == 0 && continue
                @info "$i=>$j : $cumsum"
            end
        end
        cumsum = 0
        for j=i+1:N
            cumsum += array[i,j]
            if cumsum > 0
                array[i,j] == 0 && continue
                @info "$i=>$j : $cumsum"
            end
        end
    end
    nothing
end


function dive_into(score_mat::Matrix, some_perm::Vector)
    (N,M) = size(score_mat)
    @assert N == M
    @assert isperm(some_perm)
    @assert N == size(some_perm)[1]
    steps = Dict{Pair{Int,Int},Int}()

    for i=1:N
        cumsum = 0
        for j=i-1:-1:1
            elem = reorder(score_mat,some_perm)[i,j]
            cumsum += elem
            if cumsum < 0
                elem == 0 && continue
                steps[i=>j] = cumsum
		@debug "$i=>$j : $cumsum"
            end
        end
        cumsum = 0
        for j=i+1:N
            elem = reorder(score_mat,some_perm)[i,j]
            cumsum += elem
            if cumsum > 0
                elem == 0 && continue
                steps[i=>j] = cumsum
		@debug "$i=>$j : $cumsum"
            end
        end
    end
    return steps
end


function find_key_of_maxvalue(divedict::Dict{Pair{Int,Int},Int})
    maxvalue = 0
    maxvaluekey = nothing
    for ((from,to),val) in divedict
        abs(val) < maxvalue && continue
        maxvalue = abs(val)
        maxvaluekey = from=>to
    end
    return maxvaluekey
end


function col_optimize(score_mat::Matrix)
    permutation = sortperm(col_negs_sums(score_mat))
    @debug "$permutation : $(upper_sum(reorder(score_mat, permutation)))"
    step = 1
    while true
        divedict = dive_into(score_mat, permutation)
        way = find_key_of_maxvalue(divedict)
        way == nothing && break
        rotate_part!(permutation, way)
        @debug "($step) $way -> $permutation : $(upper_sum(reorder(score_mat, permutation)))"
        step += 1
    end
    @info "col_optimize() stopped at $permutation."
    @info "Upper-triangle sum is $(upper_sum(reorder(score_mat, permutation)))."
    return slide_on_level(score_mat, permutation)
end


function row_optimize(score_mat::Matrix)
    permutation = reverse(sortperm(row_negs_sums(score_mat)))
    @debug "$permutation : $(upper_sum(reorder(score_mat, permutation)))"
    step = 1
    while true
        divedict = dive_into(score_mat, permutation)
        way = find_key_of_maxvalue(divedict)
        way == nothing && break
        rotate_part!(permutation, way)
        @debug "($step) $way -> $permutation : $(upper_sum(reorder(score_mat, permutation)))"
        step += 1
    end
    @info "row_optimize() stopped at $permutation."
    @info "Upper-triangle sum is $(upper_sum(reorder(score_mat, permutation)))."
    return slide_on_level(score_mat, permutation)
end


function consensus(score_mat::Matrix)
    @assert score_mat' == -score_mat
    solution = Vector{Vector{Int}}()
    @info "Sum of negative values is $(sum(score_mat[score_mat.<0]))."
    if is_straight(score_mat)
        @info "Unique permutation"
        push!(solution, sortperm(col_negs(score_mat)))
    else
        if is_crossing(score_mat)
            @warn "Unavoidable excess!"
            @show Δ⁺(score_mat)
        else
            @show Δ⁺(score_mat)
            @assert Δ⁺(score_mat) == 0
        end
        col_pack = col_optimize(score_mat)
        col_reached = upper_sum(reorder(score_mat, col_pack[1]))
        row_pack = row_optimize(score_mat)
        row_reached = upper_sum(reorder(score_mat, row_pack[1]))
        if col_reached > row_reached
            @info "Upper-triangle sum reached: $row_reached"
            solution = row_pack
        else
            @info "Upper-triangle sum reached: $col_reached"
            solution = col_pack
        end
    end
    return solution
    nothing
end
