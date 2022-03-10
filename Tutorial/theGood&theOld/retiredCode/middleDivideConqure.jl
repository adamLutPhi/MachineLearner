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


@inbounds if lenV < lenA # first assumption 
    @inbounds a[i:lenV] = v[i:lenV]
    #elseif lenV > lenA #v can't be larger than original vector a (throws an outofBoundsError )
else
    throw(error("Positive number error"))
    println(UnexpMsg)
end
return a

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