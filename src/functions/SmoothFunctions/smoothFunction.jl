
export smooth, iscontinuous, isdifferentiable

module smoothFunction

#--- Real Functions
function iscontinuous(x)
```
checks whether function x is continuous
```
return true #skip for now
end


function isdifferentiable(x)
```
Checks whether function x isDifferentiable
```
    return true # skip for now
end


function smooth(x)
    ```
    A smooth function basis function, that is:
        1.continuous
        2.differentiablle
    ```
    smooth = exp(x)
    if isdifferentiable(smooth) &&  iscontinuous(smooth)
    return smooth

end

#--- complex functions

function analytic(x)

end
end
