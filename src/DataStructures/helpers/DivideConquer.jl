"""
Divide & Conquer (Bisection method )

-has Bisection method 
1. normal way
2.Recursion [most used] [] <---

functions:
Context: divide & Conquer:
1. search() [the Easiest]
2. Right()  
3. Left()
     
A recursive Algorithm
1       n/2         n
|        |          |

1/ look at  n/2 index 

Compare left & compare right (do that in sequence)


if a[n/2] < a[n/2 ] ; n/2 middle index (Index)

"""
function search(arr, i = 1, val) #1
    val = findfirst(arr, i) #init val
    if val < arr[i] #terminal condition 
        return
        for i in enumerate(length(arr))  #range(1, len(arr)):
            #check modulo is length of array is divisible by 2 
            first = findfirst(arr)
            #TODO: Continue ...  <--- here 
            if arr[i-1] < val && val <= arr[i]    #  |      | 
                return i
            end

            # else if arr[i] > val && arr[i+1] >val 
        end
        #end #close if 


    end #close for 

    #else 
end
#end

#TODO: Bisection method #TODO: Revision #Sanity-check
#=
function searchRecursive(arr,i) #only ifs allowed 
    if val < arr[i] #fallback condition 
        return
    if arr[i] == val #special case(unicorn)

        #left side 
    elseif arr[i-1] < val &&  arr[i] >= val   #val <= arr[i]  |      | 
        bisect_left(a, x, low = 0, high = None) #3
    end
        #right side () 
    elseif arr[i-1] > val &&  arr[i] val <
        #TODO fill it 
        bisect_right(a, x, low=0, high=None) #2
    end
=#
#=
function  bisect_right(a, x, low=0, high=None) #2
    if hi isa nothing # Searching to the end
        hi = length(a) # get length 

    while low < high # More than one possibility
        mid = (low+high)//2 # Bisect (find midpoint)
    if x < a[mid] high = mid # Value < middle? Go left
        else low = mid+1 # Otherwise: go right
        return low
    end 

#left side 
function bisect_left(a, x, low = 0, high = None) #3
    if hi isa nothing # Searching to the end
        hi = length(a) # get length 

    while low > high
        # check n 
        mid = (low+high)//2
        return high 
    end 
end 
=#

"""iseven 
    Returns whether a number isEven or not 
```input:
m: a number 

```
output:
checkBool value or nothing
```
"""
function iseven(m) # \nerleg #͍
     ƞ = 0; ƞ = m
    check=nothing; condition = ƞ % 2; 
    if condition == 0 
        check = true
    elseif Condition != 0 
        check = false 
    else# faulty input, or Unexpected error happened 
        return check
    end 
    return check 
end 

iseven(2);iseven(0);iseven(6)
iseven(3)
"""Testing Area here 
        |   ----    |   ----    |
        left        mid         right 
1)if value[left] < value[mid] #expected - do none 
2)if value[left] > value[mid] #Action : swap (function call on recursion)
3)id value[left] == value[mid] #return 

1) if value[right] < value[mid] #expected - do none 
2) if value[right] > value[mid]
3) if value[right] == value[mid] #retrun 

Infer: generalize: Mid stays the same - whether left or right 
1) if value[i]< value[mid] # call left 
2) if value[i] > value[mid] # call right 
3) if value[i] == value[mid] # return  
------
only way is recursion for floats: 
beats mit 6.001 (freshmen can't do recursion) & 6.006 lecture 
|  -------       |        ------          |
l                m                        r 
if (first(arr) - last(arr) )

function goleft(arr, i)
end 

function goright(arr, i)

end 
"""
"""
gets the Eucldian distance between 2 numbers
"""
euclideanDist(a::Int64,b::Int64) =  (abs(max(a, b)) - abs(min(a, b))) # was (max(a, b) - abs(min(a, b))) #Unsymmetric 
function isMod(a::Int64, b::Int64)
    dif = dist(a, b)  #% 2 == 0 #? fl = true : fl = false;
    res = nothing 
    if dif % 2 == 0  #rem(dif, 2) == 0
        res = true
    elseif dif % 2 != 0
        res = false
    else # sth else happened during evaluation of rem
        return res
    end
    return res 
