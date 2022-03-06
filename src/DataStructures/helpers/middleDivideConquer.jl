#=
20 named functions ( 19 without counting the mit function)  (counting helper functions) 
10 helper functions 

Divide & Conquer 
 does  a Bisection Sort on an array 
 where it measurees the length, our Objective Function, of a vector bounds (both upper, & lower ):
#------------------
 A:
 if it is equal to 1, 
    1. first compare their contents(if left value of a vector is higher than the right one, swap vector contents ),
    2.then we have to stop (as no more middles are available to explore) 
    congratulations, you've reached the end #HALT! 
#------------------
B: However if distance between vector bounds is higher than 1 (hence there is at least 1 new middle to compute & find out ):
    1.Compute the middle: either there is a whole number, representing an actual index, with ranges (a,mid) , (mid+1, b) [2 middles mid , mid+1]
     or we've got a fractional middle, that needs to be ceiled (as above) & floored (as below) with ranges a, below , above, b (2 middles below & above)
    
    -new: furter care with range processing is required say below+1 & above+1 exits & unique then ranges should be: (a, below), (below+1,above), (above+1, b) #TODO or 
    -- if say, below-1 & above-1 exits & unique, then ranges: (a,below-1), (below, above-1), (above, b) [if each range bound exist, as a whole Int Number]
    --- need to introduce another helper metric, the speed (of algorithm) . as both workflows are valid, it would all boil down to the number #1: speed of the Algorithm #benchmark 
    
    [this bifurcates the workflow of the program, hence, try one function at once, [the validity of a range is the Priority]   ]
    at each rangebuilding, we also check the contents of each bounds  
    2. for each new range (we got ), check distance (& we're back to square 1, to A: ) #Done! 

#------------------
if middlle 
    - is even?:Yes -> has 1 middle 
    -if not, there's a fractionalMid, need to approximate index to get below & above 
else 
 go left middle(a,b,arr) #mid, mid+1 or below & above 

 go right middle(a,b,arr) # mid, mid+1. or below & above

=#
import Base: @propagate_inbounds, @inbounds
import BenchmarkTools: @btime, @time, @benchmark
UnexpMsg = "ERROR: unexpected input:  please check input arguments , then try again  "
positiveMsg = "ERROR: Only Positive input arguments are allowed - please check input arguments, then try again"
#=
@benchmark  +(10000, 1000000) #simple + is WAY much Bloated, it isn't simple, anymore  
@benchmark euclidDist(10000, 1000000) =#

@propagate_inbounds isPositive(num) = num > 0 ? true : false


@benchmark length(1:10)
@benchmark euclidDist(1,10)
#@propagate_inbounds euclidDist(a, b) = abs(a + b) +1> # Range (min … max):  0.001 ns … 0.100 ns

@propagate_inbounds function euclidDist(a, b)
    cond = abs(a + b) - 1 # the actual bound length  in julia 
 @inbounds  if cond >= 1 
    return cond
    else
    end 
    return
end 

@benchmark euclidDist(1,10)

#ambiguous here : even is calling middle #Warning 

@propagate_inbounds isEven(st = 1, ed = 10) =
    isPositive(num) && euclidDist(st, ed) % 2 == 0 ? true : false


@propagate_inbounds isEven(num) = isPositive(num) && num % 2 == 0 ? true : false #q. do we check only middle, or also the  total length ?  (depends )


ϟ(a, b) = (a - b > 0) ⊻ (b - a > 0) ? max(a, b) - min(a, b) : println(positiveMsg) #  abs(a - b)
#----------------------
@propagate_inbounds function doCompare(st = 1, ed = 2, a = [2, 1, 3, 4]) # a bit absurd (don't you think?) #no everthing is fine # it's your nagging mind that is 

    # Base.@propagate_inbounds 
    @inbounds if a[st] > a[ed]
        #Base.@propagate_inbounds  
        @inbounds a[st], a[ed] = a[ed], a[st]        #an inbounds swap #actual array swap 
    #Base.@inbounds 

    elseif a[st] < a[ed]
        #don't flip # return values  
        # return a[st], a[ed]
        #@inbounds a[st], a[ed] = a[st] , a[ed]        #an inbounds swap 
    else
        println(UnexpMsg)
    end
    return a[st], a[ed]
end

@propagate_inbounds function makeRange(a, b)
    return collect(a:b)
end

#-----------
@propagate_inbounds function buildRangeAroundPoint(a, mid, b) #checked 
    if a >= 0 && mid >= 0 && b >= 0
        q = []
        @inbounds push!(q, makeRange(a, mid))
        @inbounds push!(q, makeRange(mid + 1, b))

        return q
    else
        println(positiveMsg)
    end
end

buildRangeAroundPoint(1,5,10) # i wanna 1+10 -> 5 but careful: 1+10 = 11 (odd) & 10-1 = 9 (odd) 11-#TODO: should not be niether 9 nor 11 it should be 10 (10)
#=what-if scenario :
1.what-if the range is already overcalculated: need to fix, using the higher figure: 1+10 -1 =  10 (even)-> 1 middle (as anticipated)
2. generalize to any range by adding -1 
=#
r(a=1,b=19) = abs(b + a) -1 #or 
length((1:10)) #length Built-in function understands it, as well #use it #instead of a+B range calculation (of the middle )
 
9:11 -+ 1:11 - 9:11 #:10 #

""" Assumes there is a rational series of numbers from point a to point b """
@propagate_inbounds function buildAboveSoBelow(a, below, above, b) #Checked 
    if a >= 0 && below >= 0 && above >= 0 && b >= 0
        q = []
        @inbounds push!(q, makeRange(a, below))
        @inbounds push!(q, makeRange(below, above))
        @inbounds push!(q, makeRange(above, b))
        return q
    else
        println(positiveMsg)
    end
end


"""with a vector provided, making things easier with Comparing, on the spot"""
@propagate_inbounds function buildAboveSoBelow(a, below, above, b, vec) #Checked 
    if a >= 0 && below >= 0 && above >= 0 && b >= 0
        #doCompare function
        doCompare(a, b, vec) #a,b are Compared 
        doCompare(above, below, vec)
        q = []
        @inbounds push!(q, makeRange(a, below))
        @inbounds push!(q, makeRange(below, above))
        @inbounds push!(q, makeRange(above, b))
        return q
    else
        println(positiveMsg)
    end
end
#---------------------------------------

ranges = buildAboveSoBelow(1, 5, 6, 11) #exhausts mid ranges[2] = 6 , 3 element, left, mid, right # still: left, Right 

#----test middle --- 

    # mid = middle(a, b) # function calls itself! 
    mid = euclidDist(a, b) #enforce \upkoppa 
    cond = isEven(mid)

    if cond #isEven,  got mid, mid +1 #start of next range 
        q = buildRangeAroundPoint(a, mid, b)
        # push!(ranges, buildRangeAroundPoint(a, m

#---- middle ----------- 
@propagate_inbounds function middle(a, b) #can't use it #hmm there is no relation to ar whereas to pull this through, it gotta be there 

    q = []
    # mid = middle(a, b) # function calls itself! 
    mid = euclidDist(a, b) #enforce \upkoppa  
    cond = isEven(mid)

    if cond #isEven,  got mid, mid +1 #start of next range 
        q = buildRangeAroundPoint(a, mid, b)
        # push!(ranges, buildRangeAroundPoint(a, mid, b)) # returns [a, mid] , [mid+1, b]

    elseif !cond #!isEven got a fraction, estimated to  2 midpoint Indicies, around middle: below=floor(mid), above = ceil(mid)
        mid = mid / 2  # get  updated middle (fractional) 
        above = Int(ceil(mid))

        below = Int(floor(mid))
        q = buildAboveSoBelow(a, below, above, b)
        # push!(ranges, buildAboveSoBelow(a, below, above, b)) # [a, below] , [above, b]

    else
        println(UnexpError)
    end
    return q
end
middle(1,5) #errourneous  2.5 3, 4  
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
""" important function for divideConquer: the terminal condition where the distance of ranges become 1  """
function isToNotDivide(range::UnitRange)
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

length(6:10) - length(3:7) === length(6:10) - length(5:9)
length(6:10) - length(6:10)
#they  not equal 
#--------------
6:10-3:6 #6:10 - 3:10  = 6:7:6 #enigma #can it be go around 6 7 times (the only explination that makes sense)
[3]
[2]
(1:2)[1]
isToNotDivide(1:2)
#isToNotDivide(1:4)

"""calls divideConquer - as  at the end there is only One""" # completes the infinite dragon
function calldivideConquer(arr, range) # contains arr #passes 
    divideConquer(arr, range[1], length(range[1]))
    divideConquer(arr, range[2], length(range[2]))

end
#the absurd call of the  divide (divine)

#--------------------------------------------/


#-----------------  using Findfirst: indexOF #TODO:
include("Findfirst.jl")

if !isEven(actualSize) # false # 5 there is a fractional middle with ceil & above we can make it  
    a = Findfirst.indexOf(arr[1], arr)
    b = actualSize - 1
    fractionalMid = Int(actualSize / 2)  # 5/2 = 2.5 #does not exist 
    above = ceil(fractionalMid)
    below = floor(fractionalMid)

    q = buildAboveSoBelow(a, below, above, b)
end
#----------------------------------------------

arr = [1, 2, 3, 4, 5]
#  length(arr)
a = indexOf(arr[1], arr)
b = actualSize - 1;
fractionalMid = length(arr) / 2 # 5/2 = 2.5 #does not exist go to the nearest neighbor
above = Int(ceil(fractionalMid)) # 3
below = Int(floor(fractionalMid)) # 2

q = buildAboveSoBelow(a, below, above, b)
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

doCompare(below, above, arr)
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


#=UncommentMe #seems an alternative is already present 
"""a middle function stub without array/vector input feed- the Best? - unbounded """
@propagate_inbounds function middle(a, b)
    mid = middle(a, b)
    cond = isEven(mid)

    if cond # got mid, mid +1 #start of next range 
         push!(ranges, buildMiddle(a, mid, b))

    elseif !cond # got 2 midpoints float, in middle , floor(below), ceil(above)
        above = ceil(mid)
        below = floor(mid)

         push!(ranges, buildAboveSoBelow(a, below, above, b))

        else
        println(UnexpError)
    end
end
=#
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
res = buildAboveSoBelow(1, 3, 5, 10) # a <below < above < b 

#fine 
res = buildAboveSoBelow(1, -1, 5, 10) #TODO: check input arguments are only positive 
typeof(res) #nothing, rather than an errourneous outcome

#up until negative - 1 : range is omitted, returns an empty Int64[] range , else return other positive ranges # fine
#Warning: results in an Unbalanced Ranges 
#---end

#---
#check n/2 is a whole number
#--- Left Half 

function goleft(arr = [1, 2, 3, 4], a = 1, b = length(arr))
    computeRange!(arr, a, b) # TODO: middle(arr, a, b) #or # TODO: middle(a, b, arr)
end

function goright(arr = [1, 2, 3, 4], a = 1, b = length(arr))  #mid + 1, b = length(arr))
    computeRange!(arr, a, b) # # TODO: middle(arr, a, b) #or # TODO: middle(a, b, arr)
    isEven(length(arr)) #either even or not 
end
#--------------------------------------------------------------------------
"""divideConquer """

# creditL mit 6.006 
#choosing a,b is choosing arr , this is a mean, not a goal 
# divideConquer(arr, range[1], length(range[1])) #check 
@propagate_inbounds function divideConquer(arr = [1, 2, 3, 4], a = arr[1], b = length(arr))  ## arr is an initial value, while the goal would be , 1  length(other size of bound to walk on  ) a code that never walks..
    count = 1
    mid = middle(a, b) # first Domino #this presumes middle returns 1 middle # immature 
    #check valid range 
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


#---test ------
arr = [1, 2, 3, 4]
divideConquer(arr, arr[1], length(arr))

length(arr)
#middle(st=1, ed =4)
mid = middle(1, 4) # ambiguous function  # StackOverflowError:
cond = isEven(mid) # ERROR: LoadError: UndefVarError: mid not defined

"""(this) Could be a valid middle - Classic #old #depreciated """
function middle(a, b) # working 
    condition = isEven(a, b) #   b-a 
    # check = nothing;check = midCriterion(m) #b-a
    #above = nothing
    #below = nothing
    #check = nothing
    q = []
    if condition == true
        #return true #a.s. #eucledian Distance divided by 2 returing a whole integer
        check = Int(ϟ(a, b) // 2) # | b + a | // 2 isa Integer #euclideanDist -to-> ϟ#5
        #middleExtraction(condition, check) # Here we didn't get anything ! <------------- # check not defined here 
        #return condition, check 
        push!(q, check)
    elseif !condition # == false
        #return false #a.s.# check = euclideanDist(a,b)//2*1.0
        #GET Ceil & Floor
        check = ϟ(a, b) / 2 # floating-point division euclideanDist(a, b) / 2 * 1.0 # freely allowing floats, to be ceiled & floored 
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

#TODO: #UncommentMe
#=function ()

end=#

# _mid[] #check this 

#isEven(st = 1, ed = 10) = middle(st, ed) % 2 == 0 ? true : false

#isEven(mid) = mid % 2 == 0 ? true : false

q = []
cond = isEven(1, 3)
res = -1

#---test run tryout

#1,3 total range 
# 1+3/2 = 2 
#yeilds 1:2 , 2:3 
#check dist 

abs(2 - 3) == 1
# final comparison 
#compare current ranges with their value , do comparison when required  
a[1]


#called on every range  (of the TotalRange)
#Q. how to build a range ? 

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
#---test  -----

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

#Q. are there any more middles? NO! If so, how to return (them correctly ) # i.e. try above & below mid-point extraction 
# terminal condition 

range1[1]
cond = abs(range1[2] - range1[1]) # 4. check distance #the thing: 3 -4 == 1 
response(range1) = isToNotDivide(range1) # unsued Important function #TODO: use it 

if !response(range1) # this means it will only be called when true 
    calldivideConquer(arr, range1)
else #
end
#Halt 


calldivideConquer(arr, range1)
calldivideConquer(arr, range)




#------------------------------------------------------------------------------------------------
res = doCompare([1, 2, 3, 4], 2, 4) #compare a range (& its values )
#2. check distance euclid distnace  > 1 
#1. check difference a -b if > 1 (there is still sth to move)  if b - a > 
#
a = 2;
b = 4;
c = middle(a, b) #  euclidDist(2,4) / 2
# build range  
#----testing Area ------- 

abs(b - a) # 2 #inferred |4 - 2 | = 2  # 1. check boundary distance 
#if abs(b - a) > 0  
mid = -1
if abs(2 + 4) > 1 #2. check middle 
    mid = middle(2, 4)
end # 3 
# compare ranges  
#start , mid: 2, 3 
# mid , end: 3, 4 
st = 2;
ed = 3;
a, b = comp([1, 2, 3, 4], st, ed) #3. compare  # returns values of these  at index 2 , 3 #r

#4. build range 
#TODO: indexOf(a), indexOf(b) = a, b #then a:b 
range1 = collect(a:b)
#returns new range 2:3 # vectorized version 

#"""assumes lower indicies have lower values, swap otherwise """ #Redundant
#----------------

@propagate_inbounds function comp(a = [1, 2, 3, 4], st = 1, ed = 2)
    if st < ed
        #@boundscheck if a[st] > a[ed]
        #      @inbounds a[ed], a[st] = a[st] , a[ed]        #an inbounds swap 
        a[ed], a[st] = doCompare(a, st, ed)
        #end 

    elseif st > ed # ed smaller can work with that 
        a[ed], a[st] = doCompare(a, ed, st)
    end
end #LoadError: syntax: incomplete: "if" at c:\Users\adamus\.git\very Deep\DeepLearner\DeepLearner\src\DataStructures\helpers\middleDivideConquer.jl:500 requires end
