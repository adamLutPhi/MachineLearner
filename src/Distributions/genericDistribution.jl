
#abstract type

module genericDistribution
#default values
E(x)=0 #mean value #1st moment generating function 
σ(x)=1 #variance #2nd moment generating function

function getPdf(x=smoothFunction)
    """
    generalization of (any )
    """
   return pdf(x)= smoothFunction
end 

function pdf(x, range)
    return pdf(x, range)

function cdf(x, range) #TODO: approx Integral of pdf(x)
return sum!(pdf(x,range)) #sum of all points #assumes all points are reachable, and funcion is continuoous on all of them #no-Jumps model 

end  # module genericDistribution() genericDistribution()
