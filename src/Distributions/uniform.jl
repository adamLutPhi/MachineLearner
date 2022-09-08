include("genericDistribution.jl")
module uniform
<:genericDistribution #genericModel

    """
    ```Inputs
    Range: assumes Probability Density function is defined, & Continuous on range

    ```
    """
#TODO: Calculate the uniform pdf
    function pdf(x, range)
        return pdf(x, range)
    end
#TODO: check sum equals approx. to the cdf 
    function cdf(x, range) #TODO: approx Integral of pdf(x)
        return sum(pdf(x, range)) #sum of all points #assumes all po
    end

end 
