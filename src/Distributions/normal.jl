#include("./functions")
#include("~/functions")
#if Sys. 
include("../functions/SmoothFunctions/smoothFunction.jl")
module normal <: genericDistribution 


export sqrt2π, pdf, cdf

#const π = pi
const sqrt2π = sqrt(2 * pi) # contains irrationals
const sqrt2πRational = rational(sqrt2π) # a rational version 

"""
Rule: minimal use of external Modules 
-More use to Applied ...
TODO: Apply Integration on the pdf ( to get the CDF)
TODO: do a generalized smooth function, taking numeraor,denominator
""" 


"""zscore function

the Expectation (E) #Idea: most likely function generator 
use a randomGenerator() to generate samples around thie number #TODO


"""
function zscore(x, μ, σ)
  #  Σ = sum   #TODO (for the CDF )
    for i in  enumerate(x)
    
    return (x - μ / σ) 
    end

    #assumes variance DOES NOT CHANGE 
    function pdf(smooth(exp,numerator=-1,denominator-2), mean = μ, variance=σ)

    return (1/variance*sqrt2π) * (numerator/denominator)*smoothexp(numerator=-1,denominator=2)

    end

  """
  TODO: do an integral approximation of choice
  """
    function cdf()


    end


end
