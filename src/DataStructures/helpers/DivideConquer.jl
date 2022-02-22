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
"""
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
euclideanDist(a::Int64,b::Int64) = (max(a, b) - abs(min(a, b)))
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

function ϟ(a,b)
    return a + b
end
function iseven(a,b)
    res = nothing  
    dis = ϟ(a,b) 
    if dis % 2 == 0  #rem(dif, 2) == 0
        res = true
    elseif dif % 2 !=0 
        res = false
    else 
        return res 
    end
    return res 
end
#Relationship between 2 consecutive Rationals is 1 99% a.s. 
function BisectSort(a::Int64, b::Int64)

end 
    #=

#special case 
if arr[m]  == idx return m; # isa try 
else 
#go right 
if arr[m] < idx return dichotomy (array, m+1, right)
e l s e 
#go left
return Dichotomy ( array , l eft ,m-1 ) ;

  
look at middle n/2 

=#