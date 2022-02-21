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

function search(arr,i=1,val) #1
    val = findfirst(arr,i) #init val
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
function searchRecursive(arr,i) #only ifs allowed 
    if val < arr[i] #fallback condition 
        return
    
        #left side 
    if arr[i-1] < val &&  arr[i] >= val   #val <= arr[i]  |      | 
        bisect_left(a, x, low = 0, high = None) #3
    end
        #right side 
    elseif arr[i-1] > val &&  arr[i] val <
        #TODO fill it 
        bisect_right(a, x, low=0, high=None) #2
    end
    
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

#=
  
look at middle n/2 

=#