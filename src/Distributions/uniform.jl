module uniform <: genericModel
    
"""
```Inputs
Range: assumes Probability Density function is defined, & Continuous on range

```
"""
function pdf(x, range)
    return pdf(x, range)

function cdf(x, range) #TODO: approx Integral of pdf(x)
return sum!(pdf(x,range)) #sum of all points #assumes all po
end