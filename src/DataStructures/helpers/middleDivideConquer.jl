#=
20 named functions ( 19 without counting the mit function)  (counting helper functions) 
10 helper functions 

Divide & Conquer 
Does a Bisection Sort on an array where it measures the length of 
our Objective Function (of the Interval vector) which can either be:=#
#------------------
#= A:
 if it is equal to 1, 
    1. first compare the interval's  contents 
    if left value (of a vector) is higher than the right one, swap vector contents
    2.then we have to stop (as no more middles are available to explore) 
    congratulations, you've reached the end #HALT! =#
#------------------
#= B: However if distance between Interval bounds is higher than 1, hence, there is at least 1 new middle to compute & find out: 
    1.Compute the middle: either there is a whole number, representing an actual index, with Intervals (a,mid) , (mid+1, b) [2 middles mid , mid+1]
     or we've got a fractional middle, that needs to be ceiled (as above) & floored (as below) with intervals:  (a, below),... ,(above, b) (2 middles below & above):

    -new: further care with Interval processing is required: say below+1 & above+1 exits & unique then ranges should be: (a, below), (below+1,above), (above+1, b) #TODO or 
    -- Assuming: below-1 & above-1 exits & unique, 
        then the Intervals: (a,below-1), (below, above-1), (above, b) [if each Interval bound exist, as a whole Int Number]
    --- need to introduce another helper metric, Captures & stores the speed (of algorithm). as both workflows are valid, it would all boil down to the number #1: speed of the Algorithm #better-benchmark

    [this bifurcates the workflow of the program, hence, try one function at once, [the validity of an Interval is the Priority]   ]
    at each Interval-building, we also check the contents of each bounds  
    2. for each new Interval (we got ), compare it's contents, check distance (& we're back to square 1, to A ) #Done! 
# Are the middles compared too (well, as we'd be comparing every Interval, that would be inlusive of generated middles) =#
#------------------
#=if middlle: 
    - is Interval even?: Yes -> has 1 middle #now-here
    - if not: there's a fractionalMid, approximate index to get below & above 
else 
 go left middle(a,b,arr) # mid, mid+1 (isEven), OR # below & above (!isEven) 

 go right middle(a,b,arr) # mid, mid+1 (isEven), OR # below & above (!isEven)

 #tip: (execution) time can be misleading 

 
-
 -buildAboveSoBelow(below, above, a)

 go right 
 go left 

sumInt = sumInterval(a,b)
  isEven2() #true 
  


=#

import Base: @propagate_inbounds, @inbounds # compiler inlines a function, while retaining the caller's inbounds context
import BenchmarkTools: @btime, @time, @benchmark
UnexpMsg = "ERROR: unexpected input:  please check input arguments , then try again  "
positiveMsg = "ERROR: Only Positive input arguments are allowed - please check input arguments, then try again"
outofBoundsMsg = "ERROR: input's length is larger than original vector- kindly check again "

#@benchmark  +(10000, 1000000) #simple + is WAY much Bloated, it isn't simple, anymore :S  
#@benchmark sumInterval(10000, 1000000) =#

@propagate_inbounds isPositive(num) =  0 < num ? true : false

#Euclidean Distnace https://www.sciencedirect.com/topics/mathematics/euclidean-distance#:~:text=The%20weighted%20Euclidean%20distance%20measure,element%20of%20the%20average%20profile.

    #isnumeric(a) && isnumeric(b) && a > 0 && b > 0 ? abs(max(a, b) - min(a, b)) :
    #positiveMsg

#@benchmark sumInterval()
@propagate_inbounds function sumInterval(a, b) # subtracts 1 (complies with julia logic)
    cond = abs(a + b) - 1
    @inbounds if cond >= 1
        return cond
    end
end

#--------------
#3 if-statement-logic (if-elseif-else)


""" checks evinity of a bound between point a to point b   #TODO: Research  >= v.s. > 
```input:
a: lower bound 
b: upper bound 

calculates eucledian distance between a & b 
1. checks if condition is positive 
2. checks evenity  

```
```output:
true  if it's positive & even 
false: if either #improve 
```
"""
@propagate_inbounds function isEven2(a = 1, b = 10) # = readable #preferred #fast  #optimized  #2 if-statements
    try
        @inbounds if a >= 0 && b >= 0   #==#
            distance = sumInterval(a, b) #1.distance 
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
    catch notPositiveInputError
        #Exception 
        @error positiveMsg exception = (notPositiveInputError, catch_backtrace())
        println(positiveMsg) #positive arguments error 
    end #==#
