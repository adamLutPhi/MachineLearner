using Test,  BenchmarkTools, DataStructures
#module Heap end
    
#=
```inputs

n: whole positive natural number > 1 -autoincremented 

|---| --- |
b    b      b
```
 #queue - Datastructures.Deque{Int}()
#=
   i=4 = b ;a=[]; ; n = 1;

if (i < 2 || i > b) # stop
    #crunch in numbers 
    return
else
    #modify then call 
    i = i - (n * h) # 4 -(1*1) = 3 <--- new b /a 
    pt = (i, b) # (3,4); push!()  
    bLookup!(a, b; h = 1)
    #push!()  ∘ ⚇ 


    n += 1

    setindex!(a, 1, i)

end
a=rand(10,1) ; size(a)
@test 
bLookup!()

(1,2)
=#
=#
"""
extractall!''
a Tuple operation; gets back the
"""
function extractall!(tuple::Tuple{Any,Any})
    dt1=nothing  ; dt2 =nothing
    count = 1
    _size =size(collect(minimum(tuple)))
    typeof(minimum(tuple))
    m = _size
    n = length(len)

    for i = 1:m, j = 1:n
        arr[j, i] = tuple[j, i][1]
        tuple[j, i] = tuple[j, i][2]
        # 
        dt1[count] = zip(tuple[j, i][1], tuple[j, i][2])
        dt2[count] = (tuple[j, i][1], tuple[j, i][2])

        count += 1 #auto-Increment 

    end
    return dt1, dt2 #debugging, still 
end 

#--------------------

function bLookup!(a = 1, b = 4; h = 1)

    _a = 1
    _b = 1 #Whatever _b could be picked-up, inside loop it 'll get overwritten 

    q = DataStructures.Deque{Tuple{Int64,Int64}}()
    n = 1

    while _a != b && _b <= b
        #   2 + (2) = 4 = _b 
        _b = _a + (n * h)  # = 3  
        push!(q, (_a, _b)) #1 (1,2) #infer: sub-range [1,2]  (b=4 !isa b[1]=2  (now a[2] = b[1]=2 for next op ) a starts at 2 
        _a = _b # a = 2
        n += 1 # 2 
    end

    return q
end
  
heap =bLookup!()
copiedHeap = deepcopy(heap)
typeof(heap) 
length(heap)
#TODO: Deque -> Heap 
#popfirst!(heap)
#typeof(pop!(heap))
#N = [] #UncommentMe
#collect(pop!(heap)) #UncommentMe
#collect(pop!(heap))[1, 1] #collect creates an Array
#orderedArray = extract_all!(heap) #

dims= deepcopy(size(collect(minimum(heap)))) ;    #= (2,) ; =# #heap = update(heap,1,popped) #<-----Tuple Dimensions 
typeof(dims) #dims isa tuple 
_length = length(len) #Tamas_Papp Tamas_Papp Oct 2017 (2,) is simply syntax for a tuple of 1 element #needed to avoid confusion with (2) == 2.

minHeap = typeof(minimum(heap)) #(1,2)#Tuple{{Int64, Int64}} # each inside value is a Tuple  minHeap isa Tuple

#for i k in enumerate(length) 
#accessing tuple :  2 loops f_vp= 
#dt1 = nothing  #UncommentMe 4 #Debugging
#dt2 = nothing
#funtion iterTuple(tuple=heap, m,n)

typeHeap =typeof(copiedHeap) # Heap isa Deque
#ω ={Union{Nothing,Rational}}# nothing  # [1, 2]Vector{Int64}[2, 3, 4]Vector{Int64}
#this yeilds [1,2,3,4] 
ω = nothing
pts=[] ::Vector{Any} #Array{Any,1} 
#TODO: need for an OrderedSet 
s = OrderedSet() # <: Base.AbstractSet{T} # no method matching append!(::OrderedSet{Any}, ::Int64) #only-human 

push!(s, )
typeof(s) # OrderedSet{Any}
#= MIT 6-006 LECTURE 3: https://ocw.mit.edu/courses/electrical-engineering-and-computer-science/6-006-introduction-to-algorithms-fall-2011/lecture-videos/MIT6_006F11_lec03.pdf
=#

"""OrderedSet

Input: array A[1…n] of numbers. 
Output: permutation B[1…n] of A s.t.
    B[1] ≤ B/[2] ≤ … ≤ B[n] .
    A = [7, 2, 5, 5, 9.6] → B = [2, 5, 5, 7, 9.6]
Q. How can we do it effeciently ? 
#set sorting 
1.Store giant array in my set  # Inefficient (Asymptotic effeciency matters)
 if onject don't exist we add 
2. howdo we implement insert(set)
sortset() # binary searh  ( O(n) = nlogn : n = sortall , logn()  build set , search once )
need for a needlessly confusing algorithm 
3.Search :Iterate from begining of orderedSet , & return         [#worstcase n times   ] 
OrderedSet{Any}
all (A, n)()

3.1.1. buildSet : Reserve n slts in memory  - order n times 
3.1.2. copyall into set 
3.1.3. update (insert/delete : `the Amortized Argument`:if set not allowewd grow Dynamically reserve memory )
3.1.4.find minimum: only algorithm , list students isn't sorted:iterate over every single student 
if guy i'm seeking have a smaller Id : replace Histogram (you guys are More than qualified to Implement !)
(while) set interface is dynamic - keep adding stuff to it ) 
`the Amortized Argument` : on average:  it will take order n times i.e. Expectation (assuming naive)would be the mean E(x)

Note even if it's not dynamic (wanted to replace an existing key )
    -2 numbers exist  
    _"first,there is the existance of a solution, but paying attention to the Details is what matters"_
takeaway: there is a difference between:  
1. the existence of a Solution
2. actually paying attention to the Detail (inside of this thi)

"""
function insert!( s ::OrderedSet{Any},   :: Any{T})
   

