
function swap!(x::{Float64, 1}, y::{Float64, 1}) where {T,N}
    x, y = y, x
end

"""
A wrapper 
around Array{T,N} 
but in application: it could be anything, simply put 

```input:
WrapArray{T,N}: inherits defintions from  `AbstractArray{T,N}`, has a type template `T`, & size `N`
````

```output:
 a::Array{T,N} : which has a type of template `T`, & Size N  
```
"""
mutable struct WrapArray{T,N} <: AbstractArray{T,N}
    a::Array{T,N}
end

function swap!(x::WrapArray{T,N}, y::WrapArray{T,N}) where {T,N}
    x.a, y.a = y.a, x.a # a is for any arbitrary item 
    return x, y
end

function swapping(x,y)
    if typeof x==Float64 && y ==Float64
        return swap!(x::{Float64, 1}, y::{Float64, 1})
    elseif typeof x==Array{T,N} && y = Array{T,N}
        return swap!(x::WrapArray{T,N}, y::WrapArray{T,N})
    else 
       println("ERROR: faulty input argiments, or unidentified ERROR")    
    end

#= Redundant: reason: function definiton above includes the definition below 
 
function swap!(x::WrapArray{T,1}, y::WrapArray{T,1}) where {T,N}
    x.a, y.a = y.a, x.a # a is for any arbitrary item 
    return x, y
end 

=#