end

@propagate_inbounds function isEven2(m = 10) # = readable #preferred #fast  #optimiz-able  #2 if-statements
    try
        @inbounds if m >= 0  # && b >= 0   #==#
            distance = m  #sumInterval(m) #1.distance 
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
    catch notPositiveInputError

        @error positiveMsg exception = (notPositiveInputError, catch_backtrace())
        println(positiveMsg) #positive arguments error 
    end #==#
end
#--------------------

isEven2(1, 10)# not divisible by 2  -then got fractionalMid , estimate: above & below 

#@benchmark isEven1()
@benchmark isEven2(1, 10) #slightly does better 

@benchmark isEven2() #due to optimization max time drops from 667.437 to 211.268 = 30.483
#in return of a `slight` incremental degredation in the overall mean = 39,860 =  9.860 
#=
mM(s1)=minMax(s1)= Range (min … max):(min … max)= 30.553 ns … 667.437 ns 
mM(s2)=minMax(s2) =Range (min … max): = 30.483 ns … 211.268 ns 
mM(s1)= minMax(s1)= (mean ± σ)= 38.030 ns ±  18.992 ns 
nM(s2)=minMax(s2)=(mean ± σ) = 39.860 ns ±  19.883 ns

diffmM(s1,s2) = mM(s2) - mM(s1) = 30.553 ns … 667.437 ns - 30.483 ns … 211.268 ns 
mM(s2) - mM(s1) = 30.483 ns … 211.268 ns 

mM(s2) / mM(s1) =  
mM(s2) / mM(s1) = 


=# 
#1stOrder 
#RangeRatios
#Low 
diffLow = 30.553 - 30.483 # lower ranges of both trials are near i.e. how 
RatioLow= min(30.483,30.553) / max(30.483,30.553) # low sides almost exact 0.9977088992897588 

#High
diff2sampleHigh= diffHigh = 667.437 - 211.268 # difference high, 2 samples  # # <--------------------
RatioHigh = max(30.483,30.553) / min(30.483,30.553) # RatioHigh  1.0022963619066365

#2nd order  - probabilty High difference  
#dispersuib diffHigh - diffLow 

diffHighLow =N = uncertainRangeHighLow = diffHigh - diffLow # <--------------------
lengthRatio =  diffLow /diffHigh   


probdiffLow =   diffLow/N # inverse of that ratio Lo i.e. diffLo/ rangeHiLo = ProbabilityRatioLo #almost not happening 
probdiffHigh = diffHigh / N #  probabilty High difference   1

#to put things into a metric, Ratio: 
uncertainRatio = N / diffHigh #almost 1 (almost equal)

#try Infer ------------------------------------------------------------------------------------------------------------------------
lendiff_diff =  diffHigh - diffHighLow #<-------------------run this 
diffHighLow ≈  diffHigh


Difference2sampleHigh =  diff2sampleHigh - diffHighLow
#------------------------------------------------------------------------------------------------------------

#2nd order Ratio 
diff2sampleHigh / diffHighLow

#infer 
diff_Difference2sampleHigh = Difference2sampleHigh - lendiff_diff # diffHigh - diffHighLow  
diff_Difference2sampleHigh == Difference2sampleHigh - lendiff_diff

 diff2sampleHigh  -   diffHigh   - (diffHighLow  - diffHighLow )
(diff2sampleHigh)  -   diffHigh    +(diffHighLow  - diffHighLow )
#----------------------------------------------------------------------
diff2sampleHigh  -   diffHigh
diff2sampleHigh == diffHigh
diff2sampleHigh === diffHigh
#---------------------------------------
N = uncertainRangeHighLow = diffHigh - diffLow ≈  diffHigh

N === diffHigh - diffLow 

#--------------------------------------------------------------------------------
#=concludes
isEven2 is slighly better than isEven1 - besides it's more compact, readable 
one obvious reason is: number of if statements: isEven2 has only 2 ifs, while is isEven1 has 3  
=#

@propagate_inbounds isEven(a, b) = isEven2(a, b)
@propagate_inbounds isEven(m) = isEven2(m)
#either 1 of the conditions are true all time 

