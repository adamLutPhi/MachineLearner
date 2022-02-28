#global ⫙ = []
#=


#another idea: pass in middle function, as a whole 
#function middleExtraction(middle,a,b) end
#---testing area 2 
=#
"""returns a boolean
```input:

```

```output:

```
"""#testing purposes only 
#= #Highly Experimental
function checkCriterion(ch, :operator = [%, +, -, *], operand)
    check = nothing
    check = ch
    condition = nothing
    condition = :check:operator:operand
    if condition == true
        return true #a.s. 
    elseif condition == false
        return false #a.s. 
    else # faulty Input or Unexpected Error Occured
        return check
    end
    return check
end
checkCriterion(3, %, 2)
 =#
#check #1 ϟ - \upkoppa 
function ϟ(a,b)
    return abs(a) + abs(b)
end 

 #check #2:middle
#
"""evenCriterion
```input
  a: the `first()` in a range 
  b:the `last()` in  a range 
```
```output
 Returns `check`: the 

 Output is Calculated by: `check b-a`

 `output = `
   If check is true 

  If check if false

  Else, there must be an error in either input arguments: a, b (or an Unexpected error occured) 
  Otherwise,  return the `check`

  **see also:** `iseven`

  ```
"""
#isEven Removed #Reason: unnecessary Overhead 
#define euclidDist here 
euclideanDist(a::Int64, b::Int64) = (abs(max(a, b)) - abs(min(a, b))) # was (max(a, b) - abs(min(a, b))) #Unsymmetric  
function evenCriterion(a, b) #ok #double-Checked 
    m = ϟ(a, b) # | b + a |   definition
    condition = m % 2 == 0 #isEven(m) #even (divisible by 2)
    check = nothing
    if condition == true  #ERROR double if! 
        check = condition
    elseif condition == false
        check = condition
    else #if faulty input or Unexpected ERROR Occured 
        check
    end
    return check #whether check is true, false, nothing
end
#done!

res = evenCriterion(1,3) #flase Infer no middle as a whole number 
#=
function midCriterion(euclidDistance)
    m = euclidDistance #NO ERROR  #euclideanDist(a, b) # | b - a | 
    condition = m % 2 == 0 # isEven(m)
    check = nothing
    if condition == true
        check = condition
    elseif condition == false
        check = condition
    else #if faulty input or Unexpected ERROR Occured 
        check
    end
    return check #whether check is true, false, nothing
end
=#
#--------------
# cyclical code dedected! :mid to even , or even to mid  #Possible
function middleExtraction(condition, checkedValue; above = nothing, below = nothing) #at least one argument is given, besides condition 
    ⫙ = []# reset is necessary detected 
    criterion = condition
    if criterion == true # there is only 1 value  
        # only get the checkedValue 
        ⫙ = push!(⫙, checkedValue)
    elseif criterion == false
      #then we have above & below to get (know for sure that below is under above) 
     ⫙ =    push!(⫙, above)
     ⫙ =   push!(⫙, below)
    else # faulty input or Unexpected error Occured
        return
    end
    return ⫙ #q
end
#---------------------------------------
function middleGet(condition)
    criterion = condition
    criterion ? ⫙ = (popat(checkedValue)) : ⫙ = popat(ceil); ⫙ = popat(below) #warning: unused  ⫙
    return ⫙
end 

function middleSet(condition)
    criterion = condition
    criterion ? push!(⫙, checkedValue) : push!(⫙, ceil); push!(⫙,below)
