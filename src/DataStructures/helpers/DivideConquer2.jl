"""Synopsis 
index space functions: middle(a,b)
oldSchoolSwap(a, b)
"""

#index space & value space function 
function divideConquer(arr; start = 1) # 1 D vector of Float32 (64) #cross-reference with a binary-tree 
    # check length 
    # l is total actual length (of a list vector)
    l = length(arr) - 1 >= 0 ? copy(length(arr)) - 1 : -1  # actual size = length() -1 # l takes 0, 1, or more (cover them )
    if l == 0  # 3,3 length =0 , singlton , scalar 
        #store leaf node #TODO: 
        return 0 #scalar
    elseif l == 1 # 2,3 length = 1 
        #find: first last 
        aContent = arr[l] #unsure if first is list[1]
        bContent = arr[l+l]
        if aContent > bContent
            aContent, bContent = oldSchoolSwap(aContent, bContent)
            #store node with their values 
        end
    else # l  > 1 # there are still ranges to be explored 
        #isEven()
        #your best bet 
        a = start #list() 
        b = list
        #isEven(a,b)
        m1, m2, whole = middle(a, b) #doesn't matter if mid , mid+1 or below, above   # how much important is whole (in tree building wanna ensure 1 node for middle , or 2 actual middles)
        #got following ranges 
        (a, m1) # 1 # right #index-space
        (m1 + 1, m2) #2 #middle range # index-space 
        (m2 + 1, b)  # 3 # left #index-space 

        #not good enough : need a method translating indices above to actual array values (sothat they can be called by this function recursively)


    end

end
#-----------
function isPositive(number)
    try
        if number >= 0
            return true
        elseif number < 0
            return false
        else
            throw(error("Unexpected error occured"))
        end
    catch UnexpectedError
        @error exception = (UnexpectedError, catch_backtrace)
    end
end
#----------
#euclidean distance, for values between a & b : a+b + 1 = a+ b + start -> this changes range end accordingly 
euclidDist(a::Int64, b::Int64; s = 1::Int64) =
    0 <= a && 0 <= b && 0 <= s ? max(a, b) - min(a, b) + s : -1 #both a,b > 1 positive 
euclidDist(2, 4) # = 2,3,4 = 3 numbers  (2)
euclidDist(2, 5) # 2,3,4,5 = 4 numbers (2 & 5 )
euclidDist(1, 1) #correct  = 1 number (between 1 & 1 )
euclidDist(1, 2) #this should be good to go 

function calcLength(a = 2, b = 4; s = 1)
    start = euclidDist(a, b; s)
    return start
end
s = 1
calcLength(2, 4; s)


#----------------------------------

sumInterval(1, 2) # 2 + 1 -1 = 2 #should be 2 #got 3 #ERROR 


v = fillvector(1, 2, [3, 2, 5, 6])
typeof(v) # got 3 (expected 3,2) not passing through upper bound #increase but wich ?

# an index space function 
""" checks whether input arguments a & b are positive , calculates Interval length, anc check if it's positive 
```inputs:
a: lower bound 
b: upper bound 
```
```outputs: 
true:  if Interval length is even, meaning there is only 1 unique middle point 
false: if Interval length is odd, meaning there is an exact fractional middle point, that needs further processing  
```
"""
function isEven(a, b)
    try
        number = -1
        if a > 0 && b > 0
            number = b + a - 1 # calculates Interval length 
            number > 0 && number % 2 == 0 ? true : false   #always exists (if conditions apply)

        else
            throw(error("Unexpected value error"))
        end
    catch UnexpectedError
        @error "Unexpected Error occured" exception = (UnexpectedError, catch_backtrace) #passing function pointer to catch_backtrace 
    end
end


isEven(number) = number > 0 && number % 2 == 0 ? true : false   #always exists (if conditions apply)


function oldSchoolSwap(a, b)
    tmp = b #store b 
    b = a #a in b #a's ready 
    a = tmp
    return a, b
end


sumInterval(a, b) = a > 0 && b > 0 ? abs(a + b) - 1 : -1 #formula: b + a - 1


#index space function 
function middle(a, b) # b  + a -1 
    try
        _sum = copy(sumInterval(a, b)) #    b + a - 1 
        isItEven = copy(iseven(_sum)) # TODO: surround by a copy 
        mid = _sum / 2  #  -1  #Idea: precalculate mid here (_sum /2 ) 
        isWhole = nothing
        below = -1
        above = -1
        if isItEven
            # 1 middle calculate 
            mid = Int(mid)
            isWhole = true
            return mid, mid + 1, isWhole
        elseif !isItEven
            # calculate fractionalMid 
            below = floor(mid)
            above = ceil(mid)
            isWhole = false
            return below, above, isWhole # the differenece is still 1, only way to discriminate is by using isWhole 
        else
            throw(error("Unexpected error occured"))
        end
    catch UnexpectedError
        @error "ERROR: UnexpectedError occured" exception =
            (UnexpectedError, catch_backtrace)
    end
