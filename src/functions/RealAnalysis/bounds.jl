#= Julia Directory credits to
hong taoh
https://hongtaoh.com/en/2021/07/11/julia-directory/#to-go-up-by-more-than-one-level
Xie Xie!
=#

#=
those are testable:
pwd()
projectDirectory= dirname(pwd()) #projectDirectory
homeDirectory = homedir()
appDirectory = @__DIR__ #ideal root node to navigate from
constraintsLoc = "src/constants.jl"
directory = appDirectory * "/" * constraintsLoc

the Plan:
#1. need to go up , 2 directories [exactly]

cd("../..")
=#
include("../../constants.jl") #seems correct directory - works as expected (on mac os)- seems fine on windows too 

export leastUpperBound, greateestLowerBound, sup, inf

"""
it depends on the function'S Characteristics 

    1. Continous?
    2. discrete (set)?

the Common Issues:

Is the function defined over the  specified range?
-> check for continuity (over Range) #TODO
"""
module bounds

#Data tructure
#(Generalized) function
add2(x) = x[1] + x[2]

"""
function 
    ```inputs : arr: array (me: <: AbstractArray{T,N})



    ```
"""



#--- range struct: a custom range structure

mutable struct rangeStruct{a,b}


    """
    rangeStruct

    initialized to -∞ +infity
    """

    a = -∞
    b = ∞
end



#---
function leastUpperBound(rangeStruct)
    """
    the least UpperBound
    returns the supremum ` or the sup ("soup")`
    """
    return sup(rangeStruct)

end


#return sup(range)


# greatest Upper Bound


function inf(rangeStruct)
    """
    # Infimum function
    is the Greatest upper bound
    [me: of an (Unordered) Collection]
    TODO: finish coding

    """

end


function greatestLowerBound(rangeStruct)

    return inf(rangeStruct)
end


end