end
#----------------------------------------   
#middleExtraction()
check = Int(ϟ(a, b) // 2) # euclideanDist(a, b) // 2 #* 1.0 # | b - a | // 2 isa Integer #euclideanDist -to-> ϟ
 #⫙ = []

function push!(⫙, ceil = above, floor = below)#warning: ⫙, floor are Unused 
    push!(⫙, ceil)
    push!(⫙, below)
end 
""" pops ceil & floor """
function popDouble() 
    ceil = popat(⫙,ceil)
    floor = popat(⫙,below)
    return ceil, floor 
end
"""pushes ceil & floor """
function  pushDouble(⫙,ceil=above, floor=below)
    ceil = push!(⫙,ceil)
    floor = push!(⫙,below)
    
    return ceil, floor 
end
"""pushes checked """
function push(checked = checkedValue)
  push!(⫙, checked)
end 

function pop!()
    checked = pop!()
    return checked
end

#function pop!()
#--------------------------
#---known error here 
"""returns a middle(s)
```input:
a: lower bound range
b: upper bound range 
```

```output:
condition: Bool flag informing user if got a 1 mid-point, 2 mid-poimts, or errors occured
check: 1 midpoint middle  (if condition is true)
above,below: 2 mid-point middles (the realized leaf-bounds between the theoretical mid-point)
```
"""
function middle(a, b) # working 
    condition = evenCriterion(a, b) #   b-a 
    # check = nothing;check = midCriterion(m) #b-a
    checkedMiddle = nothing
    above = nothing
    below = nothing
    check = nothing 
    if condition == true
        #return true #a.s. #eucledian Distance divided by 2 returing a whole integer
        check = Int(ϟ(a, b) // 2) # euclideanDist(a, b) // 2 #* 1.0 # | b - a | // 2 isa Integer #euclideanDist -to-> ϟ#5
        #middleExtraction(condition, check) # Here we didn't get anything ! <------------- # check not defined here 
        #return condition, check 
    elseif condition == false
        #return false #a.s.# check = euclideanDist(a,b)//2*1.0
        #GET Ceil & Floor
        check = ϟ(a, b) / 2 # floating-point division euclideanDist(a, b) / 2 * 1.0 # freely allowing floats, to be ceiled & floored 
        above = Int(ceil(check)) #nearest index above
        below = Int(floor(check))
    else # faulty Input or Unexpected Error Occured
        #    return check  # nothing
        return condition, check, above, below
    end
    return condition, check, above, below
end 
condition = nothing;check=nothing;
condition, check, above, below = middle(1,3)



#correct till this point 

#=
if condition == true # 1 midpoint 
    #oldschoolComp()
    return #check 
    #build range 
if condition == false # 2 midpouts #done 
    #above & below # compare them here 
    below,above =  oldschoolComp(below,above)
    return below,above #<--- pplace here: #compare
     #end 
end 
=#
#comp(arr,a,b) = arr_a =  arr[a]; arr[b]  = arr_b; arr_a>arr_b ? oldschoolSwap(arr[a],arr[b])
function comp(arr,a,b)
     arr_a =  arr[a]; arr[b]  = arr_b; 
    if  arr_a > arr_b
       arr_a, arr_b = oldschoolSwap(arr[a],arr[b])
    end
    return arr_a, arr_b 
end 

#--------Demonstration
#=
middle(1, 4) #false # (false, 2.5, 3, 2) 
middle(1, 3) #true  # 
euclideanDist(1, 3) # (true, 2//1, nothing, nothing)
=#
#need functional notation so that output of middle(a,b) | middleExtraction argiments 


#---testing of testing 
middle(1,3)

    """
    Assumes right most argument should be the lowest 
    Thus, if it has a higher value, swap it (with the other one)
    ```input:
    a: Int(64,128) or float(64, or 128)
    b: Int(64,128) or float(64, or 128)
    ```
    
    ```output:
    returns an ordered pair of a & b 
    (comparison might be needed only if a is larger)
    ```
    """
function oldschoolComp(a, b)
    if a > b
        a , b = oldschoolswap(a, b)
        return a,b
    elseif a < b
        # move on
        return a , b
    else
        return 0 , 0 
    end
    return a ,  b
end
"""
compares an arbitrary array 
based on it's first & last elements 
"""
#=
function compare(arr) #errornous #warning becareful from its values
    aVal = first(arr) # arr[aIdx] # 5 v[1]= 5
    bVal = last(arr) #arr[bIdx] # v[last] = 1  5>1
    aIdx = firstindex(arr)
    bIdx = lastindex(arr) # bVal)
     
    #1. Heuristic#1: Check euclideanDist 

    total = ϟ(aIdx,bIdx)
    dist = euclideanDist(aIdx,bIdx)
    midpoint 
    
    if dist == 1 #1,2 ; 2,3 ; 3,4 
       #final compare of values 
      aVal,bVal =  oldschoolComp(aVal,bVal)#compare & swap, if applicable

    elseif dist > 1
        isEven = evenCriterion(aIdx, bIdx)
        if isEven == true #even #only 1-midpoint 
            midpoint = pushfirst!(midpoint, Int(total // 2))
        elseif isEven == false # 2 midpoints 
        #middle()

        end
        #if aVal < bVal
        if total > 1 # there are still unforseen ranges 
            #if euclidDistance(aIdx,bIdx) > 1 #reason to stay  #\upkoppa ?
            #if aVal > bVal compare function                               # a > b #should be a < b 
            #1. Swap values        
            aVal, bVal = comp(arr, aIdx, bIdx)  # oldschoolSwap(aVal, bVal) #correct #x, y) # (bVal, aVal) #ERROR T not defined 
            #2. Swap  array indicies(with correct orders)
            #arr[aIdx], arr[bIdx] = oldschoolSwap(arr[aIdx], arr[bIdx])
            #3.decrement  - middle
            # middleExtraction() #error! #UncommentMe
            #elseif aVal < bVal # at that level (diff length) of indicies # the array is correct  

            return aVal, bVal

        else #faulty input , Unexpected code  
            println(strError)
            return
        end
        return aVal, bVal # , arr  #min, max #removed values 
    end
end 
=#