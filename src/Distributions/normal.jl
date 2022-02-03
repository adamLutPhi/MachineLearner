#include("./functions")
#include("~/functions")
#if Sys. 
include("../functions/SmoothFunctions/smoothFunction.jl")
module normal


export sqrt2π, pdf, cdf

#const π = pi
const sqrt2π = sqrt(2 * pi)

"""
Rule: minimal use of external Modules 
-More use to Applied ...
TODO: Apply Integration on the pdf ( to get the CDF)
TODO: do a generalized smooth function, taking numeraor,denominator
""" 


"""
<<<<<<< HEAD
zscore function
=======
zscore 

the Expectation (E) #Idea: most likely function generator 
use a randomGenerator() to generate samples around thie number #TODO

>>>>>>> e1e8635157374d87126d9d13be15a2679bccb5f0
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


    function cdf()


    end


end
