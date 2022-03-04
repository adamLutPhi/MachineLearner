import Base: @propagate_inbounds, @inbounds
import BenchmarkTools: @btime, @time, @benchmark
UnexpMsg = "ERROR: unexpected input:  please check input arguments , then try again  "
positiveMsg = "ERROR: Only Positive input arguments are allowed - please check input arguments, then try again"
#=
@benchmark  +(10000, 1000000) #simple + is WAY much Bloated, it isn't simple, anymore  

@benchmark euclidDist(10000, 1000000) =#

@propagate_inbounds euclidDist(a, b) = abs(a + b) # Range (min … max):  0.001 ns … 0.100 ns
#ambiguous here : even is calling middle #Warning 

@propagate_inbounds isEven(st = 1, ed = 10) = euclidDist(st, ed) % 2 == 0 ? true : false


@propagate_inbounds isEven(num) = num % 2 == 0 ? true : false #q. do we check only middle, or also the  total length ?  (depends )


@propagate_inbounds ϟ(a, b) =
    a - b >= 0 || b - a >= 0 ? max(a, b) - min(a, b) : println(positiveMsg) #  abs(a + b)


@propagate_inbounds function makeRange(a, b)
    return collect(a:b)
end


@propagate_inbounds function buildRangeAroundPoint(a, mid, b)
    if a >= 0 && mid >= 0 && b >= 0
        q = []
        @inbounds push!(q, makeRange(a, mid))
        @inbounds push!(q, makeRange(mid + 1, b))

        return q
    else
        println(positiveMsg)
    end
end

""" Assumes there is a rational series of numbers from point a to point b """
@propagate_inbounds function buildAboveSoBelow(a, below, above, b) #Checked 
    if a >= 0 && below >= 0 && above >= 0 && b >= 0
        q = []
        @inbounds push!(q, makeRange(a, below))
        @inbounds push!(q, makeRange(below , above))
        @inbounds push!(q, makeRange(above , b))
        return q
    else
        println(positiveMsg)
    end
end
"""with a vector provided, """
@propagate_inbounds function buildAboveSoBelow(a, below, above, b,vec) #Checked 
    if a >= 0 && below >= 0 && above >= 0 && b >= 0
        #doCompare function
        doCompare(vec,a,b) #a,b are aompared 
        doCompare(vec,above,below)
        q = []
        @inbounds push!(q, makeRange(a, below))
        @inbounds push!(q, makeRange(below , above))
        @inbounds push!(q, makeRange(above , b))
        return q
    else
        println(positiveMsg)
    end
end


ranges = buildAboveSoBelow(1, 5, 6, 11) #exhausts mid ranges[2] = 6 , 3 element, left, mid, right # still: left, Right 


#---- 
@propagate_inbounds function middle(a, b) #use this 
    q = []
    # mid = middle(a, b) # function calls itself! 
    mid = euclidDist(a, b) #enforce \upkoppa 
    cond = isEven(mid)

    if cond # got mid, mid +1 #start of next range 
        q = buildRangeAroundPoint(a, mid, b)
        # push!(ranges, buildRangeAroundPoint(a, mid, b)) # returns [a, mid] , [mid+1, b]

    elseif !cond # got 2 midpoints float, in middle , floor(below), ceil(above)
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
arr = [1, 22, 34, 44, 55]
actualSize = length(arr) + 1  #length = size - 1 #5 
if actualSize == 1
    return
elseif actualSize >= 1 # still values to choose from 
    #euclidD = actualSize
    if !isEven(actualSize) # false 
    end
end
q = []
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
arr = [1, 2, 3, 4, 5]
#  length(arr)
a = indexOf(arr[1], arr)
b = actualSize - 1;
fractionalMid = length(arr) / 2 # 5/2 = 2.5 #does not exist 
above = Int(ceil(fractionalMid)) # 3
below = Int(floor(fractionalMid)) # 2

q = buildAboveSoBelow(a, below, above, b)
q = buildAboveSoBelow(a, below, above, b)
q
#middle(ar)

q = middle(1, 10) # true
length(q) # if length == 3 : Right middle, Left situation #examine each on its own 
#if subrange == 1 return 
length(q[1])
middle(q[1])
q[2]
q[3]
goright(q[3])
#---Datas fields -----
ranges = []

#--- test: buildRangeAroundPoint 
@btime resMid = buildRangeAroundPoint(1, 5, 10) # 104.920 ns - 105.297 ns  (4 allocations: 320 bytes)


#=UncommentMe
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
ranges = buildMiddle(1, 2, 4) # error brings up numbers not in the list (as if its reading off a theoretical array found only in the head )


typeof(ranges)
range = popfirst!(ranges)
#end buildMiddle -----

#--- test middle(a,b) ---

#---test buildAboveSoBelow----
#--- test - easy : 
res = buildAboveSoBelow(1, 3, 5, 10) # a <below < above < b 
#fine 
res = buildAboveSoBelow(1, -1, 5, 10) #TODO: check input arguments are only positive 
#up until negative - 1 : range is omitted, returns an empty Int64[] range , else return other positive ranges # fine
#Warning: results in an Unbalanced Ranges 
#--- 
#---
#check n/2 is a whole number
#--- Left Half 

