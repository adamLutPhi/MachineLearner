
function isEven1(a = 1, b = 10)
    try
        if a >= 0 && b >= 0
            distance = sumInterval(a, b) #1. distance 
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
#=
isEven1(-1, 10)
isEven1(1, -10)
isEven1(-1, -10)
benchmark isEven1()=#

#--- isEven2

@propagate_inbounds function isEven2(a = 1, b = 10) # = readable #preferred #fast  #optimized  #2 if-statements
    try
        @inbounds if a >= 0 && b >= 0   #==#
            sumInt = sumInterval(a, b) #1.distance 
            evenCond = sumInt % 2 == 0 ? true : false
            _isPositive = isPositive(sumInt)
            @inbounds if evenCond && _isPositive  ? true : false  #ok
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

#=
isEven1(-1, 10)
isEven1(1, -10)
isEven1(-1, -10)=#

@benchmark isEven2(10^7)

@propagate_inbounds function isEven2(m) # = readable #preferred #fast  #optimized  #2 if-statements
    try
        @inbounds if m >= 0  # && b >= 0   #==#
            distance = sumInterval(m) #1.distance 
            evenCond = distance % 2 == 0 ? true : false
            _isPositive = isPositive(distance)
            @inbounds if evenCond && _isPositive #ok ? true : false 
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


@inline @propagate_inbounds function replaceVector(v = [2, 3], a = [1, 2, 3, 4]; i = 1)
    lenV = length(v)
    @inbounds if lenV < length(a) # first assumption 
        @inbounds a[i:lenV] = v[i:lenV]

    else
        println(UnexpMsg)
    end
    return a
end
#= 
BenchmarkTools.Trial: 10000 samples with 960 evaluations.
 Range (min … max):   86.979 ns …   4.819 μs  ┊ GC (min … max):  0.00% … 97.34%
 Time  (median):      95.729 ns               ┊ GC (median):     0.00%
 Time  (mean ± σ):   126.652 ns ± 201.347 ns  ┊ GC (mean ± σ):  10.76% ±  6.80%

  ▇██▅▄▄▄▄▄▃▃▃▃▃▂▂▂▂▂▂▁▂▁▁▁▁▁   ▁▁                              ▂
  ███████████████████████████████████████▇▇▇█▇▇▇▅▆▅▆▁▆▅▆▅▅▃▅▅▄▅ █
  87 ns         Histogram: log(frequency) by time        302 ns <

 Memory estimate: 256 bytes, allocs estimate: 3.



 =#

@inline function replaceVector2(v = [2, 3], a = [1, 2, 3, 4]; i = 1)
    lenV = length(v)
    @inbounds if lenV < length(a) # first assumption 
        @inbounds a[i:lenV] = v[i:lenV]

    else
        println(UnexpMsg)
    end
    return a
end

#=
BenchmarkTools.Trial: 10000 samples with 955 evaluations.
 Range (min … max):   87.016 ns …  13.450 μs  ┊ GC (min … max):  0.00% … 98.67%
 Time  (median):      95.183 ns               ┊ GC (median):     0.00%
 Time  (mean ± σ):   132.741 ns ± 239.163 ns  ┊ GC (mean ± σ):  11.10% ±  6.89%

  ▇█▅▄▃▃▄▃▃▃▃▂▂▂▂▂▂▂▁▁▁▁▁▂▁▁▁▁                                  ▂
  █████████████████████████████████▇▇▆▇▇▇▇▇▆▆▇▆▆▅▅▅▆▆▅▆▅▅▅▄▄▄▁▅ █
  87 ns         Histogram: log(frequency) by time        369 ns <

 Memory estimate: 256 bytes, allocs estimate: 3.


###################

 =#




 @noninline function replaceVector3(v = [2, 3], a = [1, 2, 3, 4]; i = 1)
    lenV = length(v)
    @inbounds if lenV < length(a) # first assumption 
        @inbounds a[i:lenV] = v[i:lenV]

    else
        println(UnexpMsg)
    end
    return a
end


 

