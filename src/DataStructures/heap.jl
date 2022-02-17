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
function extractall!(tuple::Tuple{Any,Any}) #compiles 
    dt1=nothing  ; dt2 =nothing
    count = 1
    _size =size(collect(minimum(tuple)))
    typeof(minimum(tuple))
    m = _size
    n = length(len)
 typeof(tuple[j, i])
   @inbounds for i = 1:m, j = 1:n
        typeof(tuple[j, i])
        arr[j, i] = tuple[j, i][1]
        tuple[j, i] = tuple[j, i][2]
        dt1[count] = zip(tuple[j, i][1], tuple[j, i][2])
        dt2[count] = (tuple[j, i][1], tuple[j, i][2])
        count += 1 #auto-Increment 

    end
    return dt1, dt2 #debugging, still 
end 

#--------------------
#=vector {any} -> tuple 
Input: Tuple length N must be pre-defined
Output: 
=#
Vector2TupleFloat64(N)=Tuple(Float64(x) for x in N)

 @btime Float64.(tuple($N...))
#  840.075 ns (4 allocations: 912 bytes)
@btime Float64.(Tuple($N))
#  895.109 ns (5 allocations: 1.22 KiB)
 
vector2TupleFloat64(N) = @btime Tuple(Float64(x) for x in N); # best loop Optimized for 

Optimizedfunction(x) = (Int64(x) for x in N) #tuple  

#  5.386 μs (65 allocations: 1.98 KiB)

 @btime Tuple(1.0N);
#  20.139 μs (159 allocations: 4.16 KiB) and on 1.0

 @btime Tuple(Float64(x) for x in N);
#  6.836 μs (57 allocations: 1.42 KiB)

 @btime Tuple(1.0N); 
#  2.660 μs (90 allocations: 2.31 KiB) # not at all
#----------
#Tuple2Vector 
Tuple2Vector(x) = collect(Iterators.flatten(x)) 

function bLookup!(a = 1, b = 4; h = 1)

    α = 1
    β = 1 #Whatever _b could be picked-up, inside loop it 'll get overwritten 
    q = DataStructures.Deque{Tuple{Int64,Int64}}()
    n = 1

    while α != b && _b <= b
        #   2 + (2) = 4 = _b 
        β = α + (n * h)  # = 3  
        push!(q, (α, β)) #1 (1,2) #infer: sub-range [1,2]  (b=4 !isa b[1]=2  (now a[2] = b[1]=2 for next op ) a starts at 2 
        α = β # Swap a = 2
        n += 1 # 2 
    end

    return q
end
  
heap =bLookup!() # get subranges #Returns Deque -> Dictionary 

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
t = minimum(heap)
t = popfirst!(heap)
typeof((t[1][1], t[2][1]))
#tuple to vector

dims= deepcopy(size(collect(minimum(heap)))) ;    #= (2,) ; =# #heap = update(heap,1,popped) #<-----Tuple Dimensions 
println(dims)
typeof(dims) #dims isa tuple 
dims[1]; dims[1][2]
_length = length(dims) #Tamas_Papp Tamas_Papp Oct 2017 (2,) is simply syntax for a tuple of 1 element #needed to avoid confusion with (2) == 2.

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
#= ---credits to @trakofon
https://discourse.julialang.org/t/converting-vector-any-to-tuple-of-floats/13714/7 =#
_first = popfirst!(copiedHeap)
typeof(collect(_first))
 VectorArray = []
TupleArray = Tuple(Float64(x) for x in VectorArray);
_firstTuple = Tuple(Float64(x) for x in _first); #Float64.(tuple("$_first)) Tuple(Float64(x) for x in N);
typeof(_firstTuple)
 _firstTuple
 insert!(TupleArray,_firstTuple,size(TupleArray))
typeof(pts)
push!(collect(( _first)),pts)
α = size(collect(_first))

#--- 
m = deepcopy(α)
length(m)
m[2][1]        
m[0]
#m2 = deepcopy()
β[i] = (m[1]:m[2]) # get rangeInt 
    
        push!(pts, m[1])
        push(pts, m[2]) #ok 
        ω[i] = push(ω, collect(β))
        push(ω, collect(β))
