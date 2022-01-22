include("src/constants.jl")

export leastUpperBound, greateestLowerBound,sup,inf

module bounds

#--- range struct: a custom range structure

```
rangeStruct

initialized to -∞ +infity
```
mutable struct rangeStruct{a,b}
    a=-Inf;b=Inf
end



#---
function leastUpperBound(rangeStruct)

return sup(rangeStruct)
end

```
the least UpperBound
returns the supremum ` or the sup ("soup")`
```
return sup(range)
end



# greatest Upper Bound

```
# Infimum function
is the Greatest upper bound
[me: of an (Unordered) Collection]


```
function inf(rangeStruct)

end


function greatestLowerBound(rangeStruct)

    return inf(rangeStruct)
end
