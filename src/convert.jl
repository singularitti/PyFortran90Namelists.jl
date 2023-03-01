export fparse, fstring

function fparse(::Type{T}, s::AbstractString) where {T<:Integer}
    return parse(T, s)
end
function fparse(::Type{T}, s::AbstractString) where {T<:Float32}
    return parse(T, replace(lowercase(s), r"(?<=[^e])(?=[+-])" => "f"))
end
function fparse(::Type{T}, s::AbstractString) where {T<:Float64}
    return parse(T, replace(lowercase(s), r"d"i => "e"))
end
function fparse(::Type{Complex{T}}, str::AbstractString) where {T<:AbstractFloat}
    if first(str) == '(' && last(str) == ')' && length(split(str, ',')) == 2
        re, im = split(str[2:(end - 1)], ','; limit=2)
        return Complex(parse(T, re), parse(T, im))
    else
        throw(Meta.ParseError("$str must be in complex number form (x, y)."))
    end
end
function fparse(::Type{Bool}, s::AbstractString)
    str = lowercase(s)
    if str in (".true.", ".t.", "true", 't')
        return true
    elseif str in (".false.", ".f.", "false", 'f')
        return false
    else
        throw(Meta.ParseError("$str is not a valid logical constant."))
    end
end
function fparse(::Type{String}, str::AbstractString)
    m = match(r"([\"'])((?:\\\1|.)*?)\1", str)
    if m === nothing
        throw(Meta.ParseError("$str is not a valid string!"))
    else
        quotation_mark, content = m.captures
        # Replace escaped strings
        return string(replace(content, repeat(quotation_mark, 2) => quotation_mark))
    end
end

fstring(v::Integer) = string(v)
function fstring(v::Float32; scientific::Bool=false)
    str = string(v)
    return scientific ? replace(str, r"f"i => "e") : str
end
function fstring(v::Float64, scientific::Bool=false)
    str = string(v)
    return scientific ? replace(str, r"e"i => "d") : str
end
fstring(v::Bool) = v ? ".true." : ".false."
fstring(v::Union{AbstractString,AbstractChar}) = "'" * v * "'"
# fstring(::Namelist)  # TODO:
