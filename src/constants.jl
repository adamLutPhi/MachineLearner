using Test
module constants
#MathConstants.
global const ϕ = nothing
global const ∞ = Inf
global const -∞ = -Inf

end 
#end
#Ε(x) = exp(x)
#error function  ϵ (generic , cherry-picked, smooth)
#global ϵ(x) =  exp(x)^-1

#end
#end

#--- Testing area #craziness allowed
module accurateDigits
#digits accuracy
"""
```inputs:
y: error function 
returns number of accurate (at least) 
TODO: How to test this test? 

Yeilds an error ϵ with
at least the number of Digits required (or better)

note: this is not a linear function
it exponentially goes to z

the logic:using the rule
"if an error has a digit 0, that means the digit
    (associated with this error) is accurate"

a homebrewed way, fabricated out of the spaciousness  #novel
#TODO: How to verify this is correct? #need for a verification method
"""
global ϵ(x) = exp(x)^-1 ##beging with a monotonically decreasomg (survival) funtion- that is smooth  -this enforces a constantly increasing 
#=
function valuate(value)
    if value isa Inf value = ∞ 
    elseif value isa -Inf value = -∞
    elseif value isa nothing || Nothing ||"" value = ϕ  

    return value 
end
=#

using Test, Plots 
#digi(n::Int64, x::Int64, y::Float64
function digi(;n = 6, x = 1) # y = exp(x))
    print(typeof(x))
    return ϵ(log2(n) * x)
end

digi(n=1)
digi(n=0)

digi(n=10^6)
digi(n=10^10)



end 
#digi

#=
#diffDigi(a::Int64, b::Int64)
function diffDigi(a = 5, b = 6)
    return digi(b) - digi(a)
end
#=
    digi = 6
    _6 = ϵ(digi * exp(1))
    ϵ(12)

    digi1 = 5
    _5 = ϵ(digi1 * exp(1))

    #for getting rid of non-linearity (hopefully)
    #subtract between 2 consequtive (non-linear) numbers

    diff = _5 - _6
    #=
    as of result we'd lost a bit of accuracy compared to 6
    but 'diff' function is linear
    =#

    _7 = ϵ(7 * exp(1))
=#

function maxEuclidDigi(;a = 5, b = 6)
    _a = digi(a)
    _b = digi(b)
    #maximal #mean euclidean distance
    meanDiff = (max(_a, _b) - min(_a, _b)) / 2
    return meanDiff
end
#= TODO:UNCOMMENT 
@test _ϵ = maxEuclidDigi(5, 6)
@test diffDigi(5, 6)
@test diffDigi(5, 6) > maxEuclidDigi(5, 6) #there was an error during testing
end 
end

@test maxEuclidDigi(5, 6)
@test diffDigi(5, 6)
@test diffDigi(5, 6) > maxEuclidDigi(5, 6) #there was an error during testing
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