@noinline @propagate_inbounds function replaceVector4(v = [2, 3], a = [1, 2, 3, 4]; i = 1)
    lenV = length(v)
    @inbounds if lenV < length(a) # first assumption 
        @inbounds a[i:lenV] = v[i:lenV]

    else
        println(UnexpMsg)
    end
    return a
end
#=
BenchmarkTools.Trial: 10000 samples with 960 evaluations.
 Range (min … max):   86.979 ns …   4.819 μs  ┊ GC (min … max):  0.00% … 97.34%
 Time  (median):      95.729 ns               ┊ GC (median):     0.00%
 Time  (mean ± σ):   126.652 ns ± 201.347 ns  ┊ GC (mean ± σ):  10.76% ±  6.80%

  ▇██▅▄▄▄▄▄▃▃▃▃▃▂▂▂▂▂▂▁▂▁▁▁▁▁   ▁▁                              ▂
  ███████████████████████████████████████▇▇▇█▇▇▇▅▆▅▆▁▆▅▆▅▅▃▅▅▄▅ █
  87 ns         Histogram: log(frequency) by time        302 ns <

 Memory estimate: 256 bytes, allocs estimate: 3.
=#

#inline functions 
@benchmark replaceVector  #noinline better 
#=
BenchmarkTools.Trial: 10000 samples with 1000 evaluations.
 Range (min … max):  0.001 ns … 0.100 ns  ┊ GC (min … max): 0.00% … 0.00%
 Time  (median):     0.001 ns             ┊ GC (median):    0.00%
 Time  (mean ± σ):   0.035 ns ± 0.047 ns  ┊ GC (mean ± σ):  0.00% ± 0.00%

  █                                                       ▁
  █▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁█ ▂
  0.001 ns       Histogram: frequency by time        0.1 ns <

 Memory estimate: 0 bytes, allocs estimate: 0.

@benchmark replaceVector2

#no inline 
@benchmark replaceVector3
@benchmark replaceVector4

#-----------------
res = compareVector() #<------          Attention!
α = 1;
β = 2;
arr = [2, 1, 3, 4]
buildRangeAroundPoint(α
, mid, β)
println(res)
typeof(res)

#-----------------
@propagate_inbounds function buildRangeAroundPoint(a, mid, b) #checked  # the point of buildingRanges is the one I'm concerned about 
    if a >= 0 && mid >= 0 && b >= 0
        q = []
        @inbounds push!(q, buildInterval(a, mid))
        @inbounds push!(q, buildInterval(mid + 1, b))

        return q
    else
        println(positiveMsg)
    end
end
v = collect((2, 2))
rr = [1, 2, 3, 4]
res = replaceVector(v, rr) #done 

#--later 
@propagate_inbounds reduce(vcat, map(exp, reduce(hcat, transpose(res))))  #try maping data (vector) to a function of choice (exp)

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
    try
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
            mid = ϟ(st, ed) / 2 # floating-point division sumInterval(a, b) / 2 * 1.0 # freely allowing floats, to be ceiled & floored 
            # above = Int(ceil(check)) #nearest index above
            #  below = Int(floor(check))
            above = Int(ceil(mid))
            below = Int(floor(mid))
            push!(q, below)
            push!(q, above)
            # return q  #return below, above
            # @inbounds
        else #throws erro  
            throw(error(UnexpObj)) #generate error Object UnexpObj 

        end # placecatch here @error $stringMsg exception = (ErrorObject, catch_backtrace())
    catch UnexpMsg
        exception = (UnexpObj, catch_backtrace)
    end   # or if anything is smooth, return as below   
    return q
end# final end 
#catch  the UnexpObj - on the catch_backtrace
#end 
#=

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
        mid = ϟ(st, ed) / 2 # floating-point division sumInterval(a, b) / 2 * 1.0 # freely allowing floats, to be ceiled & floored 
        # above = Int(ceil(check)) #nearest index above
        #  below = Int(floor(check))
        above = Int(ceil(mid))
        below = Int(floor(mid))
        push!(q, below)
        push!(q, above)
        # return q  #return below, above
        # @inbounds
    else #throws erro  #generate error Object UnexpObj 
        throw(error(UnexpObj)) 

    end
    return q