end
isMod(1, 3)


function dist(a::Int64, b::Int64)
    return euclideanDist(a,b)
end
#solve problem in the Abstract Domain 
function ϟ(a,b) #\upkoppa
    return a + b
end
#=
function iseven(a,b)
    res = nothing   
    dis = ϟ(a,b) #is a+b or a-b (Euclids distance)  correct? 
    if dis % 2 == 0  #rem(dif, 2) == 0
        res = true
    elseif dif % 2 !=0 
        res = false
    else 
        return res 
    end
    return res   
end
=#
using BenchmarkTools
@benchmark euclideanDist(10^2,10^3)
#=
function middle(a,b)
    mid = nothing
    #check divisible i.e iseven s  
    isIteven = iseven(a,b) # 3 Logic possibilities{nothing, true, false}
    if isIteven == true # has a middle 
         #Bah, Oui 
        euclideanDist(a,b)
        elseif isIteven == false #don't have a 'proper' middle  
        # Mais, Non 
    
    else #errorneous input to deal with (c koi ca?) 
        return mid  #pas du tout -> gently break
    end #end if 
    return mid  #whether True or false, return 
end
=#

#Relationship between 2 consecutive Rationals is 1 99% a.s. 
"""BisectSort
```input:

```

```output:
```
"""
function BisectSort(a::Int64, b::Int64)

end 
    #=

#special case 
if arr[m]  == idx return m; # isa try 
else 
#go right 
if arr[m] < idx return dichotomy (array, m+1, right)
else 
#go left
return Dichotomy ( array , l eft ,m-1 ) ;

  
look at middle n/2 

=#

#--- testing Area 
"""returns a boolean
```input:

```

```output:

```
"""
function checkCriterion(ch,:operator=[%,+,-,*],operand)
    check = nothing; check = ch
    condition = nothing; condition = :check :operator :operand  
    if condition == true
    return true #a.s. 
    elseif condition == false
        return false #a.s. 
    else # faulty Input or Unexpected Error Occured
        return check
    end
    return check
end
checkCriterion(3,%,2)
#=
function iseven(m)
    check = nothing;
    check = m
    if m %2 == 0
        check = true
    else if m % 2 != 0
        check == false
    else #faulty input, or Unexpected ERROR Occured 
        return check 
    end
    return check  #check has a valid value: either true or false 
end
=#
#=
function middleCriterion(a,b)
    #check#1
    m = 0 
    check = nothing; check = nothing ;check = euclideanDist(a,b)  # |b - a| # positive a.s.
    if iseven check 
=#
#check #2:middle
"""middleCriterion
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

function midCriterion(a,b)
    m = 0
    m = euclideanDist(a,b) # | b - a | 
    condition = nothing; condition = iseven(m)
    check = nothing;
    if condition == true
        check = true  
    elseif condition == false
        check = false
    else #if faulty input or Unexpected ERROR Occured 
        check
    end
    return check #whether check is true, false, nothing
end 
#done!

#2.2. middle Computation 
function middle(a,b)
    criterion = midCriterion(a,b) 
   # check = nothing;check = midCriterion(m) #b-a
    check,above,below = nothing ; check ; condition = criterion; #   b-a 
    if condition == true
        #return true #a.s. 
        check = euclideanDist(a, b) // 2 * 1.0 # | b - a | 
    elseif condition == false
        #return false #a.s. 
        # check = euclideanDist(a,b)//2*1.0
        #GET CIEL & FLOOD 
        check = euclideanDist(a, b) // 2 * 1.0
        above = ceil(check) #nearest index abouve
        below = floor(check)
    else # faulty Input or Unexpected Error Occured
        return check  # nothing
    end
     return check, condition, above, below
end 
#

"""

returns mid Criterion 

```input
    m: middle part given by formula `m = b - a`
    checks 
```

```output check:: Bool
  returns a Bool check given by `check= midCriterion(m)`
```
"""
function middle(m)
    criterion = nothing
    check = nothing;check = midCriterion(m) #b-a
    check = nothing ; check = midCriterion(m)
    if check == true
        return true #a.s. 
    else if check == false
        return false #a.s. 
    else # faulty Input or Unexpected Error Occured
      return check
    end
    return check 
end 
