
function parse_ranking(s::String)
    d = Dict{String,Int}()
    if match(r"[\s,\(\)~∼≻]",s) === nothing
        Arr = split(s,"")
        for i = 1:length(Arr)
            haskey(d,Arr[i]) && @error("Duplicated identifier!")
            d[Arr[i]] = 1 - i
        end
    else
        parse_tokens!(s, d)
    end
    return d
end

function parse_tokens!(s::String, d::Dict{String,Int})
    in_equi_p = false
    weight_step = 1
    rel_weight = 0
    rk_expr = collect(tokenize(s))
    for tok in rk_expr
        if Tokens.kind(tok) == Tokens.IDENTIFIER
            token_string = Tokens.untokenize(tok)
            haskey(d,token_string) && @error("Duplicated identifier!")
            d[token_string] = rel_weight
            rel_weight -= weight_step
        elseif Tokens.kind(tok) == Tokens.LPAREN
            if in_equi_p
                @error("Unexpected opening parenthesis")
            else
                in_equi_p = true
                weight_step = 0
            end
        elseif Tokens.kind(tok) == Tokens.RPAREN
            if in_equi_p
                in_equi_p = false
                weight_step = 1
                rel_weight -= weight_step
            else
                @error("Unexpected closing parenthesis")
            end
        elseif Tokens.kind(tok) == Tokens.OP && Tokens.untokenize(tok) == "~"  ||
               Tokens.kind(tok) == Tokens.ERROR && Tokens.untokenize(tok) == "∼" # \sim
            rel_weight += weight_step
        else
            continue
        end
    end
    if in_equi_p
        @warn("Opened parenthesis is not closed")
    end
    if length(d) == 0    
        @error("No identifier found!")
    end
end
