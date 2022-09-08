
abstract type distribution end 

module genericDistribution <: distribution
#default values
E(x)=0 #mean value #1st moment generating function 
σ(x)=1 #variance #2nd moment generating function

function getPdf(x=smoothFunction)
    """
    generalization of (any )
    """
    #TODO: a smooth function is: (1) continuous , (2) differentiable [thus if it's not those, it would be rough]
   return pdf(x)= smoothFunction
end 


function pdf(x, range)
    return pdf(x, range)

function cdf(x, range) #TODO: approx Integral of pdf(x)
return sum(pdf(x,range)) #sum of all points #assumes all points are reachable, and funcion is continuoous on all of them #no-Jumps model 

end  # module genericDistribution() genericDistribution()