end



#TODO: construct a full loop  =#
function getPoints(copiedHeap)
    size = length(copiedHeap)
    pts = []
    α = []
    β =  Array{Int64}(Int64, size)
    ω = []
    i = 1 # must be defined 
    for i in enumerate(size) #  # \Al tuple in Deque[Tuple{Int64, Int64}]  a tuple `Gigantic` one tuple percieved number is 1  [Algorithm allows for an Arbitrary  number of k ]
        # print(typeof(k)) #Tuple{Int64, Int64}Tuple{Int64, Int64}
        #print(k)#Tuple{Int64, Int64}(1, 2)Tuple{Int64, Int64}(2, 4) # the correct Ideal subranges we want #Extravagant! 
        #println(length(k))

        β[i] = α[1]:α[2] #β is a rangeInt
        append!(pts, α[1])
        append!(pts, α[2])
        # ω = append!(w,collect(β))
        append!(ω, collect(β))
        #append!(γ, collect(β)) #no method matching append!(::OrderedSet{Any}, ::Vector{Int64})
        print(typeof(α[1]))
        push!(γ, α[1]) # push!: method no method matching append!(::OrderedSet{Any}, ::Int64)
        push!(γ, α[2])
        print(ω)
        print(γ)
        print(typeof(ω))
        print(typeof(γ))
        #println()
        #println(α[1], α[2]) #UncommentMe
        #=
        for β in length(ℵ) #access a desired subrange α (me: (1,2) or (2,4))
            println(β[1]);#println(typeof(β)) 
        end
        =#
        return ω, γ, pts, β
    end
end # compiles 
ω, γ, pts, β = getPoints(copiedHeap)

    pts


function append!(s ::OrderedSet{Any}, a::Int64)
for i in enumerate length(s)
if i!= length(s)
    if a > s[i] && a< s[i+1] 
    #found the right place  
    return i # value at i 
    #insert a  
    break 

elseif  a == s[i] # same as the one in set  
    break; #skip 
end 




end 
"""
credits to @edubkendo
https://gist.github.com/edubkendo/528d40034fd7037c55ce
"""

function merge_sort(lhs::Array, rhs::)
function merge_sort(lhs::Array, rhs::Array)
    size = length(lhs) + length(rhs)
    retvals = Array(typeof(rhs[1]), size)

    for k = 1:size
        if first(lhs) <= first(rhs)
            retvals[k] = shift!(lhs)
        else
            retvals[k] = shift!(rhs)
        end
        if isempty(lhs)
            return transfer_tail(retvals, rhs, k)
        elseif isempty(rhs)
            return transfer_tail(retvals, lhs, k)
        end
    end
end

#ok
function transfer_tail(vals::Array, tail::Array, count::Int64)
  for k = (count + 1):(length(tail) + count)
    vals[k] = shift!(tail)
  end
  vals
end

#sortmerge
function sortmerge(to_sort::Array)
  len = length(to_sort)
  len <= 1 && return to_sort
  head = to_sort[1:(ceil(len/2))]
  tail = to_sort[(length(head)+1):end]
  merge_sorted(sortmerge(head), sortmerge(tail))
end

x = sortmerge([1,3,2,4])
y = sortmerge([1,2,3,4,5, 99, 54, 33, 21, 67, 88, 9, 39, 76, 88, 89, 100001, 45, 3000, 6,867,8,10])

println("x: $x \n y: $y")

function heap2Range()

for α in heap # ℵ tuple in Deque[Tuple{Int64, Int64}]  a tuple `Gigantic` one tuple percieved number is 1  [Algorithm allows for an Arbitrary  number of k ]
    # print(typeof(k)) #Tuple{Int64, Int64}Tuple{Int64, Int64}
    #print(k)#Tuple{Int64, Int64}(1, 2)Tuple{Int64, Int64}(2, 4) # the correct Ideal subranges we want #Extravagant! 
    #println(length(k))
    β = α[1]:α[2]
    ω = collect(β)
    print(ω)

    print(typeof(ω))
    #println()
    #println(α[1], α[2]) #UncommentMe
    #=
    for β in length(ℵ) #access a desired subrange α (me: (1,2) or (2,4))
        println(β[1]);#println(typeof(β)) 
    end
    =#
end
#return w 
#TODO: Tuple to array operation 

_size = size(collect(minimum(copiedHeap)))  #<-- the tuple 
m = _size

