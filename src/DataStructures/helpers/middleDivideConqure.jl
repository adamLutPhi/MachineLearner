import Base: @propagate_inbounds, @inbounds
import BenchmarkTools: @btime, @time, @benchmark
UnexpMsg = "ERROR: unexpected input:  please check input arguments , then try again  "


euclidDist(a, b) = abs(a + b)

@propagate_inbounds isEven(st = 1, ed = 10) = middle(st, ed) % 2 == 0 ? true : false

@propagate_inbounds isEven(mid) = mid % 2 == 0 ? true : false

@propagate_inbounds function makeRange(a, b)
    return collect(a:b)
end

@propagate_inbounds function buildMiddle(a, mid, b)
    q = []
    @inbounds push!(q, makeRange(a, mid))
    @inbounds push!(q, makeRange(mid + 1, b))

    return q
end

ranges = []
#--- test: buildMiddle 
@btime resMid = buildMiddle(1, 5, 10) # 104.920 ns (4 allocations: 320 bytes)

@propagate_inbounds function buildAboveSoBelow(a, below, above, b)
    q = []
    @inbounds push!(q, makeRange(a, below))
    @inbounds push!(q, makeRange(below + 1, above))
    @inbounds push!(q, makeRange(above + 1, b))
end


"""a middle function stub without array/vector input feed- the Best? """
@propagate_inbounds function middle(a, b)
    mid = middle(a, b)
    cond = isEven(mid)

    if cond # got mid, mid +1 #start of next range 
        @inbounds push!(ranges, buildMiddle(a, mid, b))

    elseif !cond # got 2 midpoints float, in middle , floor(below), ceil(above)
        above = ceil(mid)
        below = floor(mid)
        @inbounds push!(ranges, buildAboveSoBelow(a, below, above, b))

    else
        println(UnexpError)
    end
end
#--- testing ------


#---test buildMiddle ------
ranges = buildMiddle(1, 2, 4)
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

function goleft(arr = [1, 2, 3, 4], a = 1, b = mid)
    computeRange!(arr, a, b)
end

function goright(arr = [1, 2, 3, 4], a = mid + 1, b = length(arr))
    computeRange!(arr, a, b)
end

#---test ------
arr = [1, 2, 3, 4]
#middle(st=1, ed =4)
mid = middle(1, 4) # ambiguous function 
cond = isEven(mid)

"""(this) Could be a valid middle - Classic #old"""

@propagate_inbounds function middle(st, ed)
    cond = isEven(st, ed)
    @inbounds if cond
        #return mid , mid+1
        mid = Int(abs(st + ed) // 2)
        return mid, mid + 1
        #@inbounds
    elseif !cond #mid = 2.5 #inapplicable for an index 
        above = ceil(mid)
        below = floor(mid)
        return below, above
        # @inbounds
    else
        println(UnexpMsg)
    end
end

middle(1, 10)

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
    @inbounds
    if a[st] > a[ed]
        #Base.@propagate_inbounds  
        @inbounds a[st], a[ed] = a[ed], a[st]        #an inbounds swap #actual array swap 
        #Base.@inbounds 
        @inbounds
    elseif a[st] < a[ed]
        #don't flip # return values  
        return a[st], a[ed]
        #@inbounds a[st], a[ed] = a[st] , a[ed]        #an inbounds swap 
        @inbounds
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

#TODO:
@propogate_inbounds function divideOrNot(range)
    cond = abs(range1[2] - range1[1])

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
    if st < ed

        #@boundscheck if a[st] > a[ed]
        #      @inbounds a[ed], a[st] = a[st] , a[ed]        #an inbounds swap 
        @inbounds a[ed], a[st] = doCompare(a, st, ed)
        #end 
    elseif st > ed # ed smaller can work with that 
        a[ed], a[st] = doCompare(a, ed, st)
    end
end