end# final end - placecatch here @error $stringMsg exception = (ErrorObject, catch_backtrace())
catch 
@error UnexpMsg exception =(UnexpObj, catch_backtrace()) 
println(positiveMsg) #positive arguments error 
end 
=#
_midV = middle(1, 10) # yes, mid = 5 return 5,6 

#--- we are here [current bottleNeck ]
#requires buildInterval 
#uses triad if-elseif-else  
#TODO:solution 

#Don't run this codeblock!
#=
@propagate_inbounds function doCompare(st = 1, ed = 2, a = [2, 1, 3, 4]) #errrorneous # a bit absurd (don't you think?) #no everthing is fine # it's your nagging mind that is 
    try
        _first = copy(a[st])
        _last = copy(a[ed])  #creates a shallow copy (what's desired for optimization)
        @inbounds if a[st] > a[ed] #valueAt(2) > valueAt(1) isa true  #_first > _last #
            @inbounds a[st], a[ed] = a[ed], a[st]        #an inbounds swap #actual array swap 
        elseif _first < _last # <--------- necessary step, to jump later into errorchecking else 
        else #can throw error - here 
            throw()
            println(UnexpMsg)
        end
        v = buildInterval(_first, _last)  #collect((_first, _last))
        return v # ERROR: BoundsError: attempt to access 2-element Vector{Int64} at index [10]
    catch

    end


end 
doCompare(1, 2)=#
#---------Start from here 
#issue reconstruction
a = [2, 1, 3, 4]
st = 1;
ed = 2; # todo move st ed until end of arr 

#1. check comparison  #check
#2. check _first & _last   - a copy only copies the value of content (lightweight) - Desired  #check

_first = copy(a[st])
_last = copy(a[ed])

#works fine  -fair enough # add only this condition - which we're intereste to evaluate 

@inbounds if _first > _last #valueAt(2) > valueAt(1) isa true  #_first > _last #
    #Base.@propagate_inbounds# directly change contents of the Original Array   
    @inbounds a[st], a[ed] = a[ed], a[st]        #an inbounds swap #actual array swap 
end
#elseif  _first < _last #this line should be omitted at all costs 

#skip line
#do nothing 
#end 

#no issues here 
a #array #correct!


#---not here: apply try -catch playing safe 
#should work fine, as well 

try
    _first = copy(a[st])
    _last = copy(a[ed])

    #works fine  -fair enough - goal: walk me through code until we reach the catch part 

    @inbounds if _first > _last #valueAt(2) > valueAt(1) isa true  #_first > _last #
        #Base.@propagate_inbounds# directly change contents of the Original Array   
        println(a[st], a[ed])
        return @inbounds a[st], a[ed] = a[ed], a[st]        #an inbounds swap #actual array swap 
    #end
    elseif _first < _last #possible - correct situation (to deal with)
        #Intent: skip 
        return  # this  makes things work ! 
    else #2. throw frisbe error here
        throw(error("Unexpected Error")) # 2. throw(error(ExceptionError)) 
    end

catch UnexpectedError # 3. catch (UnexpectedError object )
    @error "ERROR: " * positiveMsg exception = (UnexpectedError, catch_backtrace())   # define Exception here, passing arguments 1. positiveError object, 2. call catch_backtrace() (to catch it) 
end #ends try - finally afterthat return whatever correct value you've been working on  (if not already ) 




@propagate_inbounds function indexOf(i, v::Vector)
    try
        res = findfirst(isequal(i), v)
        typeof(res) == Nothing ? res = -1 : return Int(res) #res[1] #
    catch
        return -1
    end

end

res = findfirst(isequal(i), v)
typeof(res) == Nothing ? res = -1 : return Int(res)
#=compares vector a, it's element at first index α with second element at index β 

```input:
α: first index of comparison
β: second index of comparison 
a: original vector array
```

```output:
an ordered tuple of the corrected indicies (of the vector array) 

```
=#

