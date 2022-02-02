
export smooth, iscontinuous, isdifferentiable, isanalytic
module smoothFunction

#--- Real Functions
function iscontinuous(x)
    """
    checks whether function x is continuous
    """
return true #skip for now
end


function isdifferentiable(x)
    """
    Checks whether function x isDifferentiable
        TODO: pick a Suitable differentiation Module
        TODO: Call a differentiation Module
    """
    return true # skip for now
end


function smooth(x=exp(x))
    """
    A smooth function basis function, that is:
        1.continuous #TODO
        2.differentiablle #TODO 
    """
    smooth = exp(x)
    if isdifferentiable(smooth) &&  iscontinuous(smooth) #TODO: verification functions 
        return smooth
    end
end


function smooth(x = exp(x),numerator=a,denominator=b)
    """
    A smooth function basis function, that is:
        1.continuous
        2.differentiablle
    """
    smooth = exp(x)
    if isdifferentiable(smooth) && iscontinuous(smooth)
        return denominator!=0 ? (numerator/denominator)*smooth : NaN
    end
end


#--- complex functions #testing

function analytic()
    """

    TODO: needs further review
    analytic function to be used as input for a laplacian
    """
    isanalytic = nothing
    if  isanalytic 
        isanalytic = true 
        
    else 
        isanalytic = false 
    
    end
 return isanalytic
end

end