typeof(m) # m is a tuple

m[1] m[1][1];

_size =size(collect(minimum(tuple)))
typeof(minimum(tuple)) 
n = length(m)
count = 1
for i = 1:m, j = 1:n
   dt1[count] =  zip(copiedHeap[j, i][1], copiedHeap[j, i][2])
   dt2[count] =  (copiedHeap[j, i][1], copiedHeap[j, i][2]) 
  #  f_value1[j, i] = copiedHeap[j, i][1]
   # f_value2[j, i] = copiedHeap[j, i][2]
 #  arr1 = dt1
#collect(dt2)
count += 1 #auto-Increment 
end  

typeof(dt1)
typeof(dt2)

for i in enumerate(len)
    res2 =(collect(popfirst!(heap))[1, 1])

 
size(A[1:1, 1]) 
        
#--------------------


#N[[1],:] =typeof(collect(pop!(heap)))# boundsError #UncommentMe
N[[:],] = typeof(collect(pop!(heap))) #possible :Deque must me non-empty # invalid index Colon #LoadError: ArgumentError: invalid index: [Colon()] of type Vector{Colon}
N[:] =typeof(collect(pop!(heap))) # returns a 0-element vector 
resultsize(idxs...) = tuple(Iterators.flatten(size.(idxs))...)

#0element vector{Any} at index [[1]]

# typeof(collect(pop!(heap)))

#typeof( collect(pop!(map(x->x, heap))))

containr = nothing
arr = nothing
for i in enumerate(length(heap))
    containr += [arr collect(pop!(map(x[i]->x, heap)) ) ]
end 
#= how you define behavior is how 
julia will react =#
 
    ranges = []
a = 1; b= 4
#ret = nothing
A=[];B=[];I=[];
#q =(,)::Tuple{UnitRange{Int64}, Tuple{Int64, Int64}}, ::Type{Any} # Any #DataStructures.Deque{UnitRange{Int64}}()


#insert!()

A = collect( popfirst!(heap))
    
@inbounds for (n,i) in enumerate(tmp)
        b[n] = i+1
    end 

a,b = popfirst!(heap)

function extractfromHeap(heap)
    A = [] #1
    B = []
    I = []
    p=1 ;a=1;b=1;
    for p in enumerate(length(heap))
        a, b = popfirst!(heap)
        #ret = [ret, a:b]
        #push!(A, a)                                                                                                                                                                                                                                                                                                                                                        
        #push!(B, b)
        insert!(A, a, p)        #=@inbounds=#
        insert!(B, b, p)        #=@inbounds=#
        insert!(I, p, p)        #=@inbounds=#
    end
    # A = [a] #1
    # B = [b]
    # I = [p]
    #   (A,B)[i]  = (a,b)
    #i += 1
    #(A[i],B[i]) = (a,b)
    #   (A[i],B[i],I[i]) = a,b,i
    # B[i] = b ;
    #  I[i] = i
    #   a[i],B[i],I[i] = a,b,i            #push!((a:b,i),q)
    return A, B, I

end


#ret[1]
#ret[2]
    #ranges  = [ ranges ,a:b] 
    #range1 = ret1:ret2 
    #ret3, ret3 = popfirst!(heap)

#range2 =   
# ret2
#ret1:ret2

#--------------------
module Deque 
function getIndex!(Q::Deque{UnitRange{Int64}}, idx::Int64)
    ret = getQueue(Q, idx)
end 

function getindex!(Q::Deque{Tuple{Int64, Int64}},idx::Int64)
    ret = nothing
    for i in enumerate(size(Q))
        if i isa idx 
        ret = pop!(Q)
        end
    end 
    return ret 
end 
end 
#=--- testing Area
getindex!(heap,1)
i = 4  #... i = 1 ; b[1] =4 
a[1]= b[1] - (n[1]*h) = 

b[2]

b[1]  # setindex!(b,1,)
b[1] =  1 + (1 * 1 )  = 2  #infer: sub-range [1,2]  (b=4 !isa b[1]=2  (now a[2] = b[1]=2 for next op ) a starts at 2 
b[2] = a[2] + (n[2] * h) = 2 + (2 * 1) 

b[2] = a[2] - (n[2] * h) = 2 -  (2 * 1) 
#=
Base.setindex!
=# #Function
setindex!(collection, value, key...)
Store the given value at the given key or index within a collection. The syntax a[i,j,...] = x is converted by the compiler to (setindex!(a, x, i, j, ...); x).
=#

function  findSubrange(a,b=4;n= 1)
i=n;
#a=[]; _b=[]; 
#_n = 1;
 _b =1; _a =1;  

if _b isa b #reached the end 
    _a = a  #
    return

    if !(_b isa b) #
        _a + (n[1] * h)
        i += 1

        while !(_b isa b)
            _b = _a + (_n * h)
            #update _a, _b
            i = 1:_b = _a + (i * h) # = 1 + (1 * 1) = 2  #infer: sub-range [1,2]  (b=4 !isa b[1]=2  (now a[2] = b[1]=2 for next op ) a starts at 2 
            i += 1
            findSubrange(_a, _b, n = i)
        end

    end

end

#--------------------
