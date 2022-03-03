strMsg = "ERROR: unexpected input:  please check input arguments , then try again  "
UnexpMsg = ""
euclidDist(a, b) = abs(a + b)
function makeRange(a, b)
    return collect(a:b)
end

function ranging(a, mid, b)
    q = []
    push!(q, makeRange(a, mid))
    push!(q, makeRange(mid + 1, b))

    return q

end

ranges = ranging(1, 2, 4)
range = popfirst!(ranges)


"""a middle function stub"""
function middle(a, b)
    mid = middle(a, b)
    cond = isEven(mid)
    if cond # got mid, mid +1 #start of next range 
        ranges = ranging(a, mid, b)

    elseif !cond # got 2 midpoints float, in middle , floor(below), ceil(above)
    else
        println(UnexpError)
    end
end


#---
#check n/2 is a whole number
#--- Left Half 

function divideConquer(arr = [1, 2, 3, 4], a = 1, b = length(arr))
    count = 1
    mid = middle(a, b)
    #check valid range 
    cond =mid - count >= 0 ? true : false
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

arr = [1, 2, 3, 4]

mid = middle(a, b)
cond = isEven(mid)

function goleft(arr = [1, 2, 3, 4], a = 1, b = mid)
    computeRange!(arr, a, b)
end
function goright(arr = [1, 2, 3, 4], a = mid + 1, b = length(arr))
    computeRange!(arr, a, b)
end


function middle(st, ed)
    return Int(abs(st + ed) / 2)

end

isEven(st = 1, ed = 10) = middle(st, ed) % 2 == 0 ? true : false

isEven(mid) = mid % 2 == 0 ? true : false


q = []
cond = isEven(1, 3)
res = -1


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


if cond == true
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


"""Plain comparison - flip if lower index has a higher value, otherwise return"""
function doCompare(a = [2, 1, 3, 4], st = 1, ed = 2)

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
        println(strMsg())
        return nothing
        # end
    end
    return a[st], a[ed] 
end

#---test 

res = doCompare() #1 .compare 

res = collect(res) #2. collect 
typeof(res)

# 3. build range 
range1 = res[1]:res[2]


res = doCompare([1, 2, 3, 4], 3, 4) #1.compare the next range 
res = collect(res) #2.collect (tuple -> vector)
range2 = res[1]:res[2] #3. build range 

collect(range2)


#Q. are there any more middles ? NO! how to return  (them correctly ) # i.e. try above & below mid-point extraction 
# terminal condition 


range1[1]
cond = abs(range1[2] - range1[1]) # 4. check distance


#range1[2] = 4 # setindex! not defined for  UnitRange Int64 
#range1[1] = 2

#= UncommentMe 
if  cond == 1 # check current range # if 1 (nothing more to explore )
    #finish this range, get out 
    return 
#end
elseif cond > 1 # there are still ranges in-between  
if abs(range2[2] - range2[1]) == 1 
    return 
end
=#
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





function computeRange!(arr = [1, 2, 3, 4], a = 2, b = 4)
    abs(b - a) # 2 #inferred |4 - 2 | = 2  # 1. check boundary distance 
    if abs(b - a) == 1
        return
        #mid=-1
    else
        if abs(b + a) > 1 #2. check middle 
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
function comp(a = [1, 2, 3, 4], st = 1, ed = 2)
    if st < ed

        #@boundscheck if a[st] > a[ed]
        #      @inbounds a[ed], a[st] = a[st] , a[ed]        #an inbounds swap 
        @inbounds a[ed], a[st] = doCompare(a, st, ed)
        #end 
    elseif st > ed # ed smaller can work with that 
        a[ed], a[st] = doCompare(a, ed, st)
    end
end 
#

