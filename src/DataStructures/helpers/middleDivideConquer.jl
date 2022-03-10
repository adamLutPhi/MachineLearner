#=
20 named functions ( 19 without counting the mit function)  (counting helper functions) 
10 helper functions 

Divide & Conquer 
Does a Bisection Sort on an array where it measures the length of 
our Objective Function (of the Interval vector) which can either be:
#------------------
 A:
 if it is equal to 1, 
    1. first compare the interval's  contents 
    if left value (of a vector) is higher than the right one, swap vector contents
    2.then we have to stop (as no more middles are available to explore) 
    congratulations, you've reached the end #HALT! 
#------------------
B: However if distance between Interval bounds is higher than 1, hence, there is at least 1 new middle to compute & find out: 
    1.Compute the middle: either there is a whole number, representing an actual index, with Intervals (a,mid) , (mid+1, b) [2 middles mid , mid+1]
     or we've got a fractional middle, that needs to be ceiled (as above) & floored (as below) with intervals:  (a, below),... ,(above, b) (2 middles below & above):

    -new: further care with Interval processing is required: say below+1 & above+1 exits & unique then ranges should be: (a, below), (below+1,above), (above+1, b) #TODO or 
    -- Assuming: below-1 & above-1 exits & unique, 
        then the Intervals: (a,below-1), (below, above-1), (above, b) [if each Interval bound exist, as a whole Int Number]
    --- need to introduce another helper metric, Captures & stores the speed (of algorithm). as both workflows are valid, it would all boil down to the number #1: speed of the Algorithm #better-benchmark

    [this bifurcates the workflow of the program, hence, try one function at once, [the validity of an Interval is the Priority]   ]
    at each Interval-building, we also check the contents of each bounds  
    2. for each new Interval (we got ), compare it's contents, check distance (& we're back to square 1, to A ) #Done! 
# Are the middles compared too (well, as we'd be comparing every Interval, that would be inlusive of generated middles) 
#------------------
if middlle: 
    - is Interval even?: Yes -> has 1 middle #now-here
    - if not: there's a fractionalMid, approximate index to get below & above 
else 
 go left middle(a,b,arr) # mid, mid+1 (isEven), OR # below & above (!isEven) 

 go right middle(a,b,arr) # mid, mid+1 (isEven), OR # below & above (!isEven)

 #tip: (execution) time can be misleading 
=#
# anymore Please 
import Base: @propagate_inbounds, @inbounds # compiler inlines a function, while retaining the caller's inbounds context
import BenchmarkTools: @btime, @time, @benchmark
UnexpMsg = "ERROR: unexpected input:  please check input arguments , then try again  "
positiveMsg = "ERROR: Only Positive input arguments are allowed - please check input arguments, then try again"
outofBoundsMsg = "ERROR: input's length is larger than original vector- kindly check again "

#@benchmark  +(10000, 1000000) #simple + is WAY much Bloated, it isn't simple, anymore :S  
#@benchmark euclidDist(10000, 1000000) =#

@propagate_inbounds isPositive(num) = num > 0 ? true : false

@benchmark length(1:10)
#Euclidean Distnace https://www.sciencedirect.com/topics/mathematics/euclidean-distance#:~:text=The%20weighted%20Euclidean%20distance%20measure,element%20of%20the%20average%20profile.
max(10) === maximum(10)
max(10) ==maximum(10)

euclideanDist(a,b) = isnumeric(a) && isnumeric(b) && a>0 && b >0 ? abs(max(a,b) -min(a,b)): positiveMsg


@propagate_inbounds function euclidDist(a, b) #euclidDist subtracts 1 (complies with julia logic)
    cond = abs(a + b) - 1
    @inbounds if cond >= 1
        return cond
    end
end

@benchmark euclidDist(1, 10)

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
    catch notPositiveInputError
        #Exception 
        @error positiveMsg exception = (notPositiveInputError, catch_backtrace())
        println(positiveMsg) #positive arguments error 
    end #==#
end

