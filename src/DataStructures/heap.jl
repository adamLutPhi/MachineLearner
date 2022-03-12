using Test, BenchmarkTools# , DataStructures # redundant - for now 
#module Heap end
#=
```inputs
n: whole positive natural number > 1 -autoincremented 
|---| --- |
b    b     b
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
    #push!() # ∘ ⚇ 

    n += 1
    setindex!(a, 1, i)
end
a=rand(10,1) ; size(a)
@test 
bLookup!()

(1,2)
=#
=#
#= this is coded to work with DataStructures.Deque
"""
extractall!
a Tuple operation; gets back the
"""
Base.@propagate_inbounds function extractall!(tuple::Tuple{Any,Any}) #compiles 
    dt1 = nothing
    dt2 = nothing
    count = 1
    _size = size(collect((tuple)))
    typeof(minimum(tuple))
    n = _size    # length(size(collect(minimum((tuple))))) #if DataStructure.Deque was enforced 
    m = _size
    #println(typeof(tuple[n, m])) # for a Deque test 
    @inbounds for i = 1:m, j = 1:n
        #typeof(tuple[j, i])
        arr[j, i] = tuple[j, i][1]
        tuple[j, i] = tuple[j, i][2]
        dt1[count] = zip(tuple[j, i][1], tuple[j, i][2]) #with zip
        dt2[count] = (tuple[j, i][1], tuple[j, i][2])    #no zip 
        count += 1 #auto-Increment 
    end

    return dt1, dt2 #debugging, still 
end
=#
tup = ((1, 2); (2, 4))
typeof(tup)
#@btime dt1, dt2 = extractall!(tup) # vector, use []
#@time dt1, dt2 = extractall!(((1, 2); (2, 4))) # vector, use []
#extractall!()
#--------------------
#=vector {any} -> tuple 
Input: Tuple length N must be pre-defined
Output: 
=#

Vector2TupleFloat64(N) = Tuple(Float64(x) for x in N)

@btime Float64.(tuple($N...))
#  840.075 ns (4 allocations: 912 bytes)
@btime Float64.(Tuple($N))
#  895.109 ns (5 allocations: 1.22 KiB)

vector2TupleFloat64(N) = @btime Tuple(Float64(x) for x in N); # best loop Optimized for 
# @btime Tuple(1.0N);   #this line is not optimized 
#  20.139 μs (159 allocations: 4.16 KiB) and on 1.0

@btime Tuple(Float64(x) for x in N); # faster, most Optimal for allocation
#  6.836 μs (57 allocations: 1.42 KiB)

#@btime Tuple(1.0N); #not optimized
#  2.660 μs (90 allocations: 2.31 KiB) # not at all
#----------
#working 
#Tuple2Vector 
Tuple2Vector(x) = collect(Iterators.flatten(x))
#code starts here:
Base.@propagate_inbounds function bLookup!(a = 1, b = 4; h = 1)  #optimal #rapid: median 71.5 ns 

    α = 1
    β = 1 #Whatever _b could be picked-up, inside loop it 'll get overwritten 
    q = [] #DataStructures.Deque{Tuple{Int64,Int64}}()
    n = 1

    while α != b && β <= b # adding inbounds slightly fastens the total process  
        #   2 + (2) = 4 = _b 
        β = α + (n * h)  # = 3  
        push!(q, (α, β)) #1 (1,2) #infer: sub-range [1,2]  #Deque (b=4 !isa b[1]=2  (now a[2] = b[1]=2 for next op ) a starts at 2 
        α = β # fetch next value a = 2
        n += 1 # 2 
    end

    return q
end

#@time
#-----
copiedHeap = []::Any
function linearSort(heap)
    for i in size(heap) #compiles for a vector 
        if i > 1 #this is a must 
            if heap[i] < heap[i-1] #check code
                heap[i], heap[i-1] = heap[i-1], heap[i] #swap 
            end
            arr[i] = copiedHeap[i]
        end #arr[i] = copiedHeap[i] copy code
    end
    return heap
end

"""checks size (for the moment)
if length isa Even , do something 
Otherwise, if it's odd, throws an errror 
"""
function biSectSort(heap) #fixed (this only checks size)
    _size = copy(length(heap))
    _size -= 1 #decrease always a 1 from the 'theoretical' length (to fit in the `structure `)
    try
        if _size == length(heap) % 2 == 0 # ? #= add to s : =#   this checks size # why were you throwing error , irresponsibly?
        #do something useful #like, sor, linearly 
        else #on the else, ok <---- runs this 
            throw(error("Debugging: this throws an error Unexpected Error found "))
        end
    catch UnexpectedError # <---- runs this 
        @error "ERROR: UnexpectedError Found-error thrown successfully " exception =
            (UnexpectedError, catch_backtrace())
    end
end
biSectSort(copiedHeap) #runs # biSectSort (generic function with 1 method) #if throws your error, then it compies file 

try #requires t possible error: define t first 

    # for i in size(heap) #compiles for a vector 

    #=find middle 
    -isEven (is there a generalization)#review: generalizationnot now 
    -- check middle (Q1. How? ) #Q2. isEfficient?   
    lsize(heap) % 2  === 0 
    #check if size(heap)/2 is even → d =#
    _size = length(copiedHeap) - 1 # -1 #indicates #ERROR (unhandled ) 
    if _size % 2 == 0  # TODO: odd (store in a  proper `DataStructure`)
    #do something call function 

    elseif _size % 2 != 0
        #throw an error exception 
        throw(error("Size Error "))
    end
catch SizeError   #Name the Error: any arbitrary error name (memorizable) 
    @error "ERROR: error was unhandeled" exception = (UnexpectedError, catch_backtrace())
end #fine! 
#SizeError "ERROR: error was unhandeled" exception 
#=catch error as an exception  (via  catch_backtrace)#
print error 
end
end 
turns out, it's more than a check of Evenity...=#
#-----
@benchmark heap = bLookup!() # get subranges #Returns Deque -> Dictionary  @test(E):0.000003 seconds (4 allocations: 192 bytes) @btime =  67.551 ns (4 allocations: 192 bytes) 

"""

BenchmarkTools.Trial: 10000 samples with 977 evaluations.
 Range (min … max):   66.121 ns …  11.737 μs  ┊ GC (min … max):  0.00% … 98.61%
 Time  (median):      76.254 ns               ┊ GC (median):     0.00%
 Time  (mean ± σ):   131.199 ns ± 420.001 ns  ┊ GC (mean ± σ):  19.74% ±  6.19%

  ▆█▆▄▄▃▃▃▃▂▁▂▁▂▂▃▄▃▃▂▂▁▁▁ ▁ ▁       ▁ ▁ ▁                      ▂
  ███████████████████████████████▇▇██████████▆▇▇▇▆▆▇▅▆▅▅▅▅▄▅▄▄▃ █
  66.1 ns       Histogram: log(frequency) by time        318 ns <

"""
heap = Blookup.bLookup!()
copiedHeap = deepcopy(heap) # 65.169 ns (4 allocations: 192 bytes)   #65.881 ns (4 allocations: 192 bytes) #0.000003 seconds (4 allocations: 192 bytes)
#=   memory estimate:  192 bytes
  allocs estimate:  4
  --------------
  minimum time:     65.138 ns (0.00% GC)
  median time:      72.885 ns (0.00% GC)
  mean time:        127.858 ns (19.01% GC)
  maximum time:     8.332 μs (98.91% GC) =#
arr = []
#--- 

@benchmark heap = linearSort(heap)
arr
typeof(heap)   # was a Deque(doublyqueue) -> Dict (not a  Tuple)

length(heap)
#TODO: Deque -> Heap 
#popfirst!(heap)
#typeof(pop!(heap))
#N = [] #UncommentMe
#collect(pop!(heap)) #UncommentMe
#collect(pop!(heap))[1, 1] #collect creates an Array
#orderedArray = extract_all!(heap) #
t = maximum(heap)
t = minimum(heap)
#t = popfirst!(heap)
t[1][1]
unitrange = t[1][1]:t[2][1]
typeof((t[1][1], t[2][1]))
_tuple = (t[1][1], t[2][1])

#tuple -to-> vector

vector = collect(Iterators.flatten(_tuple))

collect(Iterators.flatten(x)) #OR


[x[j] for x in x for j in eachindex(x)]

#---
#for i in heap

dims = deepcopy(size(collect(minimum(heap)))); #heap = update(heap,1,popped) #<-----Tuple Dimensions 
println(dims)
typeof(dims) #dims isa tuple (if `parent` was a Deque) #Type Int64 (if `it` were ) 
dims[1];
dims[1][2] #BoundsError (from [2])

_length = length(dims) #Tamas_Papp Tamas_Papp Oct 2017 (2,) is simply syntax for a tuple of 1 element #needed to avoid confusion with (2) == 2.

minHeap = typeof(minimum(heap)) #(1,2)#Tuple{{Int64, Int64}} # each inside value is a Tuple  minHeap isa Tuple

#for i k in enumerate(length) 
#accessing tuple :  2 loops f_vp= 
#dt1 = nothing  #UncommentMe 4 #Debugging
#dt2 = nothing
#funtion iterTuple(tuple=heap, m,n)

typeHeap = typeof(copiedHeap) # Heap isa Deque
#ω ={Union{Nothing,Rational}}# nothing  # [1, 2]Vector{Int64}[2, 3, 4]Vector{Int64}
#this yeilds [1,2,3,4] 

pts = []::Vector{Any} #Array{Any,1} 
#= ---credits to @trakofon
https://discourse.julialang.org/t/converting-vector-any-to-tuple-of-floats/13714/7 =#
#_first = popfirst!(copiedHeap)
copiedHeap = deepcopy(heap)
typeof(copiedHeap)
size(copiedHeap)
#for i in enumerate(size(copiedHeap)) # length(copiedHeap) length for Tuple alone  #UncommentMe
#copiedHeap = deepcopy(heap) 
typeof(heap)  # Deque -> Dict -> Tuple
length(heap)


dims = deepcopy(size(collect(minimum(heap)))) # == size(copiedHeap)
ω = []
copiedHeap = deepcopy(heap)
try
    while true
        tmp = popfirst!(copiedHeap)
        ω = pushfirst!(ω, tmp)#, 1) #removes the 1's monotonicity 
    end
catch #ErrorException
    #continue
    print(ω) # Any[(2, 4), 1, (1, 2), 1, (2, 4), 1, (1, 2), 1] frankly the weirdest (1's monotonicity should be removable, first)
end
#=======Testing Area Experimental beyond this line 
#print(ω) #this is tuple 
#tuple to vector 
w = collect(Iterators.flatten(ω))

typeof(collect(_first))
#------------------------------------------------------------------------

# VectorArray = []
#TupleArray = Tuple(Float64(x) for x in VectorArray);
_firstTuple = Tuple(Float64(x) for x in _first); #Float64.(tuple("$_first)) Tuple(Float64(x) for x in N);
typeof(_firstTuple)
_firstTuple
insert!(TupleArray, _firstTuple, size(TupleArray))
typeof(pts)
push!(collect((_first)), pts)
α = size(collect(_first))

#------------------------------------------------------------------------
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
2. how do we implement insert(set)
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
_size = sizehint!(s, 1);
println(_size);
last = pop!(s, 1)

#=
Base.@propagate_inbounds function insert!(s::OrderedSet{Any}, ::Any{T})

end
=#

Base.@propagate_inbounds function insert!(s::OrderedSet{Any}, ::Any{T}) where {T::Any}
    #1. check size 
    _#size = sizehint!(s)
    #look for safety with try (no matter the size of s ) 
    canLah = true
    while canLah
        try
            last = pop!(s, 1) #reminiscent of the tower of hanoi 
        #checkva
        catch #can't pop anymore 
            canLah = false
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
_size == Size ? isequal = true : isequal = false
println(isequal)
#TODO: construct a full loop  & iterate ( ort) =#

Base.@propagate_inbounds function getPoints(copiedHeap)
    _size = size(collect(minimum(copiedHeap)))  #<-- the tuple 
    #m = _size
    #typeof(m) # m is a tuple
    #m[1]m[1][1]

    Size = length(copiedHeap)

    pts = []
    α = []
    β = []  #  Array{Int64}(Int64, size)
    ω = []
    i = 1 # must be defined 
    γ = nothing #[]
    α = size(collect(minimum(copiedHeap)))  #<-- the tuple  
    typeof(α)
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
        typeof(α)
        #m = _size 
        #typeof(m) # m i a  
        #m[1]m[1][1] ok
        m = copy(α) #the intent #deepcopy(α)

        @inbounds β[i] = (m[1]:m[2]) # a tuple # gets rangeInt  #without Deque, errors out 

        push!(pts, m[1]) #ok you mean β[i] ? 
        push(pts, m[2]) #ok   or pushfirst! 
        #  ω[i] = β[i] #collect(β))
        push(ω, collect(β[i]))
        #append!(γ, collect(β)) #no method matching append!(::OrderedSet{Any}, ::Vector{Int64})#sloved 
        #print(typeof(α[1]))
        # push!(γ, m[1]) # push: method no method matching append!(::OrderedSet{Any}, ::Int64)
        # push!(γ, m[2]) #or pushfirst! 
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
        return ω, γ, β #, pts #, α[1]:α[2] #  debugging values
    end
end # no error  
ω, γ, β = getPoints(copiedHeap) #TODO: re-view

function append!(s ::OrderedSet{Any}, a::Int64) #use ] OrderedCollections (for OrderedCollections.jl) #q. why Unordered Structure?  #OrderedSet not defined #review#1: use of outside code 
return 
end 
#=
function append!(s ::OrderedSet{Any}, a::Int64) #q. why Unordered Structure? 

@inbounds for i in enumerate length(s)
    @inbounds if i!= length(s)
        @inbounds if a > s[i] && a< s[i+1] 
    #found the right place  
                    return i # value at i 
                    #insert a  
                    #break  #if it returns, no need to break

elseif  a == s[i] # same as the one in set  
    break; #skip 
end 
#---- Algorithms 

end 
"""merge sort (with Difive & Conquer Strategy) #the reason behind divideConquer 
credits to @edubkendo
https://gist.github.com/edubkendo/528d40034fd7037c55ce
"""

function mergeSort(lhs::Array, rhs::Array) 
    size = length(lhs) + length(rhs)
    retvals = [] #Array(Type(lhs), size)

@inbounds    for k = 1:size
@inbounds        if first(lhs) <= first(rhs)
        @inline    retvals[k] = shift!(lhs)
        else
        @inline    retvals[k] = shift!(rhs)
        end
        if isempty(lhs) #Divide & Conquer Strategy
            return transfer_tail(retvals, rhs, k)
        elseif isempty(rhs)
            return transfer_tail(retvals, lhs, k)
        end
    end
end

#ok
function transfer_tail(vals::Array, tail::Array, count::Int64) #TODO: #check_Utility
@inbounds  for k = (count + 1):(length(tail) + count)
@inbounds    vals[k] = shift!(tail)
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

@inline x = sortmerge([1,3,2,4]) #tryout 
@inine y = sortmerge([1,2,3,4,5, 99, 54, 33, 21, 67, 88, 9, 39, 76, 88, 89, 100001, 45, 3000, 6,867,8,10]) #tryout

println("x: $x \n y: $y")

function heap2Range()

@inbounds for α in heap # α tuple in Deque[Tuple{Int64, Int64}]  a tuple `Gigantic` one tuple percieved number is 1  [Algorithm allows for an Arbitrary  number of k ]
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
    for β in length(α) #access a desired subrange α (me: (1,2) or (2,4))
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
@inbounds for i = 1:m, j = 1:n
    @inline  dt1[count] =  collect(zip(copiedHeap[j, i][1], copiedHeap[j, i][2]))
    @inline  dt2[count] =  (copiedHeap[j, i][1], copiedHeap[j, i][2]) 
  #  f_value1[j, i] = copiedHeap[j, i][1]
   # f_value2[j, i] = copiedHeap[j, i][2]
 #  arr1 = dt1
#collect(dt2)
@inline count += 1 #auto-Increment 
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
@inbounds for i in enumerate(length(heap))
    @inline  containr += [arr collect(pop!(map(x[i]->x, heap)) ) ]
end 
#=" how you define behavior is how 
    julia will react "=#

ranges = []
a = 1; b= 4
#ret = nothing
A=[];B=[] #;I=[];
#q =(,)::Tuple{UnitRange{Int64}, Tuple{Int64, Int64}}, ::Type{Any} # Any #DataStructures.Deque{UnitRange{Int64}}()

#insert!()

A = collect( popfirst!(heap))

@inbounds for (n,i) in enumerate(tmp)
    @inline   b[n] = i+1
end 

a,b = popfirst!(heap)

function extractfromHeap(heap)
    A = [] #1
    B = []
    #I = []
    p=1 ;a=1;b=1;
@inbounds  for p in enumerate(length(heap))
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
function getIndex!(Q::Tuple{UnitRange{Int64}}, idx::Int64)
    ret = getQueue(Q, idx)
end 

function getindex!(Q::Tuple{Tuple{Int64, Int64}},idx::Int64)
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
=#
"""trying to recursively find a subrage *writes down a while!* """  
function  findSubrange2(a=1,b=4,n= 1) #requires revision #review#1: try to remove ; from the arguuments 

    i=copy(n) #copies n 

    #a=[]; _b=[]
    #_n = 1 #review#1:instead of writing here, you are passing it in the argument - as an optional parameter , thus if user forgets it , you expect it to run 
    _a =1  
    _b =1

    if _b ==b # isa b #reached the end #review#1:comment:1stif
    _a = a  #
    return
    #end #end-if  
   #end #end-function 

    if !(_b isa b) #review#1:comment:2ndif
        _a + (n[1] * h)
        i += 1

        while !(_b isa b)# use of while 
            _b = _a + (_n * h)
            #update _a, _b
            i = 1:_b = _a + (i * h) # = 1 + (1 * 1) = 2  #infers: sub-range [1,2]  (b=4 !isa b[1]=2  (now a[2] = b[1]=2 for next op ) a starts at 2 
            i += 1
            findSubrange(_a, _b, n = i)
        end #end-while

     #end#end-if
    end ##-end-if error:syntax "1" - not a `valid argument name` #TODO: check name 
end #incomplete function #error 

function whilefunction(a=_a,b=_b) #error at 706
    while _b  != b #isa b)#review#1:  use of while 
         _b = _a + (_n * h)
        #update _a, _b
        i = 1:_b = _a + (i * h) # = 1 + (1 * 1) = 2  #infers: sub-range [1,2]  (b=4 !isa b[1]=2  (now a[2] = b[1]=2 for next op ) a starts at 2 
        i += 1
        findSubrange(_a, _b, n = i)
    end #end-while
end
#--------------------=# #was erroring, because of `unterminatedError`!  -file formation complete 
