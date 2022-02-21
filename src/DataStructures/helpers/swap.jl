
mutable struct WrapArray{T,N} <: AbstractArray{T,N}
    a::Array{T,N}
end

function swap!(x::{Float64,1},y::{Float64,1}) where  {T,N}
    
end
function swap!(x::WrapArray{T,N}, y::WrapArray{T,N}) where {T,N}
    x.a, y.a = y.a, x.a # a is for any arbitrary item 
    return x, y
end