@propagate_inbounds function isEven2(m = 10) # = readable #preferred #fast  #optimized  #2 if-statements
    try
        @inbounds if m >= 0  # && b >= 0   #==#
            distance = m  #euclidDist(m) #1.distance 
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

isEven1()
isEven2(1, 10)

@benchmark isEven1()
@benchmark isEven2(1, 10) #slightly does better 
@benchmark isEven2()
#=concludes
isEven2 is slighly better than isEven1 - besides it's more compact, readable 
one obvious reason is: number of if statements: isEven2 has only 2 ifs, while is isEven1 has 3  
=#
@propagate_inbounds isEven(a, b) = isEven2(a, b)
@propagate_inbounds isEven(m) = isEven2(m)
#either 1 of the conditions are true all time 

@propagate_inbounds ϟ(a, b) =
    (a > b) ⊻ (b > a) ? max(a, b) - min(a, b) : println(positiveMsg) #  abs(a - b)

#--- buildInterval 

@propagate_inbounds function buildInterval(a, b)

    return collect((a, b))
end

buildInterval(1, 2)

@propagate_inbounds function buildInterval(tuple)

    return collect((tuple[1], tuple[2]))
end


function oldschoolSwap!(x, y)
    tmp = x
    x = y
    y = tmp
    return x, y
end
#----------------------
middles=[] # need to track middles 

#----------------------
""" compares vector a, it's element at first index ℵ with second element at index ℶ 

```input:
ℵ: first index of comparison
ℶ: second index of comparison 
a: the original vector array
```

```output:
an ordered tuple of the corrected indicies (of the vector array) 

```
""" #requires: of indexOf,oldschoolSwap!
function compareVector(ℵ = 1, ℶ = 2, a = [2, 1, 3, 4])
    response = nothing
    try #1. call this function when we'd like to compare bounds (ℵ ,ℶ) of a Vector array
        #1.1. check inputs if positive     
        if isnumeric(ℵ) && isnumeric(ℶ) && is  ℵ >= 0 && ℶ >= 0
        firstContent = Int(findfirst(isequal(ℵ), a)) #indexOf(first)
        lastContent = Int(findfirst(isequal(ℶ), a)) #indexOf(last)
        if firstContent > lastContent # correct
            response = @inbounds a[ℵ], a[ℶ] = oldschoolSwap!(a[ℵ], a[ℶ]) #plain content swap

        elseif firstContent < lastContent #only possible - correct situation
            #Intent: skip 
            return
        else #2. throw frisbe error here
            throw(error("Unexpected Error")) # 2. throw(error(ExceptionError)) 
        end
    end
    catch UnexpectedError # 3. catch `materialize` (UnexpectedError object )
        @error UnexpMsg exception = (UnexpectedError, catch_backtrace())   # define Exception here, passing arguments 1. notPositiveInputError object, 2. call catch_backtrace() (to catch it) 
    end #ends try - finally afterthat return whatever correct value you've been working on  (if not already ) 
end

res = compareVector()
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

@propagate_inbounds function replaceVector(v = [1, 2], a = [2, 3, 4, 5]; i = 1) #optimized 
    lenV = copy(length(v))
    lenA = copy(length(a))
    @inbounds if lenV < lenA # first assumption 
        for j ∈ 1:lenV
            a[j] = v[j]
            #a[2] = v[2] #... lenV
        end

        #elseif lenV > lenA #v can't be larger than original vector a (throws an outofBoundsError )
    else
        throw(error("Unexpected error Occured"))
        println(UnexpMsg)
    end
    return a
end

#= to be removed #Uncoment for Debugging
@propagate_inbounds function replaceVector2(v = [1, 2], a = [2, 3, 4, 5]; i = 1)
=#
lenV = copy(length(v))
lenA = copy(length(a))
@inbounds if lenV < lenA # first assumption 
    @inbounds a[i:lenV] = v[i:lenV]

    #elseif lenV > lenA #v can't be larger than original vector a (throws an outofBoundsError )
