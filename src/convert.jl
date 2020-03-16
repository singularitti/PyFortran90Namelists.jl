using Compat: isnothing

export FortranData, fstring, @f_str

struct FortranData{T<:AbstractString}
    data::T
end

macro f_str(str)
    return :(FortranData($str))
end

function Base.parse(::Type{T}, s::FortranData) where {T<:Integer}
    return parse(T, s.data)
end
function Base.parse(::Type{T}, s::FortranData) where {T<:Float32}
    return parse(T, replace(lowercase(s.data), r"(?<=[^e])(?=[+-])" => "f"))
end
function Base.parse(::Type{T}, s::FortranData) where {T<:Float64}
    return parse(T, replace(lowercase(s.data), r"d"i => "e"))
end
function Base.parse(::Type{Complex{T}}, s::FortranData) where {T<:AbstractFloat}
    str = s.data
    if first(str) == '(' && last(str) == ')' && length(split(str, ',')) == 2
        re, im = split(str[2:end-1], ',', limit = 2)
        return Complex(parse(T, re), parse(T, im))
    else
        throw(Meta.ParseError("$str must be in complex number form (x, y)."))
    end
end
function Base.parse(::Type{Bool}, s::FortranData)
    str = lowercase(s.data)
    if str in (".true.", ".t.", "true", 't')
        return true
    elseif str in (".false.", ".f.", "false", 'f')
        return false
    else
        throw(Meta.ParseError("$str is not a valid logical constant."))
    end
end
function Base.parse(::Type{T}, s::FortranData) where {T<:AbstractString}
    str = s.data
    m = match(r"([\"'])((?:\\\1|.)*?)\1", str)
    isnothing(m) && throw(Meta.ParseError("$str is not a valid string!"))
    quotation_mark, content = m.captures
    # Replace escaped strings
    return string(replace(content, repeat(quotation_mark, 2) => quotation_mark))
end

fstring(v::Int) = FortranData(string(v)) |> string
function fstring(v::Float32; scientific::Bool = false)
    str = string(v)
    scientific && return FortranData(replace(str, r"f"i => "e"))
    return FortranData(str) |> string
end
function fstring(v::Float64; scientific::Bool = false)
    str = string(v)
    scientific && return FortranData(replace(str, r"e"i => "d"))
    return FortranData(string(v)) |> string
end
fstring(v::Bool) = string(v ? FortranData(".true.") : FortranData(".false."))
fstring(v::Union{AbstractString,AbstractChar}) = FortranData("'$v'") |> string
# fstring(::Namelist)  # TODO:

function Base.string(s::FortranData)
    return string(s.data)
end