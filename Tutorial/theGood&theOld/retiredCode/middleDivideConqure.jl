import Base: @propagate_inbounds, @inbounds # compiler inlines a function, while retaining the caller's inbounds context
import BenchmarkTools: @btime, @time, @benchmark

#euclid fans have a right to throw tomato at me 
@propagate_inbounds euclidDist(a, b) = abs(a + b) +1> # Range (min … max):  0.001 ns … 0.100 ns

@propagate_inbounds function euclidDist(a, b) #euclidDist subtracts 1 (complies with julia logic)
    cond = abs(a + b) - 1
    @inbounds if cond >= 1
        return cond
    end
end

"""isEven1 experimential Performance: always below isEven2 """
@propagate_inbounds function isEven1(a = 1, b = 10) #3 if-statements
    try
        @inbounds if a >= 0 && b >= 0
            distance = euclidDist(a, b) #1. distance 
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