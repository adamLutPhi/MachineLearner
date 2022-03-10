"""
a Double if statement
"""

function midCriterion(a, b) #ok 
    m = sumInterval(a, b) # | b - a |   definition
    condition = isEven(m) #even (divisible by 2)
    check = nothing
    if condition == true if iseven #ERROR double if!  #<----------------
        check = condition
    elseif condition == false
        check = condition
    else #if faulty input or Unexpected ERROR Occured 
        check
    end
    return check #whether check is true, false, nothing
end


function midCriterion(a, b) #ok 
    m = sumInterval(a, b) # | b - a |   definition
    condition = isEven2(m) #even (divisible by 2)
    check = nothing
    if condition == true #ERROR double if!  #<----------------
        check = condition
    elseif condition == false
        check = condition
    else #if faulty input or Unexpected ERROR Occured 
        check
    end
    return check #whether check is true, false, nothing
end

