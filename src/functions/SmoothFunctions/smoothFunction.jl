
export smooth, iscontinuous, isdifferentiable

module smoothFunction

#--- Real Functions
function iscontinuous()

end


function isdifferentiable()

end


function smooth(x)
    """
    A smooth function basis function, that is:
        1.continuous
        2.differentiablle
    """
    return exp(x)

end

#--- complex functions

function analytic(x)

end
end