#Great handy function:
@propagate_inbounds ϟ(a, b) =
    (a > b) ⊻ (b > a) ? max(a, b) - min(a, b) : println(positiveMsg) #  abs(a - b)

#--- buildInterval 

@propagate_inbounds function buildInterval(a, b)

    return collect((a, b))
end

vector = buildInterval(1, 2)

@propagate_inbounds function buildInterval(tuple)

    return collect((tuple[1], tuple[2]))
end

vector =  buildInterval(((1,2)))

function oldschoolSwap!(x, y)
    tmp = x
    x = y
    y = tmp
    return x, y
end
#----------------------

middles = [] # need to track middles 

#----------------------
""" compares vector a, it's element at first index α with second element at index β 

```input:
a: first index of comparison
b: second index of comparison 
arr: the original vector array
```

```output:
an ordered tuple of the corrected indicies (of the vector array) 

```
""" #requires: of indexOf,oldschoolSwap!

function compareVector(a = 1, b = 2, arr = [2, 1, 3, 4])
    response = nothing
    try #1. we call this function when we'd like to compare index α with index β of a Vector array  # do your thing 
       
        firstContent = Int(findfirst(isequal(a), arr)) #indexOf(first)
        lastContent = Int(findfirst(isequal(b), arr)) #indexOf(last)

        if firstContent > lastContent # correct
            response = @inbounds arr[a], arr[b] = oldschoolSwap!(arr[a], arr[b]) #plain content swap in julia  #swap array contents directly

        elseif firstContent < lastContent #only possible - correct situation (to deal with)
            #Intent: skip 
            return response = 1
        else #2. throw frisbe error here
            throw(error("Unexpected Error")) # 2. throw(error(ExceptionError)) 
        end

    catch UnexpectedError # 3. catch `materialize` (UnexpectedError object )
        @error UnexpMsg exception = (UnexpectedError, catch_backtrace())   # define Exception here, passing arguments 1. positiveError object, 2. call catch_backtrace() (to catch it) 
    end #ends try - finally afterthat return whatever correct value you've been working on  (if not already ) 
    return response
end

res = compareVector(1,2,[2, 1, 3, 4])
typeof(res)# no comparison is needed #ERROR

#if res
count=1 
if res === nothing return 
    compareVector(1)
end
typeof(res)
v = buildInterval(res)
#we're good to go!

#--------------------------------------------------------
@propagate_inbounds function indexOf(i, v::Vector)
    try
        res = findfirst(isequal(i), v)
        if isnumeric(res) #  isa Number
            return res
        else
            throw(error("Unexpected Error")) # 2. throw(error(ExceptionError)) 
        end
    catch UnexpectedError
        @error UnexpMsg exception = (UnexpectedError, catch_backtrace())
    end
end


a = [2, 1, 3, 4]
_first = Int(indexOf(1, a)) # copy(a[st])
_last = Int(indexOf(2, a)) # copy(a[ed])

#----------

"""
```
input:

v:  subset vector of indicies (index-space)
a: whole element vector (element-space)
i: the offset from the beginning
```
"""
@propagate_inbounds function replaceVector(v = [1, 2], a = [2, 3, 4, 5]; i = 1) #optimized 
  try
        lenV = copy(length(v))
        lenA = copy(length(a))
        j=1
        subsetIndex= j+i
        @inbounds if lenV <= lenA # first assumption 
            if subsetIndex <= lenA
            for j ∈ 1:lenV
                a[subsetIndex] = v[subsetIndex]
                #a[2] = v[2] #... lenV
            end

            #elseif lenV > lenA #v can't be larger than original vector a (throws an outofBoundsError )
            else
                throw(error("Unexpected error Occured"))
            end
        end
    catch UnexpectedError
        @error UnexpMsg exception = (UnexpectedError, catch_backtrace())
    end
    return a 
end

v = [1, 2]
lenV = copy(length(v))
lenA = copy(length(a))

#------------------
a = [2, 3, 4, 5]
v = [1, 2]

tuple = compareVector( [1, 2], [2, 3, 4, 5])

v = buildInterval(tuple)# pass-in a tuple   # buildInterval(tuple[1],tuple[2])
v = buildInterval(tuple)# pass-in a tuple   # buildInterval(tuple[1],tuple[2])
#v = getindex(::, ::Int64)


a = replaceVector(v, a) #returns correct range
#--------------------------------------------
#Uncoment for Debugging 
#=
@debug a = replaceVector(v,a)  
@debug α = replaceVector2(v,a) 
@debug a == α && a === α #true - doesn't matter which one to pick 
=#

