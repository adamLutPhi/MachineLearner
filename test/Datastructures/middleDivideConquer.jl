
function isEven1(a = 1, b = 10)
    try
        if a >= 0 && b >= 0
            distance = euclidDist(a, b) #1. distance 
            _isPositive = isPositive(distance) #2. positive distance 
            if _isPositive #positive? 
                isEven = distance % 2 == 0 ? true : false
                if isEven           # even? 
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
    catch positiveError
        #Exception 
        @error "ERROR: " * positiveMsg exception = (positiveError, catch_backtrace())
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
    else
        throw(error("Positive number error")) # 2. throw(error(ExceptionError)) 
    end

catch positiveError # 3. catch (positiveError object )
    @error "ERROR: " * positiveMsg exception = (positiveError, catch_backtrace())   # define Exception here, passing arguments 1. positiveError object, 2. call catch_backtrace() (to catch it) 
end

#end  
isEven1(-1, 10)
isEven1(1, -10)
isEven1(-1, -10)
@benchmark isEven1()

#--- isEven2

@propagate_inbounds function isEven2(a = 1, b = 10) # = readable #preferred #fast  #optimized  #2 if-statements
    try
        @inbounds if a >= 0 && b >= 0   #==#
            distance = euclidDist(a, b) #1.distance 
            evenCond = distance % 2 == 0 ? true : false
            _isPositive = isPositive(distance)
            @inbounds if evenCond && _isPositive #ok 
                return true
            elseif !evenCond || !_isPositive
                return false
            end
        else
            throw(error("Positive number error"))
        end
    catch positiveError
        #Exception 
        @error "ERROR: " * positiveMsg exception = (positiveError, catch_backtrace())
        println(positiveMsg) #positive arguments error 
    end #==#
end

isEven1(-1, 10)
isEven1(1, -10)
isEven1(-1, -10)

@benchmark isEven2

@propagate_inbounds function isEven2(m) # = readable #preferred #fast  #optimized  #2 if-statements
    try
        @inbounds if m >= 0  # && b >= 0   #==#
            distance = euclidDist(m) #1.distance 
            evenCond = distance % 2 == 0 ? true : false
            _isPositive = isPositive(distance)
            @inbounds if evenCond && _isPositive #ok 
                return true
            elseif !evenCond || !_isPositive
                return false
            end
        else
            throw(error("Positive number error"))
        end
    catch positiveError
        #Exception 
        @error "ERROR: " * positiveMsg exception = (positiveError, catch_backtrace())
        println(positiveMsg) #positive arguments error 
    end #==#
end


@propagate_inbounds function replaceVecs(v = [2, 3], a = [1, 2, 3, 4]; i = 1)
    lenV = length(v)
    @inbounds if lenV < length(a) # first assumption 
        @inbounds a[i:lenV] = v[i:lenV]

    else
        println(UnexpMsg)
    end
    return a
end

replaceVecs()


#-----------------
res = doCompare()
typeof(res)
@propagate_inbounds function buildRangeAroundPoint(a, mid, b) #checked  # the point of buildingRanges is the one I'm concerned about 
    if a >= 0 && mid >= 0 && b >= 0
        q = []
        @inbounds push!(q, makeRange(a, mid))
        @inbounds push!(q, makeRange(mid + 1, b))

        return q
    else
        println(positiveMsg)
    end
end
v = collect((2, 2))
rr = [1, 2, 3, 4]
res = replaceVecs(v, rr) #done 

reduce(vcat,map(exp, reduce(hcat, transpose(res))))

v = [2, 2]
a = [1, 2, 3, 4]

#-------





#-----------------


permutedims(reduce(hcat, (collect(1:3) for i = 1:2)))#only hcat 
reduce(vcat, transpose([collect(1:3) for i = 1:2])) # vcat, with transpose #ok 
permutedims(reduce(vcat, transpose([collect(1:3) for i = 1:2])))
reduce(vcat, transpose([collect(1:3) for i = 1:2]))#ERROR: no vcat  # done [;,;,1] #above line-transpose
stack(collect(1:3) for i = 1:2; dims = 1) #not for julia 1.8 




#--------

#--------
#---test --- 
mid = 2.5
above = Int(ceil(mid))
below = Int(floor(mid))

#@propagate_inbounds 
function middle(st, ed)
    q = []
    cond = isEven(st, ed)
    @inbounds if cond
        #return mid , mid+1
        mid = Int(ϟ(st, ed) // 2)
        # return mid, mid + 1
        push!(q, mid)
        push!(q, mid + 1)
        #@inbounds
    elseif !cond #mid = 2.5 #inapplicable for an index 
        mid = ϟ(st, ed) / 2 # floating-point division euclideanDist(a, b) / 2 * 1.0 # freely allowing floats, to be ceiled & floored 
        # above = Int(ceil(check)) #nearest index above
        #  below = Int(floor(check))
        above = Int(ceil(mid))
        below = Int(floor(mid))
        push!(q, below)
        push!(q, above)
        # return q  #return below, above
        # @inbounds
    else
        println(UnexpMsg)
    end
    return q
end

_midV = middle(1, 10) # yes, mid = 5 return 5,6 