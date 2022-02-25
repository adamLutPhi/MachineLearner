#=
Credits: https://discourse.julialang.org/t/swap-array-contents/7774/12?page=2
Professor Steven @stevengj (physics) MIT lecturer, & an active julia member

=#
#---------------------------------
function swap!(x::Float64, y::Float64)
    x, y = y, x
end
#----------------------------------
function swap!(x::Int64, y::Int64)
    x, y = y, x
end
#-------------------------------------
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
T = Float64;
N = 1;
#------------
"""
```input:
    x: original x value
    y: original y value 
```
```output:
    x: swapped x value 
    y: swapped y value 
```
"""

function oldschoolSwap(x, y)
    tmp = x
    x = y
    y = tmp
    return x, y
end

#---------------------------------------------------
function swap!(x::Array{T,N}, y::Array{T,N}) where {T,N}
    x.a, y.a = y.a, x.a # a is for any arbitrary item 
    return x, y
end
#--------------------------------------------------
function swap!(x::VecOrMat, y::VecOrMat) #where {T,N}
    x.a, y.a = y.a, x.a # a is for any arbitrary item 
    return x, y
end
#----------------------------------------------
#=
function swap!(x::WrapArray{T,N}, y::WrapArray{T,N}) where {T,N}
    x.a, y.a = y.a, x.a # a is for any arbitrary item 
    return x, y
end

#footnote:
Since this is a mutable type, the changes to the contents of x and y would be reflected in all references to those objects elsewhere. As you point out, above, though, this adds an extra indirection to array accesses.

=#
""" A type-Matching function chooses the right function based on given type

```input:
x:  x generic , could be of type Float64 or Array{T,N}
y: 
```

```output:
swap!(x,y) function 
```

Returns `swap!(x::Float64, y::Float64)` or  swap!(x::Array{T,N}, y::Array{T,N})
"""
function swapping(x, y)
    if typeof(x) == typeof(y) == Float64 # && typeof(y) == Float64
        return swap!(x::Float64, y::Float64) #
    elseif typeof(x) == Array{T,N} == typeof(y) # && typeof(y) = Array{T,N}
        return swap!(x::Array{T,N}, y::Array{T,N})
    else
        println("ERROR: faulty input argiments, or unidentified ERROR")
    end
end

#= Redundant: reason: function definiton above includes the definition below 
 
function swap!(x::WrapArray{T,1}, y::WrapArray{T,1}) where {T,N}
    x.a, y.a = y.a, x.a # a is for any arbitrary item 
    return x, y
end 

=#