#TODO: need for an OrderedSet 
#----
s = OrderedSet() # <: Base.AbstractSet{T} # no method matching append!(::OrderedSet{Any}, ::Int64)
#Q1. Sort an OrderedSet (Ascending) 
#Q2.

#push!(s, ) #what's its continuation 
typeof(s) # OrderedSet{Any}

"""OrderedSet
MIT 6-006 LECTURE 3: https://ocw.mit.edu/courses/electrical-engineering-and-computer-science/6-006-introduction-to-algorithms-fall-2011/lecture-videos/MIT6_006F11_lec03.pdf


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
3.Search :Iterate from begining of orderedSet , & return         [#worstcase n times (if found at last element)  ] 
    OrderedSet{Any}
    all (A, n)()
Strategy:
3.1.1. BuildSet : Reserve n slts in memory  - order n times 
3.1.2. Copyall into set 
3.1.3. Update (insert/delete : `the Amortized Argument`:if `set` is not allowed, Grow Dynamically - Reserve memory )
3.1.4. Find minimum: only algorithm , list `things` isn't sorted:iterate over every single One  
e.g. If sth I'm seeking has a smaller Id (Index) : Replace Histogram (you guys are More than `Qualified` to Implement !)
(while) Set Interface is Dynamic - keep adding stuff to it ) 
`the Amortized Argument` : on average: (How much) it will take order n times i.e. Expectation (assuming naive) 
would be the mean E(x)

Note: even if it's not dynamic (i.e. to replace an existing key (Index))
    -2 numbers exist  
    _"first,there is the existance of a solution, but paying attention to the Details is what really matters"_
takeaway: there is a difference between:  
1. the existence of a Solution
2. actually paying attention to the Detail (inside of it)

situation :
real world semi-blackbox using only the following 6 functions: 
 
sizehint!(s::OrderedSet, sz::Integer) = (sizehint!(s.dict, sz); s) #capacity reservation for improving Optimization
in(x, s::OrderedSet) = haskey(s.dict, x)

push!(s::OrderedSet, x) = (s.dict[x] = nothing; s)
pop!(s::OrderedSet, x) = (pop!(s.dict, x); x)
pop!(s::OrderedSet, x, deflt) = pop!(s.dict, x, deflt) == deflt ? deflt : x
delete!(s::OrderedSet, x) = (delete!(s.dict, x); s)

note: no push first nor pop first ! 
""" 
#--- tuple -to-> vector 

# Tuple -to -> Vect 
[[Vector{Float64}(undef, 4) for _ = 1:5] for _ = 1:6]
#5-element Array{Array{Array{Float64,1},1},1}:

struct Run
  vector_result::Vector{Float64}
  matrix_result::Matrix{Float64}
end

struct Simulation
  #name::String
  parameters
  runs::Vector{Run}
end

s = Simulation(some_parameters, Vector{Run}())
#---- end
_size = sizehint!(s,1); println(_size)
last = pop!(s, 1)

function insert!(s::OrderedSet{Any}, ::Any{T})

end


function insert!(s::OrderedSet{Any}, ::Any{T}) where T::Any
    #1. check size 
    _#size = sizehint!(s)
    #look for safety with try (no matter the size of s ) 
    canLah = true 
    while canLah  
    try
        last = pop!(s, 1) #reminiscent of the tower of hanoi 
        #checkva
    catch #can't pop anymore 
        canLah  = false 
        break
    end
end 
  
end

#--- 
_size = size(collect(minimum(copiedHeap)))  #<-- the tuple 
    #m = _size
    #typeof(m) # m is a tuple
    #m[1]m[1][1]

    Size = length(copiedHeap) # the true number looking for
    
    isequal = nothing
    _size == Size ? isequal =  true  : isequal=false
    println(isequal)
#TODO: construct a full loop  =#


