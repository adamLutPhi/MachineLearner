
function isEven1(a = 1, b = 10)
    try 
        if a >= 0 && b >= 0    
            distance = euclidDist(a, b) #1. distance 
            _isPositive =  isPositive(distance) #2. positive distance 
            if _isPositive #positive? 
            isEven = distance % 2 == 0 ? true : false 
            if isEven           # even? 
                return true 
            elseif !isEven # || isPositive
                return false
            else println(UnexpMsg)
            end 
        else throw(error("Positive number error")) 
        end 
        #end 
        end 
    catch positiveError
        #Exception 
       @error "ERROR: "* positiveMsg exception=(positiveError, catch_backtrace())   
       println(positiveMsg) #positive arguments error 
    end 
end
#=error handling  https://discourse.julialang.org/t/how-to-find-the-error-line-using-try-catch-statements/65511/2 
credits: @skoffer =#
#=1. either:
1.  you rethrow error, OR 
2. you can use `catch_backtrace()` with any of logger macros 

me: playing frisbe with try catch using catch_backtrace: as easy as 1,2,3  =#
try
    condition = true  #1.check condition 
    if condition # if it works, proceed 
    else throw(error("Positive number error")) # 2. throw(error(ExceptionError)) 
    end

catch positiveError # 3. catch (positiveError object )
    @error "ERROR: "* positiveMsg  exception=(positiveError, catch_backtrace())   # define Exception here, passing arguments 1. positiveError object, 2. call catch_backtrace() (to catch it) 
end

#end  
isEven1(-1,10)
isEven1(1,-10)
isEven1(-1,-10) 