"""divideConquer - try again """
@propagate_inbounds function divideConquer(arr = [1, 2, 3, 4], a = 1, b = length(arr))
    count = 1
    mid = middle(a, b)
    #check valid range 
    cond = mid - count >= 0 ? true : false
    q = []
    #if cond
    if a[mid] < a[mid-1] # only look at left half 1 . . . n/2 − − − 1 to look for peak
        pushfirst!(q, goleft(arr, a, mid))

    elseif a[mid] < a[mid+1] # only look at right half n/2 + 1 . . . n to look for peak
        pushfirst!(q, goright(a))

    else # a[mid] =?= a[mid+1]
        pushfirst!(q, mid) # the peak!
    end
end

function goleft(arr = [1, 2, 3, 4], a = 1, b = length(arr))
    computeRange!(arr, a, b)
end

function goright(arr = [1, 2, 3, 4], a = 1, b = length(arr))  #mid + 1, b = length(arr))
    computeRange!(arr, a, b)
    isEven(length(arr)) #either even or not 
end

#---test ------
arr = [1, 2, 3, 4]
length(arr)
#middle(st=1, ed =4)
mid = middle(1, 4) # ambiguous function  # StackOverflowError:
cond = isEven(mid) # ERROR: LoadError: UndefVarError: mid not defined

"""(this) Could be a valid middle - Classic #old"""
function middle(a, b) # working 
    condition = evenCriterion(a, b) #   b-a 
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
ϟ(a, b) = abs(a + b) # floating-point division euclideanDist(a, b) / 2 * 1.0 # freely allowing floats, to be ceiled & floored 
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
abs(1 - 2) == 1
abs(2 - 3) == 1
# final comparison 
#compare current ranges with their value , do comparison when required  
a[1]


#called on every range  (of the TotalRange)
#Q. how to build a range ? 

@inbounds
if cond == true
    res = (1 + 3) // 2
    pushfirst!(q, Int(res))
    @inbounds
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


"""Plain comparison - flip if lower index has a higher value, otherwise return"""
@propagate_inbounds function doCompare(a = [2, 1, 3, 4], st = 1, ed = 2)

    # Base.@propagate_inbounds 
    @inbounds if a[st] > a[ed]
        #Base.@propagate_inbounds  
        @inbounds a[st], a[ed] = a[ed], a[st]        #an inbounds swap #actual array swap 
        #Base.@inbounds 

    elseif a[st] < a[ed]
        #don't flip # return values  
        return a[st], a[ed]
        #@inbounds a[st], a[ed] = a[st] , a[ed]        #an inbounds swap 
 
    else
        println(UnexpMsg)
        return nothing
        # end
    end
    return a[st], a[ed]
end

#--- test:  run flow ------------------ 

res = doCompare() #1 .compare 

res = collect(res) #2. collect 
typeof(res)

# 3. build range 
range1 = res[1]:res[2]

res = doCompare([1, 2, 3, 4], 3, 4) #1.compare the next range 
res = collect(res) #2.collect (tuple -> vector)
range2 = res[1]:res[2] #3. build range 

collect(range2)

#Q. are there any more middles? NO! If so, how to return (them correctly ) # i.e. try above & below mid-point extraction 
# terminal condition 

range1[1]
cond = abs(range1[2] - range1[1]) # 4. check distance
divideOrNot(range1)

#range1[2] = 4 # setindex! not defined for  UnitRange Int64 
#range1[1] = 2

#TODO: Check this 
@propogate_inbounds function divideOrNot(range)
    cond = abs(range1[2] - range1[1])  # upkoppa

    @inbounds if cond == 1 # check current range # if 1 (nothing more to explore )
        #finish this range, get out 
        #final
        return

        @inbounds
    elseif cond > 1 # there are still ranges in-between  (to explore)
        #TODO 
    end
end


middle(a, b) = Int(euclidDist(a, b) // 2)


res = doCompare([1, 2, 3, 4], 2, 4) #compare a range (& its values )
#2. check distance euclid distnace  > 1 
#1. check difference a -b if > 1 (there is still sth to move)  if b - a > 
#
a = 2;
b = 4;
c = middle(a, b) #  euclidDist(2,4) / 2
# build range  


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


@propagate_inbounds function computeRange!(arr = [1, 2, 3, 4], a = 2, b = 4)
    abs(b - a) # 2 #inferred |4 - 2 | = 2  # 1. check boundary distance 
    @inbounds if abs(b - a) == 1
        return
        #mid=-1
        @inbounds
    else
        @inbounds if abs(b + a) > 1 #2. check middle 
            mid = middle(2, 4)
        end # 3 
        # compare ranges  
        #start , mid: 2, 3 
        # mid , end: 3, 4 
        st = 2
        ed = 3
        a, b = comp(arr, st, ed) #3. compare  # returns values of these  at index 2 , 3 #r

        #4. build range 
        #TODO: indexOf(a), indexOf(b) = a, b #then a:b 
        range1 = collect(a:b)
        #returns new range 2:3 # vectorized version 
        computeRange!(arr, 2, 3) # where it will return
    end
end
#finally , new range enters the check again , if boundaty is 1 return 
anEven = isEven(mid) # 3 is not even  #check even 


#"""assumes lower indicies have lower values, swap otherwise """
@propagate_inbounds function comp(a = [1, 2, 3, 4], st = 1, ed = 2)
    @inbounds if st < ed

        #@boundscheck if a[st] > a[ed]
        #      @inbounds a[ed], a[st] = a[st] , a[ed]        #an inbounds swap 
        @inbounds a[ed], a[st] = doCompare(a, st, ed)
        #end 
        @inbounds
    elseif st > ed # ed smaller can work with that 
        @inbounds a[ed], a[st] = doCompare(a, ed, st)
    end
end