else
    throw(error("Positive number error"))
    println(UnexpMsg)
end
return a

#------------------
a = [2, 3, 4, 5]
v = [1, 2]

tuple = compareVector()
v = buildInterval(tuple)# pass-in a tuple   # buildInterval(tuple[1],tuple[2])

a = replaceVector(v, a) #ok #returns correct range


#Uncoment for Debugging 
#=
@debug a = replaceVector(v,a)  
@debug α = replaceVector2(v,a) 
@debug a == α && a === α #true - doesn't matter which one to pick 
=#

#-----------------

res = compareVector() #(1,2) tuple
typeof(res)#tuple 
v = buildInterval(res) #to vector 
#a = replaceVector2(v,a) #ERROR: 




#----------- questionable #builds an arbitrary rational numbers fron bound a to b  #0ld-thinking #check-if-Working 
@propagate_inbounds function buildRangeAroundPoint(a, mid, b) #checked #works but unhelpful #building theoretical ranges  won't belp in  sorting 
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
""" Assumes there exits a rational series of numbers from point a to point b
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
@propagate_inbounds function buildAboveSoBelow(below, above, a) #Checked #requires arr  a as input   
    try
        if a >= 0 && below >= 0 && above >= 0 && b >= 0

        tuple = compareVector(below, above,a)
        interval = buildInterval(tuple)
        replaceVector(interval, a)

    else throw(error("input arguments must be positive"))
    end 

    catch notPositiveInputError
        @error positiveMsg exception = (notPositiveInputError, catch_backtrace())
    end
    return a 
end
#end

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
        if a >= 0 && α >= 0 && β >= 0 && b >= 0 #at this point: the state variable of above & below is uncertain (cannot be sure ) 
            #Q. is there a need for comparison?  yes, inside compareVector if no need for change tuple would be empty
            tuple = compareVector(α, β, a) #correct 
            interval = buildInterval(tuple)
            replaceVector(interval, a)

        else
            throw(error("Unexpected input arguments"))
        end
    catch UnexpectedError 
        @error positiveMsg exception = (UnexpectedError, catch_backtrace())
    end

    return q=#
    return a

end

#---------------------------------------
#=test: building above & below (should be automatic)=#
# (α, below, above, β, interval=[1,2,3,4,5] )
a = buildAboveSoBelow(1, 5, arr) #should return the array a #ERROR: check arguments  #exhausts mid ranges[2] = 6 , 3 element, left, mid, right # still: left, Right 










#----test middle --- 

# mid = middle(a, b) # function calls itself! 
mid = euclidDist(a, b) #enforce \upkoppa 
cond = isEven2(mid)

if cond #isEven,  got mid, mid +1 #start of next range 
    q = buildRangeAroundPoint(α, mid, β)
    # push!(ranges, buildRangeAroundPoint(a, m
end
#---- middle ----------- 
@propagate_inbounds function middle(α, β) #can't use it #hmm there is no relation to ar whereas to pull this through, it gotta be there 

    q = []
    # mid = middle(a, b) # function calls itself! 
    interval = euclidDist(α, β) #enforce ϟ \upkoppa [Intent: current Interval bounds α, β]  
    cond = isEven(interval) #
    #calculate middle 
    mid = middle(α, β)
    if cond #isEven,  got mid, mid +1 #start of next range 
        q = buildRangeAroundPoint(α, mid, β) #To-be-Checked
    # push!(ranges, buildRangeAroundPoint(a, mid, b)) # returns [a, mid] , [mid+1, b]

    elseif !cond #!isEven got a fraction, estimated to  2 midpoint Indicies, around middle: below=floor(mid), above = ceil(mid)
        mid = mid / 2  # get  updated middle (fractional) 
        above = Int(ceil(mid))

        below = Int(floor(mid))
        q = buildAboveSoBelow(α, below, above, β)#To-be-Checked 
    # push!(ranges, buildAboveSoBelow(a, below, above, b)) # [a, below] , [above, b]

    else
        println(UnexpError)
    end
    return q
end
middle(1, 5) #errourneous  2.5 3, 4
#------------------------------------------
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
    #euclidDist(arr[])
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
function isToNotDivide(range::UnitRange) #last function to execute # bounds error 
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
#---testing length properties 
length(6:10) - length(3:7) === length(6:10) - length(5:9)
length(6:10) - length(6:10)
#they  not equal 
#--------------
6:10-3:6 #6:10 - 3:10  = 6:7:6 #enigma #can it be go around 6 7 times (the only explination that makes sense)
[3]
[2]
(1:2)[1]
isToNotDivide(1:2) #bounds error 
#isToNotDivide(1:4)

"""calls divideConquer - as  at the end there is only One""" # completes the infinite dragon
function calldivideConquer(a, Interval) # contains arr #passes 
    divideConquer(a, Interval[1], length(Interval[1]))
    divideConquer(a, Interval[2], length(Interval[2]))

end
#the absurd call of the  divide (divine)
#finish !
#--------------------------------------------/


#--test---------------  using Findfirst: indexOF #TODO:
include("Findfirst.jl")
#actual size 
if !isEven(actualSize) # false # 5 there is a fractional middle with ceil & above we can make it  
    α = Findfirst.indexOf(arr[1], arr)
    β = actualSize - 1
    fractionalMid = Int(actualSize / 2)  # 5/2 = 2.5 #does not exist 
    above = ceil(fractionalMid)
    below = floor(fractionalMid)

    q = buildAboveSoBelow(α, below, above, β)
end
#----------------------------------------------
#example
arr = [1, 2, 3, 4, 5]
Length = copy(length(arr))
actual = arr[1] + Length #first(arr) + length(arr) #emulates an actual errourneous input 
a = indexOf(arr[1], arr) # 1
b = actualSize - 1; #fudging the number
fractionalMid = length(arr) / 2 # 5/2 = 2.5 #does not exist go to the nearest neighbor
above = Int(ceil(fractionalMid)) # 3
below = Int(floor(fractionalMid)) # 2

#------------------------------------------------
q = buildAboveSoBelow(α, below, above, β)
#= [1, 2]
 [2, 3]
 [3, 4, 5]=#
l = length(q)
count = 1 #starting from 1
#=
0 -> 3 (3)
1-> 4 (3)
this correctly counts 1 -> 3 (sumRanges 3+1 = 4 but max is 3 )
=#
l = length(q[2]) # 2 
array = []; # [firstvalue]
count = 1
temp = deepcopy(q[2])

typeof(q[2][1]) #Vector #int64

res = q[2] # pop!(q[2]) 
typeof(q[2])

#---repeat 
for i = 1:l #enumerate(q) # in 0:l#4 Always!    #enumerate(q) also works fine as Base.Iterator.Enumerate 
    #count would be 3 = length(q) A lways 
    #count<=l ? count += 1 : break; # count ==3 max
    #array[i] =i 
    push!(array, i)
    item = pop!(q[2]) #pop!(collection) -> item # Remove the last item in collection and return it.
    #i<=l  ? count+= 1 : break; 
    #count+=1 # counts 4 ( size = length(q) + 1 ) #either need to count -1 

end # will count 4 
#count-=1 #learnd heuristic 

array
count -= 1

#count = 0->3 0 index or 1 ->4 1-index 
ℸ = [] #empty 
#deepcopy(ℸ,)

for i = 1:l #  1-> 3 in this case, loop would alway count 3 = intended max  
    #    count+=1 #either this (naive) or 
    #count<=l ? count += 1 : break; # count ==3 max #sophisicated 
    println(i)# infer i is most accurate 
    #insert!([4, 2, 1,3], 4, 3)
    push!(ℸ, i)
    #    popfirst!(q[2]) #2 , 3
end
ℸ
q[2]


#q = buildAboveSoBelow(a, below, above, b)
#doCompare()

doCompare(below, above, arr) #to-be-deleted 

#middle(ar)

q = middle(1, 10) # true
typeof(q)
l = length(q) # if length == 3 : Right middle, Left situation #examine each on its own 
#if subrange == 1 return 
length(q[1])
#middle(q[1])
q[2]
q[3] #finished middle 

#goright(q[3]) # right is the higher side  #TODO: 

#---Datas fields -----
ranges = []

#--- test: buildRangeAroundPoint 
@btime resMid = buildRangeAroundPoint(1, 5, 10) # 104.920 ns - 105.297 ns  (4 allocations: 320 bytes)


#--- testing ------

#---test buildMiddle ------
#ERROR:
# ranges = buildMiddle(1, 2, 4) # error brings up numbers not in the list (as if its reading off a theoretical array found only in the head )

typeof(ranges)
#range = popfirst!(ranges)
#end buildMiddle -----

#--- test middle(a,b) ---

#--- test buildAboveSoBelow----
#--- test - easy : 
a = [1, 2, 3, 4, 5]
res = buildAboveSoBelow(1, 3, 5, 10, a) # a <below < above < b 

#fine 
res = buildAboveSoBelow(1, -1, 5, 10, a) #TODO: check input arguments are only positive 
typeof(res) #nothing, rather than an errourneous outcome

#up until negative - 1 : range is omitted, returns an empty Int64[] range , else return other positive ranges # fine
#Warning: results in an Unbalanced Ranges 
#---end

#---
#check n/2 is a whole number
#--- Left Half 
#---------------------------------------------------
function goleft(a = [1, 2, 3, 4], α = 1, β = length(arr) - 1)
    computeRange!(arr, a, b) # TODO: middle(arr, a, b) #or # TODO: middle(a, b, arr)
end

function goright(a = [1, 2, 3, 4], α = 1, β = length(arr) - 1)  #mid + 1, b = length(arr))
    computeRange!(a, α, β) # # TODO: middle(arr, a, b) #or # TODO: middle(a, b, arr)
    isEven(length(arr)) #either even or not 
end

"""a valid middle - Classic #old #depreciated """
function middle(α, β) # 
    condition = isEven(α, β) #   b-a 
    q = []
    if condition == true
        #return true #a.s. #eucledian Distance divided by 2 returing a whole integer
        check = Int(ϟ(α, β) // 2) # | b + a | // 2 isa Integer #euclideanDist -to-> ϟ#5
        #middleExtraction(condition, check) # Here we didn't get anything ! <------------- # check not defined here 
        #return condition, check 
        push!(q, check)
    elseif !condition # == false
        #return false #a.s.# check = euclideanDist(a,b)//2*1.0
        #GET Ceil & Floor
        euclidDist
        check = ϟ(α, β) / 2 # floating-point division euclideanDist(a, b) / 2 * 1.0 # freely allowing floats, to be ceiled & floored 
        above = Int(ceil(check)) #nearest index above
        below = Int(floor(check))
        push!(q, below)
        push!(q, above)

    else # faulty Input or Unexpected Error Occured
        #    return check  # nothing
        return q #condition, check, above, below
    end
    return q #condition, check, above, below
end
#---------------------------------------------------
#--------------------------------------------------------------------------
"""divideConquer """

# creditL mit 6.006 
#choosing a,b is choosing arr , this is a mean, not a goal 
# divideConquer(a, range[1], length(range[1])) #check 
@propagate_inbounds function divideConquer(a = [1, 2, 3, 4]; α = arr[1], β = length(a) - 1)  ## arr is an initial value, while the goal would be , 1  length(other size of bound to walk on  ) a code that never walks..
    count = 1
    mid = middle(α, β) # first Domino #this presumes middle returns 1 middle # immature 
    #check valid Interval  
    cond = ϟ(mid, count) > 0 ? true : false #= mid - count >= 0=#
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


#----test-----------------------------------------------
arr = [1, 2, 3, 4]
divideConquer(arr, arr[1], length(arr) - 1)

length(arr)
#middle(st=1, ed =4)
mid = middle(1, 4) # ambiguous function  # StackOverflowError:
cond = isEven(mid) # ERROR: LoadError: UndefVarError: mid not defined


#---------------


q = []
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


#called on every range  (of the TotalRange)
#Q. how to build a range ? 
#---------------------------------------------------
@inbounds if cond == true
    res = (1 + 3) // 2
    pushfirst!(q, Int(res))
elseif cond == false
    res = 1 + 3 / 2
    above = ceil(res)
    pushfirst!(q, Int(above))
    below = floor(res)
    pushfirst!(q, Int(below))
end
res
q
length(q)
#return res 
#---------------------------------------------------

"""Plain comparison - flip if lower index has a higher value, otherwise return
given bound values of indicies, find their corresponding value that they weigh, 
then compare them together, as well 

```input:
st: start bound 
ed: ending bound 
a: corresponding vector array to traverse
```

```output:
```

"""
#--- test:  run flow ------------------ 

res = doCompare() #1 .compare #1, 2

res = collect(res) #2. collect 
typeof(res)

# 3. build range 
range1 = res[1]:res[2]
#1.Range (Mid) -to-> weights 
res = doCompare(3, 4, arr) #1.1.compare the next range # (below= 3 , above= 4)#infer: mid 3.5  
res = collect(res) #1.2.collect (tuple -> vector)

#2. Range weights [vector of weights]
range2 = res[1]:res[2] #3. build range # 3:4
collect(range2)

#Q. are there anymore middles? No
# terminal condition #check if interval is still divisible & #check-response   (call divide & Conquer)

range1[1]
cond = abs(range1[2] - range1[1]) # 4. check distance #the thing: 3 -4 == 1 
response(range1) = isToNotDivide(range1) # last function

if !response(range1) # it will only be called when true 
    calldivideConquer(arr, range1)
else
    return (0) # HALT 
end
#Halt 
#---test---------
calldivideConquer(arr, range1)
calldivideConquer(arr, range)



#finish
#------------------------------------------------------------------------------------------------
res = compareVector([1, 2, 3, 4], 2, 4)  #compares a range (& its values ) #deleted #replacewith 
#2. check distance euclid distnace  > 1 
#1. check difference a -b if > 1 (there is still sth to move)  if b - a > 
#
a = 2;
b = 4;
c = middle(a, b) #  euclidDist(2,4) / 2
# build range  
#----testing Area ------- 

abs(β - α) # 2 #inferred ϟ = |4 - 2 | = 2  # 1. check boundary distance 
ϟ(a, b)
#if abs(b - a) > 0  
mid = 0
#2.computer middle 
if abs(2 + 4) > 1 #2. check middle 
    mid = middle(2, 4)
end # 3 .compare Interval  
# 4
#start , mid: 2, 3 
# mid , end: 3, 4 
st = 2;
ed = 3;
a, b = compareVector()   #comp([1, 2, 3, 4], st, ed) #3. compare  # returns values of these  at index 2 , 3 #r

#4. build Interval  
#TODO: indexOf(a), indexOf(b) = a, b #then a:b 
#range1 =  buildInterval(st,ed)  #makeRange(st,ed)  #collect(a:b)
#returns new range 2:3 # vectorized version 

#"""assumes lower indicies have lower values, swap otherwise """ #Redundant
#----------------
#to be removed 
#=
@propagate_inbounds function comp(a = [1, 2, 3, 4], α = 1, β = 2)
    if st < ed
        #@boundscheck if a[st] > a[ed]
        #      @inbounds a[ed], a[st] = a[st] , a[ed]        #an inbounds swap 
        a[ed], a[st] = doCompare(a, α, β)
        #end 

    elseif st > ed # ed smaller can work with that 
        a[ed], a[st] = doCompare(a, α, β)
    end
end #LoadError: syntax: incomplete: "if" at c:\Users\adamus\.git\very Deep\DeepLearner\DeepLearner\src\DataStructures\helpers\middleDivideConquer.jl:500 requires end
=#