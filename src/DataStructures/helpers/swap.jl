
mutable struct WrapArray{T,N} <: AbstractArray{T,N}
    a::Array{T,N}
end

function swap!(x::WrapArray{T,N}, y::WrapArray{T,N}) where {T,N}
    x.a, y.a = y.a, x.a
    return x, y
end
