import Base: @propagate_inbounds, @inbounds # compiler inlines a function, while retaining the caller's inbounds context
import BenchmarkTools: @btime, @time, @benchmark

#euclid fans have a right to throw tomato at me 
@propagate_inbounds sumInterval(a, b) = abs(a + b) +1> # Range (min … max):  0.001 ns … 0.100 ns

@propagate_inbounds function sumInterval(a, b) #sumInterval subtracts 1 (complies with julia logic)
    cond = abs(a + b) - 1
    @inbounds if cond >= 1
        return cond
    end
end

"""isEven1 experimential Performance: always below isEven2 """
@propagate_inbounds function isEven1(a = 1, b = 10) #3 if-statements
    try
        @inbounds if a >= 0 && b >= 0
            distance = sumInterval(a, b) #1. distance 
            _isPositive = isPositive(distance) #2. positive distance 
            @inbounds if _isPositive #positive? 
                isEven = distance % 2 == 0 ? true : false
                @inbounds if isEven           # even? 
                    return true
                elseif !isEven # || isPositive
                    return false
                else
                    println(UnexpMsg)
                end
            else
                throw(error("Positive number error"))
            end
            #end 
        end
    catch notPositiveInputError
        #Exception 
        @error positiveMsg exception = (notPositiveInputError, catch_backtrace())
        println(positiveMsg) #positive arguments error 
    end
end
isEven1(-1, 10)
isEven1(1, 10)

#=
@inbounds if lenV < lenA # first assumption 
    @inbounds a[i:lenV] = v[i:lenV]
    #elseif lenV > lenA #v can't be larger than original vector a (throws an outofBoundsError )
else
    throw(error("Positive number error"))
    println(UnexpMsg)
end
#return a
#end =#
 #computeRange!(a, α, β) # # TODO: middle(arr, a, b) #or # TODO: middle(a, b, arr) 
@propagate_inbounds function replaceVector2(v = [1, 2], a = [2, 3, 4, 5]; i = 1)


"""divideConquer """

#  mit 6.006  #unused #orphaned #to-be-deleted
#choosing a,b is choosing arr , this is a mean, not a goal 
# divideConquer(a, range[1], length(range[1])) #check 
@propagate_inbounds function divideConquer(a = [1, 2, 3, 4]; α = arr[1], β = length(a) - 1)  ## arr is an initial value, while the goal would be , 1  length(other size of bound to walk on  ) a code that never walks..
    count = 1
    mid = middle(α, β) # first Domino #this presumes middle returns 1 middle # immature 
    #check valid Interval  
    cond = sumInterval(mid, count) > 0 ? true : false #= mid - count >= 0=#

    q = []

    if cond
        count += 1
        if a[mid] < a[mid-1] # only look at left half 1 . . . n/2 − − − 1 to look for peak
            pushfirst!(q, goleft(arr, a, mid))

        elseif a[mid] < a[mid+1] # only look at right half n/2 + 1 . . . n to look for peak
            pushfirst!(q, goright(a))

        else # a[mid] =?= a[mid+1]
            pushfirst!(q, mid) # the peak!
        end
    end
end
#no errors 

#-----------
#---------------

cond = isEven(1, 3)
res = -1

#---test run tryout

#1,3 total range 
# 1+3/2 = 2 
#yeilds 1:2 , 2:3 
#check dist 

abs(2 - 3) == 1 # bounds are apart by 1 #sweet!

# final comparison 
#doCompare(2,3,arr)
#compare current ranges with their value , do comparison when required  
a[1]



#=Plain comparison - flip if lower index has a higher value, otherwise return
given bound values of indicies, find their corresponding value that they weigh, 
then compare them together, as well 

```input:
st: start bound 
ed: ending bound 
a: corresponding vector array to traverse
```

```output:
```

=#
compareVector

#=
"""a valid middle - Classic #old #depreciated ,why it uses q """
function middle(α, β) # 
    condition = isEven(α, β) #  not | b-a 
    #q = []
    if condition == true
        #return true #a.s. #eucledian Distance divided by 2 returing a whole integer
        check = Int(sumInterval(α, β) // 2) # | b + a | // 2 isa Integer #sumInterval -to-> ϟ#5
        #middleExtraction(condition, check) # Here we didn't get anything ! <------------- # check not defined here 
        #return condition, check 
        #push!(q, check)
    elseif !condition # == false
        #return false #a.s.# check = sumInterval(a,b)//2*1.0
        #GET Ceil & Floor
       
        #call middle 
        #sumInterval(α,β)/2
        #does other things as well : # warning  #old-thinking 
        check = sumInterval(α , β)/2 # floating-point division sumInterval(a, b) / 2 * 1.0 # freely allowing floats, to be ceiled & floored 
        if isEven2(check)
            above = Int(ceil(check)) #nearest index above
            below = Int(floor(check))

      #  push!(q, below)#old thinking detected # to be changed 
       # push!(q, above)

    else # faulty Input or Unexpected Error Occured
        #    return check  # nothing
        return #q #condition, check, above, below
    end
    return #q #condition, check, above, below
end
resultvector = middle(1,2)
#check length
length(resultvector) > 1 #there's atleast 1 middle 

isEven2(length(resultvector )) #divisible /2 
=#

