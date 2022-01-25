
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
        TODO: pick a SUitable differentiation Module
        TODO: Call a differentiation Module
    """
    return true # skip for now
end


function smooth(x)
    """
    A smooth function basis function, that is:
        1.continuous
        2.differentiablle
    """
    smooth = exp(x)
    if isdifferentiable(smooth) &&  iscontinuous(smooth)
        return smooth
    end
end

#--- complex functions

function analytic(x)
    """

    TODO: needs further review, please!
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