#--- compareVector
#=requires the use of indexOF,elementAt 
 a = [2, 1, 3, 4]
 α = 1 
 β = 2

firstContent =Int(findfirst(isequal(α), a)) #indexOf(first)
lastContent =  Int(findfirst(isequal(β), a)) #indexOf(last)

=#

#---correct 
if firstContent > lastContent #correct
    a[α], a[β] = oldschoolSwap!(a[α], a[β]) #plain content swap in julia 
end
a #array values are changed

function oldschoolSwap!(x, y)
    tmp = x
    x = y
    y = tmp
    return x, y
end

function compareVector(α = 1, β = 2, a = [2, 1, 3, 4])
    response = nothing
    try #1. we call this function when we'd like to compare index α with index β of a Vector array  # do your thing 
        firstContent = Int(findfirst(isequal(α), a)) #indexOf(first)
        lastContent = Int(findfirst(isequal(β), a)) #indexOf(last)

        if firstContent > lastContent # correct
            response = @inbounds a[α], a[β] = oldschoolSwap!(a[α], a[β]) #plain content swap in julia  #swap array contents directly

        elseif firstContent < lastContent #only possible - correct situation (to deal with)
            #Intent: skip 
            return
        else #2. throw frisbe error here
            throw(error("Unexpected Error")) # 2. throw(error(ExceptionError)) 
        end

    catch UnexpectedError # 3. catch `materialize` (UnexpectedError object )
        @error UnexpMsg exception = (UnexpectedError, catch_backtrace())   # define Exception here, passing arguments 1. positiveError object, 2. call catch_backtrace() (to catch it) 
    end #ends try - finally afterthat return whatever correct value you've been working on  (if not already ) 
    return response
end


@propagate_inbounds function replaceVector(v = [2, 3], a = [1, 2, 4, 5]; i = 1)
    try
        lenV = copy(length(v))
        lenA = copy(length(a))

        @inbounds if lenV < lenA # first assumption  # |v| < |a|
            @inbounds a[i:lenV] = v[i:lenV]

        else #2. throw frisbe error here
            throw(error("Unexpected Error")) # 2. throw(error(ExceptionError)) 
        end

    catch UnexpectedError # 3. catch `materialize` (UnexpectedError object )
        @error UnexpMsg exception = (UnexpectedError, catch_backtrace())   # define Exception here, passing arguments 1. positiveError object, 2. call catch_backtrace() (to catch it) 
    end #ends try - finally afterthat return whatever correct value you've been working on  (if not already ) 
    return response
end

replaceVector()

@benchmark replaceVector()


#---------------- test 
v = compareVector()
typeof(compareVector)
tuple = compareVector()
v = buildInterval(tuple)# pass-in a tuple   # buildInterval(tuple[1],tuple[2])


#ends 
#=
else
        println(UnexpMsg)
    end
    return a
end
=#
replaceVector() # correct 
@benchmark replaceVector() # optimizable - can do better 


#---- 

res = compareVector() #(1,2) tuple
typeof(res)#tuple 
v = buildInterval(res) #to vector 
a = replaceVector(v, a)
a #check a's contents  



#---test indexOf 
a = [2, 1, 3, 4]
indexOf(1, a)
indexOf(2, a)
@benchmark indexOf(1, a) #possible errrorneous

#=
BenchmarkTools.Trial: 96 samples with 1 evaluation.
 Range (min … max):  41.404 ms … 103.842 ms  ┊ GC (min … max): 0.00% … 0.00%
 Time  (median):     48.335 ms               ┊ GC (median):    0.00%
 Time  (mean ± σ):   52.409 ms ±  12.069 ms  ┊ GC (mean ± σ):  0.49% ± 2.38%

     █▂▄█     
  ▇█▆██████▇▆▆▇▆▁▅▆▆▁▆▃▁▃▃▁▁▁▁▁▁▁▁▁▁▁▁▁▁▅▁▁▁▁▃▁▁▁▁▁▁▃▃▁▁▁▁▁▁▁▃ ▁
  41.4 ms         Histogram: frequency by time          100 ms <

 Memory estimate: 1.11 MiB, allocs estimate: 14363.