end


function fillvector(a, b, arr; start = 1)
    loopstart = start # if starting index is 1 
    len_ab = euclidDist(a, b) # copy(sumInterval(a, b)) #b - a # i thought b + a - 1 i.e. 1 , 3: 3+1 - 1 =3 #problem here when changing range , problem discovered need distance between 2 values: 
    condition = isPositive(len_ab)
    vector = []
    try
        if condition
            n = len_ab # b - a # wrong range #should be 2  #got 3 # got 2 
            upperbound = copy(n + loopstart) # add 1 if starting index is 1 
            for i = 1:n #stays n (whether starts at 0 or 1) #in every for loop, ensure you're # tried upperbound = n (original + 1) it prints 3 (instead of 2)#infer n is independent of range start 
                pushfirst!(vector, arr[i]) # fills corresponding range with vector values 
            end
        elseif !condition
            return -1
        else
            throw(error("Unexpected error occured"))
        end
    catch UnexpectedError
        @error exception = (UnexpectedError, catch_backtrace)
    end
    return vector
end

fillvector(1, 2, [3, 2, 1, 5]) # working 

fillvector(2, 3, [3, 2, 1, 5])

#----


"""creates an indices between points a & b """
function indexify(a = 1, b = 3; s = 1)

    rangeIndicies = []
    #checks #s is an important input argument, its failure may result in failure of every formula including it 
    #s != 0 || s != 1 ? s = 1 : s = 1 #it's forces s value to take 1 (if it was not set by user to either 0 or 1 )
    try

        if s != 0 || s != 1 # s can either be 0 or 1 , if not provided so 
            s = 1 # set it to 1  #thik 1 move ahead 
            for i ∈ 1:lenA+s-1  # idea= keep fixating starting i at  i=1 #strict condition: needs s=i=1 to work well 
                rangeIndicies = push!(rangeIndicies, i) #println(i) #prints range correctly 1,2,3 (accordingly) 
            end
        else
            throw(error("Unexpected value for s"))
        end
    catch UnexpectedValueError
        @error UnexpectedValueError exception = (UnexpectedValueError, back_trace)
    end
    rangeIndicies
end


res = indexify(1, 2)
typeof(res)
#what's distance between: 2,1 = 2 -1 + 1
function range2vector(range)
    lenA = copy(length(range)) # 3
    next = i + 1
    v = []

    for i ∈ 1:lenA
        if next <= lenA && i <= lenA - 1
            v = push!(v, collect(i:next))
            continue # once reached m gi ti function definition
        else
            @error UnexpectedError exception = (UnexpectedError, back_trace) #throw(error("UnexpectedError"))
        end

    end

    return v
end

res = range2vector(1:3)
typeof(res)
length(res)

#----
# last function 
function indicies2values(v=[], a = [1, 4, 5, 6]) # v can be a pair v[1](1)
    lenV = copy(length(v))
    next = -1
    heap = []
    subheap = []
    for i ∈ 1:lenV
        vi = copy(length(v[i]))
        if vi == 1
            push!(heap, a[v[i][1]])# got index, transofrmed into an array #TODO check isnumeric, isWhole 
            _set = []
        elseif vi > 1 # 2, 3 or more range  #my bread & butter
            for j ∈ 1:vi
                next = j + 1 #warning : potential out of bounds
                if next <= vi
                    genVector = collect(a[j]:a[next])
                    Union!(_set, _set)
                    Union!(subheap, _set)

                    _set = Union!(_set, [[], genVector])
                   
                    _set = Union!(_set, [subheap, genVector]) # j=1,2

                end
            end

        else
            @error UnexpectedError exception = (UnexpectedError, back_trace)
        end
    end
end

function innerloop(a=[3,2,1,4,5],v=[[1,2],[2]])
            vi = [[1, 2], [2]]
            length(vi)
    for j ∈ 1:vi # vi = [[1, 2], [2]]
                next = j + 1 #warning : potential out of bounds
                if next <= vi
                    genVector = collect(a[j]:a[next])
                    Union!(_set, _set)
                    Union!(subheap, _set)

                    _set = Union!(_set, [[], genVector])
                   
                    _set = Union!(_set, [subheap, genVector]) # j=1,2

                end
            end

end
innerloop()


genVector = collect(a[j]:a[next])
Union!(_set, _set)
Union!(subheap, _set)
_set = Union!(_set, [[], genVector])

#credits: @tpapp
#Yes, unfortunately array syntax ([...]) is one of the few places where whitespace has special syntactic significance.