#-----------------

res = compareVector(1,2) #(1,2) tuple
typeof(res)#tuple 

#if res == 1
#else if res is valid 
v = buildInterval(res) #to vector 

 if res == 1 #no need to proceed further    
    return 
 elseif typeof(res) == VecOrMat
    replaceVector(v,a;i) 
 end

function responseHandling(res,v,a = [1, 2, 3, 4];i=1) #TODO: check value 
    if res == +1 #no need to proceed further    
        return 
    elseif typeof(res) == VecOrMat
   return      replaceVector(v,a;i) 
    end
    
end
#a = replaceVector2(v,a) #ERROR: 

#----------- questionable #builds an arbitrary rational numbers fron bound a to b  #0ld-thinking #check-if-Working 
@propagate_inbounds function buildRangeAroundPoint(a, mid, b) #tobe deleted 
    #checked #works but unhelpful #building theoretical ranges  won't belp in  sorting 
    if a >= 0 && mid >= 0 && b >= 0
        q = []
        @inbounds push!(q, buildInterval(a, mid))
        @inbounds push!(q, buildInterval(mid + 1, b))

        return q
    else
        println(positiveMsg)
    end
end

#---transpose (new) (2) possible functions 
#buildInterval: note different type of functions used to map the transpose 
@propagate_inbounds transpose(buildInterval(1, 5)) # transpose
@propagate_inbounds buildInterval(1, 5)' #adjoint 
#-----
buildRangeAroundPoint(1, 5, 9) #errourneous # i wanna 1+10 -> 5 but careful: 1+10 = 11 (odd) & 10-1 = 9 (odd) 11-#TODO: should not be niether 9 nor 11 it should be 10 (10)


#=what-if scenario :
1.what-if the range is already overcalculated: need to fix, using the higher figure: 1+10 -1 =  10 (even)-> 1 middle (as anticipated)
2. generalize to any range by adding -1 
#Either:
r(a = 1, b = 19) = abs(b + a) - 1 #Or 
length((1:10)) #perfect! # length: Built-in function understands it, as well #use it #instead of a+B range calculation (of the middle )

# 9:11-+1:11-9:11 #:10 =#
#---------------------
""" Warning: Assumes there exits a rational series of numbers from point a to point b
this function applies above & below on orgirinal vecto a 
```input:
α: current lower bound (of Interval)
below: 
above: 
β: current upper bound (of Interval)
interval: original vector interval
`

```output:

```
# Examples: 
""" # There's a translation map for a vector space a as well as index space  <---------------
# at this stage: calculated: isEven, no-> calc fracMiddle ceil above, floor below  then we call this function
    @propagate_inbounds function buildAboveSoBelow(below, above, a=[1,2,3,4]) #Checked #requires arr  a as input #a.k.a divideConquer
    try
        if  below >= 0 && above >= 0 && b >= 0

            tuple = compareVector(below, above, a)
            interval = buildInterval(tuple)
            replaceVector(interval, a)
            
            #right()
            exploreInterval(1,2,[1,2])

            #left() 
            exploreInterval(3,4,[3,4])

        else
            throw(error("input arguments must be positive"))
        end

    catch notPositiveInputError
        @error positiveMsg exception = (notPositiveInputError, catch_backtrace())
    end
    return a
end

function exploreInterval(a=3,b=4,arr=[3,4])
   response = nothing 
    _first =  arr[a];
   _last =  arr[b];
    cond =  _first <last 
     try #1. we call this function when we'd like to compare index α with index β of a Vector array  # do your thing 
       
        firstContent = Int(findfirst(isequal(a), arr)) #indexOf(first)
        lastContent = Int(findfirst(isequal(b), arr)) #indexOf(last)

        if firstContent > lastContent # correct
            response = @inbounds a[a], a[b] = oldschoolSwap!(a[a], a[b]) #plain content swap in julia  #swap array contents directly
        
        elseif firstContent < lastContent #only possible - correct situation (to deal with)
            #Intent: skip 
            return
        #elseif firstContent == lastContent
    
    else
        throw(error("Unexpected input arguments"))
    end
    catch UnexpectedError
        @error positiveMsg exception = (UnexpectedError, catch_backtrace())
    end
    #in the end, compare range itself, is there any more space to explore?
   checklastRange(3,4,[3,4])
