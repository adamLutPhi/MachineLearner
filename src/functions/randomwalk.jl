using Distributions


#--- Bernoulli


function pdf(ntimes)
"""  
Returns a Bernoulli Probability Density Function (PDF) that is; 

1. Discrete process  
2. I.I.D

"""
  return Bernoulli(ntimes)
end

function cdf(pdf,x)
    return sum(pdf(x)) #discrete sum 
end
#function #later