indexOf (generic function with 1 method)

1       

2       

4-element Vector{Int64}:
 2
 1
 3
 4

2   
 =#

function compareVectorExperimental([1:2;], a = [2, 1, 3, 4]) end
function compareVectorExperimental2(a = [2, 1, 3, 4], [1:2;]) end
function compareVector(α = 1, β = 2, a = [2, 1, 3, 4])

    try #1. we call this function when we'd like to compare index α with index β of a Vector array  # do your thing 
        _first = Int(indexOf(α, a)) # copy(a[st])
        _last = Int(indexOf(β, a)) # copy(a[ed])
        firstIndex = a[_first]
        lastIndex = a[_last]
        @inbounds if firstIndex > lastIndex #valueAt(2) > valueAt(1) isa true  #_first > _last #
            println(a[_first], a[_last]) # debugging purposes only 
            return @inbounds a[_first], a[_last] = a[_last], a[_first]     #an inbounds swap #actual array swap 

        elseif firstIndex < lastIndex #only possible - correct situation (to deal with)
            #Intent: skip 
            return
        else #2. throw frisbe error here
            throw(error("Unexpected Error")) # 2. throw(error(ExceptionError)) 
        end

    catch UnexpectedError # 3. catch `materialize` (UnexpectedError object )
        @error UnexpMsg exception = (UnexpectedError, catch_backtrace())   # define Exception here, passing arguments 1. positiveError object, 2. call catch_backtrace() (to catch it) 
    end #ends try - finally afterthat return whatever correct value you've been working on  (if not already ) 

end

a = [2, 1, 3, 4]
_first = Int(indexOf(1, a)) # copy(a[st])
_last = Int(indexOf(2, a)) # copy(a[ed])


#------


#=
BenchmarkTools.Trial: 10000 samples with 983 evaluations.
 Range (min … max):  54.527 ns …   5.274 μs  ┊ GC (min … max): 0.00% … 97.01%
 Time  (median):     60.936 ns               ┊ GC (median):    0.00%
 Time  (mean ± σ):   88.895 ns ± 126.925 ns  ┊ GC (mean ± σ):  5.20% ±  3.98%

  ▆█▅▃▂▂▂▃▂▁▃▃▃▂▃▂▂▁▁▁▁▁  ▁                                    ▁
  ████████████████████████████████████▇▆▇▇▇▇▆▆▅▆▇▇▆▅▆▅▆▆▅▅▅▅▄▅ █
  54.5 ns       Histogram: log(frequency) by time       262 ns <


=#

#------
#@benchmark replaceVector2(v,a) 
@benchmark replaceVector(v, a)
#=
 Range (min … max):  21.063 ns … 130.391 ns  ┊ GC (min … max): 0.00% … 0.00%
 Time  (median):     22.568 ns               ┊ GC (median):    0.00%
 Time  (mean ± σ):   26.359 ns ±  10.667 ns  ┊ GC (mean ± σ):  0.00% ± 0.00%

  ▅█▆▃            ▁▂▂ ▁▁ ▁ ▁                                   ▁
  █████▇▇▇▇▆▅▁▃▄▄████████████▇▆▆▆▆▆▆▅▆▇▇▇▇▇▇▇▇▇▆▅▆▆▇▅▅▆▄▅▅▅▄▅▅ █
  21.1 ns       Histogram: log(frequency) by time      75.5 ns <

 Memory estimate: 0 bytes, allocs estimate: 0.
=#

#----test-----------------------------------------------
arr = [1, 2, 3, 4]
divideConquer(arr, arr[1], length(arr) - 1)

length(arr)
#middle(st=1, ed =4)
mid = #middle(1, 4) # ambiguous function  # StackOverflowError:
    cond = isEven(mid) # ERROR: LoadError: UndefVarError: mid not defined

#--test---------------  using Findfirst: indexOF #TODO:
#include("Findfirst.jl")
#actual size 