end 

function  checklastRange(a=3,b=4,arr=[3,4])
try
    difference = ϟ(a,b)
    if difference == 1 #there's exactly 1 return 0 #halt! 
        return 0 # congratulations # you've rearched the end #HALT!

    elseif difference >=1 
        #calculate Interval difference difference
        sum = ϟ(a,b) 
        sum =  Int( sum //2) 
        response =  isEven2(sum)
         HandleResponse(a,b,arr) 
      #TODO:   compareVector(a,b,arr)
    else   
        throw(error("Unexpected input arguments"))
    end
    catch UnexpectedError
        @error UnexpMsg exception = (UnexpectedError, catch_backtrace())
    end #<---------------------------------
      
end

#function middle() 

function divideConquer(a=[4,5,6,7,3]) # <----we are here
    #check length 
   l =  copy(length(a)-1 ) 
   isItEven = copy(isEven2(l))
    evenHandling(isItEven) = isItEven ? middle() : buildAboveSoBelow()
   #call middle 
     m = middle() #found first middle 
    pushfirst!(m, middles)
    #Q. where we go next?  
    goright() # <----
    goleft() #<--- 
    

end


#----------the End--------



#= in the same context, we can logmsg(), debug(), info(), warn()

macro logmsg(level, exs...) logmsg_code((@_sourceinfo)..., esc(level), exs...) end
macro debug(exs...) logmsg_code((@_sourceinfo)..., :Debug, exs...) end
macro  info(exs...) logmsg_code((@_sourceinfo)..., :Info,  exs...) end
macro  warn(exs...) logmsg_code((@_sourceinfo)..., :Warn,  exs...) end

=#

#-------------------------------
"""with a vector provided, making things easier with Comparing, on the spot

""" #Vital function  #here
@propagate_inbounds function buildAboveSoBelow( 
    α,
    β,
    a = [1, 2, 3, 4, 5],
) #Checked    
try
        if  α >= 0 && β >= 0 #at this point: the state variable of above & below is uncertain (cannot be sure ) 
            #Q. is there a need for comparison?  yes, inside compareVector if no need for change tuple would be empty
            tuple = compareVector(α, β, a) #correct 
            interval = buildInterval(tuple)
            length(interval)
            replaceVector(interval, a)# TODO: replace at where ? 

        else
            throw(error("Unexpected input arguments"))
        end
    catch UnexpectedError
        @error positiveMsg exception = (UnexpectedError, catch_backtrace())
    end

   # return q =#
        return a

end

#---------------------------------------
#=test: building above & below (should be automatic)=#
# (α, below, above, β, interval=[1,2,3,4,5] ) #TODO: #@code_llvm() 
function compareVector((1:10;),a)
end 
tuple = compareVector(1, 2, a) #correct 
interval = buildInterval(tuple)
 getindex(::Nothing,::Int64)
length(interval)

#TODO: what's next checklastInterval 
a = buildAboveSoBelow(1, 5, arr) #should return the array a #ERROR: check arguments  #exhausts mid ranges[2] = 6 , 3 element, left, mid, right # still: left, Right 

#----test middle --- 

# mid = middle(a, b) # function calls itself! 
mid = sumInterval(a, b) #mid Pre-cursor
cond = isEven2(mid)#divisible by 2

if cond #isEven,  got mid, mid +1 #start of next range 
    mid=Int(mid//2)
    q = buildRangeAroundPoint(α, mid, β)
    # push!(ranges, buildRangeAroundPoint(a, m
end
#---- middle ----------- 

#e.g. Example 

arr = [1, 22, 34, 44, 55]
#=
for i in 1:length(arr)
    println(popfirst!(arr))   
end 
=#
actualSize = length(arr) + 1  #length = size - 1 #5 

#= 
 if actualSize == 1
#    return
elseif actualSize >= 1 # still values to choose from 
#    evinity = isEven(actualSize)
    #sumInterval(arr[])
    if !evinity #!isEven(actualSize) # false  

    #end
    elseif evinity

    end
=#
isEven(actualSize)
#--- 

q = []
#-------------------------
""" important function for divideConquer: the terminal condition where the distance of ranges become 1  """ # last (first) function of a divideConquer cycle
function isToNotDivide(range) #last function to execute # bounds error 
    cond = abs(length(range)[2] - (range)[1])  # upkoppa #condition Not Divide 
    # response = nothing
    if cond == 1 # check current range # if 1 (nothing more to explore )
        #To Not Divide this range, get out of program 
        return true

    else#if cond > 1 # there are still ranges in-between  (to explore)
        # To Divide  
        return false
        #else 
    end

end
isToNotDivide

#---testing length properties 
length(6:10) - length(3:7) === length(6:10) - length(5:9)
length(6:10) - length(6:10)
#they  not equal 
#-------------- range op (-)
6:10-3:6 #6:10 - 3:10  = 6:7:6 #enigma #can it be go around 6 7 times (the only explination that makes sense)
[3]
[2]
(1:2)[1]

isToNotDivide(buildInterval(1:2;)) #bounds error  
#isToNotDivide(1:4)

"""calls divideConquer - as  at the end there is only One""" # completes the infinite dragon
function calldivideConquer(a, Interval) # contains arr #passes 
    divideConquer(a, Interval[1], length(Interval[1]))
    divideConquer(a, Interval[2], length(Interval[2]))

end
#the absurd call of the  divide (divine)
#finish !
#--------------------------------------------




#----------------------------------------------
#example
arr = [1, 2, 3, 4, 5]
Length = copy(length(arr))
actual = arr[1] + Length #first(arr) + length(arr) #emulates an actual errourneous input 
a = indexOf(arr[1], arr) # 1
b = actualSize - 1; #fudging the number
fractionalMid = length(arr) / 2 # 5/2 = 2.5 #does not exist go to the nearest neighbor #mid = 2.5 
above = Int(ceil(fractionalMid)) # 3
below = Int(floor(fractionalMid)) # 2
 buildAboveSoBelow(below,above,arr)
function middle(a=[1,3,4,5,6])
    ϟ(a[1],length(a)-1)
end 
#------------------------------------------------

#----------------------
#middle(arr) # find middle #q old thinking detedted 

compareVector(1,2,arr)
a = middle(1, 10) # true
typeof(a)
l = length(a) # if length == 3 : Right middle, Left situation #examine each on its own 
#if subrange == 1 return 
length(q[1])
#middle(q[1])
 q[2]
 q[3] #finished middle 

#goright(q[3]) # right is the higher side  #TODO: 

#---Datas fields -----
ranges = [] # all we want is middles 

#--- test: buildRangeAroundPoint 
@btime resMid = buildRangeAroundPoint(1, 5, 10) # 104.920 ns - 105.297 ns  (4 allocations: 320 bytes)


# ranges = buildMiddle(1, 2, 4) # error brings up numbers not in the list (as if its reading off a theoretical array found only in the head )

typeof(ranges)
#range = popfirst!(ranges)
#end buildMiddle -----

#--- test middle(a,b) ---

#--- test buildAboveSoBelow----
#--- test - easy : 
a = [1, 2, 3, 4, 5]
res = buildAboveSoBelow(1, 3, a) # a <below < above < b 

#fine 
res = buildAboveSoBelow(1, -1, a) #TODO: check input arguments are only positive 
typeof(res) #nothing, rather than an errourneous outcome
#TODO: responseHandling

#up until negative - 1 : Interval is omitted, returns an empty Int64[] Interval , else return other positive Interval # fine
#---end

#---
#check n/2 is a whole number
#--- Left Half 
#-- right Half 
#---------------------------------------------------

function goleft(a = [1, 2, 3, 4], α = 1, β = length(arr) - 1)
    res = compareVector(α, β ,a) # TODO: middle(arr, a, b) #or # TODO: middle(a, b, arr)
    if res == +1 #no need to proceed further    
        return 0
    elseif typeof(res) == VecOrMat
        replaceVector() 
    end
end

@benchmark @check_args 1+10^6
@benchmark 1+10^6
#= #UncomentMe 
function goright(a = [1, 2, 3, 4], α = 1, β = length(arr) - 1)  #mid + 1, b = length(arr)) 
    response = nothing
    try
        if res == 1     # ?   return 0 # : replaceVector() #uncommentMe  #no need to proceed further
        #return 0
          response = HandleResponse() 
          return response
        else
        throw(error("Unexpected input arguments")) 
        end 
        elseif typeof(res) == VecOrMat
        replaceVector()
        end
    catch UnexpectedError  
        @error UnexpMsg exception = (UnexpectedError, catch_backtrace())   # define Exception here, passing arguments 1. positiveError object, 2. call catch_backtrace() (to catch it) 
    end  #finaly return 
    return response
end =# 

#=
function HandleResponse(α, β ,a) # todo the hardwork 
    res = compareVector(α, β ,a)
    if res == 1     # ?   return 0 # : replaceVector() #uncommentMe  #no need to proceed further
 
    @check_args lenA = copy(length(arr))
    #size = lenA - 1 # ture last max possible reachable range, in an Array
    isEven(lenA-1) #either even or not 
    #middle here:
    middle = Int(lenA // 2) 



end =#
#= the end =#
#function definition: formula: b + a - 1  - sumInterval
#recap 
# checkdifference(a,b) =  # if interval length equal to 1 
sumInterval(a,b) = 0 < b && 0 < a ? b + a - 1 : -1 ; #TODO: '-1' Handling 
isEven2(a,b) #TODO: evenHandling - now true ? middle(a,b) : buildAboveSoBelow(a,b)
isEven2(1,5) #true 
function middle2(a,b)
 if 0 < b && 0 < a #positive argument @ 
    Int(sumInterval(a,b) //2) 
 else 
     -1 #it's safe to throw an error 
 end 
end 
#---
@propogate_inbounds function buildAboveSoBelow(a=1,b=5) # if false 
#get exact value 
end 
#---------start here 
res = sumInterval(1,5)
function buildAboveSoBelow(num = 5) # if false 
#mid gets exact value 
    mid = num /2
    below  =  Int( floor(mid) )
    above = Int( ceil(mid) ) 
    return below, above
end 
below, above =  buildAboveSoBelow(5)
a= 1; b = 5;#say #-now build corresponding 2 range(tuples )
range1 = (a,below)
typeof(range1)
range1 = collect(range1)
range2  = (below+1, above) #normal way of thinking havent covered this case,yet 
range2 = collect(range2) #where range is range of inicies
#possible errourneous (without arr )
function compareVector(range=range2) #a = 1, b = 2, arr = [2, 1, 3, 4])
    response = nothing
    try #1. we call this function when we'd like to compare index α with index β of a Vector array  # do your thing        
        firstContent = Int(findfirst(isequal(range2[1]), range)) #indexOf(first)
        lastContent = Int(findfirst(isequal(range2[2]), range)) #indexOf(last)

        if firstContent > lastContent # correct
            response = @inbounds arr[a], arr[b] = oldschoolSwap!(arr[a], arr[b]) #plain content swap in julia  #swap array contents directly

        elseif firstContent < lastContent #only possible - correct situation (to deal with)
            #Intent: skip 
            return response = 1
        else #2. throw frisbe error here
            throw(error("Unexpected Error")) # 2. throw(error(ExceptionError)) 
        end

    catch UnexpectedError # 3. catch `materialize` (UnexpectedError object )
        @error UnexpMsg exception = (UnexpectedError, catch_backtrace())   # define Exception here, passing arguments 1. positiveError object, 2. call catch_backtrace() (to catch it) 
    end #ends try - finally afterthat return whatever correct value you've been working on  (if not already ) 
    return response
end

#check distance, first  (we have 2 ranges range1, range2 )

if  range1[2] - range1[1]  == 1 
    a = compareVector(range1)
end 
a
a = compareVector(range1)

firstContent = Int(findfirst(isequal(range1[1]), range1)) #indexOf(first)
lastContent = Int(findfirst(isequal(range1[2]), range1)) #indexOf(last)

    if firstContent > lastContent # correct
        response = @inbounds arr[a], arr[b] = oldschoolSwap!(arr[a], arr[b]) #plain content swap in julia  #swap array contents directly
    end 
response
#assume first range is 1, 2 
#must be handling for it , alerting that it's tur , first < last , returns 0 for finish correctly 
#special unhandeled case: distance == 0 where 3 - 3 = 0 
range2[2]
range2[1] 
#arr 1,2,3  
#last range 3,3 returns 0  #singleton = 3 #scalar value - not a range ! #must insertat sth (or pushlast ) ?
a =[1,2,3]
 #cannot do that! \
#input can be a ramge if dist(range)>=1  or if 0 , return that scalar element, at its index i.e. a[3]
a[3]
# there must be a functionality keeps track of middles ,informs that oh, we're out of middles , we're finished, we can exit safely wihth no errors 
#middle to range functinality as well 

#--------------------------------------------------------------------------
 