function getPoints(copiedHeap)
    _size = size(collect(minimum(copiedHeap)))  #<-- the tuple 
    #m = _size
    #typeof(m) # m is a tuple
    #m[1]m[1][1]

    Size = length(copiedHeap)
    
    pts = []
    α = []
    β=[]  #  Array{Int64}(Int64, size)
    ω = []
    i = 1 # must be defined 
    γ= nothing #[]
    # the Strategy:
    for i in enumerate(Size) #  # \A tuple in Deque[Tuple{Int64, Int64}]'s   thing isa `Humongous` [Algorithm allows for an Arbitrary  number of k ]
        # print(typeof(k)) #Tuple{Int64, Int64}Tuple{Int64, Int64}
        #print(k)#Tuple{Int64, Int64}(1, 2)Tuple{Int64, Int64}(2, 4) # the correct Ideal subranges we want #Extravagant! 
        #println(length(k))
        # Ideally,    β[i] = α[1]:α[2] #β is a rangeInt    #UncommentMe
        #1. find m 
        #m = size(collect(minimum(copiedHeap)))
        #2. pop(first),  if possible
        α = size(collect(popfirst!(copiedHeap)))  #<-- the tuple  
        #m = _size 
        #typeof(m) # m i a  
        #m[1]m[1][1] ok
        m = deepcopy(α)
        #m2 = deepcopy()
        β[i] = (m[1]:m[2]) # get rangeInt 
    
        push!(pts, m[1])
        push(pts, m[2]) #ok 
        ω[i] = push(ω, collect(β))
        push(ω, collect(β))
        #append!(γ, collect(β)) #no method matching append!(::OrderedSet{Any}, ::Vector{Int64})#sloved 
        #print(typeof(α[1]))
        push!(γ, m[1]) # push!: method no method matching append!(::OrderedSet{Any}, ::Int64)
        push!(γ, m[2])
        #print(ω)
        #print(γ)
        #print(typeof(ω))
        #print(typeof(γ))
        #println()
        #println(α[1], α[2]) #UncommentMe
        #=
        for β in length() #access a desired subrange α (me: (1,2) or (2,4))
            println(β[1]);#println(typeof(β)) 
        end
        =#
        return ω, γ, β, pts #, α[1]:α[2] # values for debugging ...
    end
end # compiles 
ω, γ, β, pts = getPoints(copiedHeap)




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
#---- Algorithms 

end 
"""merge sort (with Difive & Conquer Strategy)
credits to @edubkendo
https://gist.github.com/edubkendo/528d40034fd7037c55ce
"""

function mergeSort(lhs::Array, rhs::Array)
    size = length(lhs) + length(rhs)
    retvals = [] #Array(Type(lhs), size)

    for k = 1:size
        if first(lhs) <= first(rhs)
            retvals[k] = shift!(lhs)
        else
            retvals[k] = shift!(rhs)
        end
        if isempty(lhs) #Divide & Conquer Strategy
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

#m[1] m[1][1];
dt1 = []; dt2 = [];
_size =size(collect(minimum(tuple)))
typeof(minimum(tuple)) 
n = length(m)
count = 1
for i = 1:m, j = 1:n
   dt1[count] =  collect(zip(copiedHeap[j, i][1], copiedHeap[j, i][2]))
   dt2[count] =  (copiedHeap[j, i][1], copiedHeap[j, i][2]) 
  #  f_value1[j, i] = copiedHeap[j, i][1]
   # f_value2[j, i] = copiedHeap[j, i][2]
 #  arr1 = dt1
#collect(dt2)
count += 1 #auto-Increment 
end  

#typeof(dt1)
#typeof(dt2)
res2 = nothing
for i in enumerate(len)
    res2 =(collect(zip((popfirst!(heap))))[1, 1])

end
println(res2); println(typeof(res2)); 
size(A[1:1, 1]) 
        
#--------------------
#arrays indexing rewind
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
    #I = []
    p=1 ;a=1;b=1;
    for p in enumerate(length(heap))
        a, b = popfirst!(heap)
        #ret = [ret, a:b]
        #push!(A, a)                                                                                                                                                                                                                                                                                                                                                        
        #push!(B, b)

    A = @inline InsertionSort(collect(zip(a,b,p)))
    B = @inline collect(zip(a:b,p))
    # insert!(A, a, p)        #=@inbounds=#
       # insert!(B, b, p)        #=@inbounds=#
       # insert!(I, p, p)        #=@inbounds=#
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
    return A, B #for Debugging
A,B = extractfromHeap(copiedHeap)

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
