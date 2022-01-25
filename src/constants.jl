using Test
module constants

#MathConstants.
global const ϕ = nothing
global const ∞ = Inf
global const -∞ = -Inf


#Ε(x) = exp(x)
#error function  ϵ (generic , cherry-picked smooth)
global ϵ(x) =  exp(x)^-1

#end


#--- Testing area #craziness allowed

function accurateDigits()
    #digits accuracy
    """
    TODO: How to test this test? 

    Yeilds an error ϵ with
    at least the number of Digits required (or better)

    note: this is not a linear function
    it exponentially goes to z

    the logic:using the rule
    "if an error has a digit 0, that means the digit
        (associated with this error) is accurate"

    a homebrewed way, fabricated out of the spaciousness
    in the head - Creativity
    """

    digi = 6
    _6 = ϵ(digi * exp(1))
    ϵ(12)

    digi1 = 5
    _5 = ϵ(digi1 * exp(1))

    #for getting rid of non-linearity
    #subtract between 2 consequtive numbers

    diff = _5 - _6
    #=
    as of result we'd lost a bit of accuracy compared to 6
    but 'diff' function is linear
    =#

    _7 = ϵ(7 * exp(1))

    #maximal euclidean distance
    diff = (max(_5, _6) - min(_5, _6)) / 2
    return diff
end

end 

#=
digi=6
_6 = ϵ(digi*exp(1))
ϵ(12)

digi1 = 5
_5 = ϵ(digi1*exp(1))

#for getting rid of non-linearity
#subtract between 2 consequtive numbers

diff = _5 - _6
=#

#=
as of result we'd lost a bit of accuracy compared to 6
but 'diff' function is linear


_7 = ϵ(7*exp(1))

#maximal euclidean distance
diff = (max(_5,_6) - min(_5,_6) )/2

#@test
end
=#


