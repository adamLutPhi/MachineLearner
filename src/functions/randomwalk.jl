using Distributions


#--- Bernoulli

"""  
Returns a Bernoulli Probability Density Function (PDF) that is; 

1. Discrete process  
2. I.I.D

"""
function pdf(ntimes)

  return Bernoulli(ntimes)
end

function cdf(pdf,x)
    return sum(pdf(x)) #discrete sum 
end
#function #later