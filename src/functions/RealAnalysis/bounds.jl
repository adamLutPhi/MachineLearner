#= Julia Directory credits to
hong taoh
https://hongtaoh.com/en/2021/07/11/julia-directory/#to-go-up-by-more-than-one-level
Xie Xie!
=#
include("../../constants.jl") #seems correct directory - works as expected

#=
pwd()
projectDirectory= dirname(pwd()) #projectDirectory
homeDirectory = homedir()
appDirectory = @__DIR__ #ideal root node to navigate from
constraintsLoc = "src/constants.jl"
directory = appDirectory * "/" * constraintsLoc

# errors in here /Users/ahmadlutfi/github/DeepLearner/src/functions/RealAnalysis/bounds.jl
#/Users/ahmadlutfi/github/DeepLearner/src/constants.jl
# TODO: need for a dynamic directory resolution , from a String

#1. need to go up , 2 directories [exactly]

cd("../..")


```
starting from the directory of this file
go up 3 directories
```
=#




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
