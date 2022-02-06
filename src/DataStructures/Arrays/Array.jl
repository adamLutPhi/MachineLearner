"""
Credits:

 Tim Holy - JuliaCon 2016 


"""

"""

trivial define array structur that does new things for you
"""
#--- is there overhead for this ?
using BenchmarkTools

function mysum(A)
    s = zeros(eltype(A))
    @inbounds for a in A
        s += a
    end
    s
end


A = rand(10^4, 10^4)
B = Mappedarray(identity, A)

@benchmark
@time
@btime mysum(A)
@Benchmarking mysum(B)

"""
julia has the capabilities, that allows you to handle
Data, in a reasonably efficient fashion

Before Julia: 

Each experiment needs a 4D (Large) Array

Useful things Julia does to support arrays
1. Memory mapping 
can't hold any theese in Ram, 

present it as a view in a single memory

transformation s 

range compression 

16 bit cameras , needs scaling - intensity-scaling: 

2. intensity scling 
i.e. 16 bit cameras , needs scaling - intensity-scaling: 
How:
before Julia 
2.1.1 find gui viewer offers scaling and other features you ned 
2.1.1 give up 

2.2.1 Find blank drive 
2.2.2 Format it 
2.2.3 Write script saves intensity=scale images to disk (wait serveral hours)
2.2.4 Load the scaled imge into your viewer

That's the Bottleneck, very irritating (in early days)
In Julia:
Compute represent 
Virtual image "view" (of underlying data )

imgsc = mappedarray(sqrt, img ) 

the key here: "we don't actually perform the computation"
we signal that  we want (to perform this computation)
whn perform it, we  signal it into a Dumb Viewer

why Dumb? it doesn't know how to do transformations(i.e. Scaling)
[the kicker: but it might have (some) other features, we want]
why do a dumb viewer? (3 reasons)

1.Easy 
2.Simple
3.Composable 
(Hype of) workflow 

make this operation v. fast (microseconds)

1.main point 



imgsc = mappedarray(sqrt, img)
"""

"""
transformations are a
#1: vectorized functions -Heratige of programming languages operates element-wise on the array 

amounts: Viewd as  not desirable 
    -Explicit mapping function  (over the elements)
    --vectorized functions
"""

"""
Gregory(scotland Yard detective):
Is theree any other point to which you would wish to 

which you wish to draw my attention 

Holmes: To the curious incident of the dog in the night-time 

Gregory: th dog did nothing in the night-time 
Holmes: that was the curious incident
- Silver Blaze - conan Doyle

"""

"""

Meaning#1 
the best optimization is 
not Doing the Computation 

Best computation (Strategy) 
is by not doing the Computation 

useful point to the things tim's lab does  
i.e. performing element-wise computations on th array 

how should we write these types of transformations? 
on option: a Heratige from (serveral) other programming languages 
1.the vectorized function : operates element-wise on the Array 
that is 
1.maybe undesirable, say matrix square root (3D)

2.Explicit mapping 
"""


"""
take sqrt when we ask for values from that array 

    nice thing is:

    Lazy is usd widely thru computing (in general)

    general arrays b. fit for comp 
    as
    because this bracket [] 

    taking valus from array v. crispyly
    encapsulates now, is the time to enact that computation 

    -allows us to i.e 
    1  have dataset 10K different nerouns plotting each one (of them )
    on the scatterplot 
    2. click on single one , take us right to raw data 
    3. might  have tpoint 0.01 of the total data volume
    so, no need to compute square root (on all pixel intensitiese)
    just compute on the one (I'm zoomed in(?)) , looking at a particular moment )]

    #Defining a new array type

    immu
mapped array isa substype of abstract array type 
-has 2 in it 
1 function 
2. original array (we wanting to Create a view of )

array: defines a containes
"""

"""
tim's lab's favorite is a one with  lazy initialization (promise-like async)



include("MappedArrays.jl")
"""


"""
1 create a view of (initial dataset)
only take roots, when ask the vslues, from that array
things nice: 

click on a single pixel-intensity 'neuron' lazily computes 
take us to its data
might only looking to 0.01 percent of the Data 
No need to compute on all pixel-intensities 

"""

"""
#self-made: EXPERIMENTAL - this wrecks the workplace variables - DO NOT RUN 
struct Mappedarray{T,N,A<:AbstractArray,f::Int...} <: AbstractArray{T,N}
    f:Int...
    data::A
end
"""

"""
gentle
function + original array (want to create a view of )
    1this defines a container
    2define hat happens when you (might) take a value of it 

apply function (You store in container) to each element
    (of the data ) as you take it out 
   notice: have to define this  for integers (it's significant)

"""
#errors out: f is not defined #that' the point of laziness

struct Mappedarray{T,N,A<:AbstractArray,F} <: AbstractArray{T,N}
    f:F
    data::A
end
###
Mappedarray{T,N}(f, data::AbstractArray{T,N}) =  #defines f as ones
    MappedArray{typeof(f(one(T))),N,typeof(data),typeof(f)}(f, data)

B = Mappedarray(sqrt, A) #only realizes computation whn calling B[i,j,..]

A = rand()
sqrt(A)         #implicit element-wise computation

map(sqrt, A)   #explicit element-wise computation 

@time sqrt(A)  # 0.000005 seconds (1 allocation: 16 bytes)

@time map(sqrt, A) # 0.000007 seconds (2 allocations: 32 bytes)
B = mappedarray(sqrt, A)
B = mappedarray(func, a)
###
##
Base.size(A::AbstractMappedArray) = size(A.data)#copies size of original data 
###
Base.Base.@propagate_inbounds Base.getindex(A::Mappedarray, i::Int...) =
    A.f(A.data[i...])


"""
notice F is representation 
julia's compileer 
knows 
there is a fucntion ( stroed in this objct)
2.which function it is 
this give
"""

"""
Base.@propagate_inbounds Base.getindex(A::Mappedarray, i::Int...) =
    A.f(A.data[i...])#function call


"""

"""
define what happens when you actually 
want to take a value of it right ?
this is the line that defines the bracket operation 

whn you actually extract values from it 

Defined in this way , there are a few v. important 
details 
see: Blake 
Apply function you store it
(in this container)
to each element of the data   
as you take it out 
you notice you only (Have) define 
this for integers 
    I'll poinit that out a more

2nd, you need define another function, which is just 
what's thee size of one of these objects 
"""


"""#to uncomment
@deprecate mappedarray(f_finv::Tuple{Any,Any}, args::AbstractArray...) mappedarray(f_finv[1], f_finv[2], args...)
Mappedarray{T,N}(f, data::AbstractArray{T,N}) = Mappedarray{typeof(f(one(T))),N,typeof(data),typeof(f)}(f, data)

Base.size(A::AbstractMappedArray) = size(A.data)

#size( original data ), you hav be abl to construct them 

"""
"""
this is the line you need for the constructor 

for a bare-bones impleementation , this is it- that's all you need to do
    to create one of these views that 
    computes arbitrary function, on the datatransformation 
        -static transformation is alomost every where 
Matt Baumann method:
get index
"""

#--- isn't there some overhead for this 
"""benchmark it 
creates function mysum 
    over elemts of the array 
    adds them to "accumulator"

    """
function mysum(A)
    s = zero(eltype(A))
    @inbounds for a in A
        s += a
    end
    s
end


@time A = rand(10^3, 10^3) #V  0.002637 seconds (2 allocations: 7.629 MiB) 1000×1000 Matrix{Float64}:
@time mysum(A)
"""benchmark output mysum(A)
B = Mappedarray(identity,A)
  0.003397 seconds (2 allocations: 7.629 MiB)
  0.010455 seconds (8.86 k allocations: 494.846 KiB, 
      86.97% compilation time)500164.74558258074
      
  """
#
"""lesson learned 
@inbounds macro oneach start of for loop 
"""


#ERROR: MethodError: no method matching Mappedarray(::typeof(identity),::Matrix{Float64})
#--- whi is there no overhead?

F = Base.identity 
#cannot declare constant, already has a value
struct Mappedarray{T,N,A<:AbstractArray,F} <: AbstractArray{T,N}
    f::F
    data::A
end
#set op: Assigning @propagate_inbounds
@time Base.@propagate_inbounds Base.getindex(A::Mappedarray, i::Int...) =
    A.f(A.data[i...])

#  0.008769 seconds (47 allocations: 3.448 KiB, 61.02% compilation time)

@time Base.getindex(A::Mappedarray, i::Int...) =
    A.f(A.data[i...]) # 0.000115 seconds (22 allocations: 1.415 KiB)

"""Lesson
Base.@propagate_inbounds (Function Inline)
Tells the Compiler to Inline a Function while Retaining the caller's       
  Inbounds Context
"""

"""Question essentially for all purposes, 
Compiler knows that f(x) = x

SO IT Doesn't Even bother to make a function call 
and returns value of it imeediately (that is how compiler Optimizes)
"""

#--- move as much analysis computation 
"""
to compile-time
 so there is less work for the CPU (at runtime)

    -this takes away the work, from th cpu 
    thee main trick of julia 
    """

"""Array views in Julia 
view is still Tied to original (line)data
allow st new values in the data too
(just find the inverse function)
mappedarray: a-> f(a) for a in A

SubArray (has a Parentarray)

slcting out a particular rectangular region 
in work: 
variant of subarray (span?)

3.slicePlane
(span?])
pros 
great for 1 off viewers (10 lines of code)

opportunity:great for dimensionality reduction (i.e)
so no need to larn about (deal with) 4D arrays  

him:doing imaging in a wird tilts 
selcting plac of 2D array 

4. ReshapedArray
-preservees dimensionality 
+ adds dimantionality to 3D objectss 

5. permutedDimsArray
view, traditional julia co,umn major 
v is transpose of this nature

don't write any code that Depends on Internal Representation

datastructures present in julia 

mappedarray types:

1 SubArray : (Parentarray,selectedRegion)

2. ReshapedArray: a x b = n x m 
(#there must be some linear non-linaer relation between domain, co-domain)
3. permutedDimsArray

what's not in julia (made )
4.SlicedPlane: (Parentarray, selectedRegion)


why: it's very easy for you to create your own data Types 

---------
Now MappedArray is a scalar transformation: A  = a*M ; (a isa scalar )
#--- implementing permutedDimsArray (added in 2016)

Concept behind impleementation: P (the view) reindexes as the parent A as 
#To reindex Parent Array
        P[inds...] -> A[inds[iperm]...]

#Anytime it passes a set of Indecies to the parent array (Permutated View)

struct permutedDimsArray{T,N,AA <: AbstractArray} <: AbstractArray{T,N}
    parent::AA 
    iperm:: Vector{Int} #storing inverse permutation
    dims::NTuple{N, Int}
end

"""
#compiles (wow)
struct permutedDimsArray{T,N,AA<:AbstractArray} <: AbstractArray{T,N}
    parent::AA
    iperm::Vector{Int} #storing inverse permutation (as vectors of integers)
    dims::NTuple{N,Int}
end
#T not defined: me: so is it only defined on runtime? (as it's lazy?)
Base.@propagate_inbounds function Base.getindex{T,N}(P::PermutedDimsArray{T,N}, I::Vararg{T,N})
    getindex(P.parent, I[P.iperm]...)
end


"""lesson learned: async method on any array ( via index)
    invoke @propagate_inbounds onto any function (Array)

        getindex -then-> @propagate_inbounds

1.Apply permutation to Indecies (being supplied here)
2.Reference them to parent array

"""

#performance check

@time sum(A)#  0.001322 seconds (1 allocation: 16 bytes) 499814.9740729731

@time sum(P) # in demo: parent is undefined #ways of accumulating,it isa not mentioned

"""
Point permutedDimsArray (Permuted view , of that array) is 400 times Slower
(v. unhappy with performance)
how do you go about getting a better performance?

"""
#--- An impleementation based on tuples 

""" tuples are the trick behind almost everything 
(that you do, with an array)

"""
# v2 compiles
"""
PermutedDimsArray
Example:

  julia> A = rand(3,5,4);
  
  julia> B = PermutedDimsArray(A, (3,1,2));
"""
struct PermutedDimsArray{T,N,AA<:AbstractArray,perm,iperm} <: AbstractArray{T,N}
    parent::AA
    dims::NTuple{N,Int}

end

"""
moved inverse permutation iperm 
into the type parameters 
(me: that is an old C trick , inserting functions into parameters)

the argument Issue: 
1. you can't put an array in there  (but at the same time )
2.  you CAN Put a Tuple (which fastens the Computation Speed,drastically)

storing both prm , perminve (me:acutallly, just passing (physocaly stored in memory: is it? yeah))

so, one is predictable from the other 
but, essentiallymkes your lif more convinient 
(in 'certain circumstances' to have both)

"""



#General case: don't compile this block
struct structname end
Base.@propagate_inbounds function (base.getindex{}(A::structname, I::Vararg{typeof,N})
getindex(A.parent, ntuple(d -> I[[]], Val{N})...) #TODO:how to make that line in unicod
)#N above for (Rational?/IRrattional? (numberTheory req.)) Polynomial functions
    #for real analysis ok, but 
    #if Complex Analysis required, then [ENTER YOUR METHOD HERE] IS REQUIRED 3 
end

"""
Reindexing, at Level of Tuples

"""

abstract type AbstractMappedArray{T,N} <: AbstractArray{T,N} end
abstract type AbstractMultiMappedArray{T,N} <: AbstractMappedArray{T,N} end

#----
Base.@propagate_inbounds _getindex(i, A, As...) = (A[i], _getindex(i, As...)...)
_getindex(i) = ()

Base.@propagate_inbounds function _setindex!(as::As, vals::Vs, inds::Vararg{Int,N}) where {As,Vs,N}
    a1, atail = as[1], Base.tail(as)
    v1, vtail = vals[1], Base.tail(vals)
    a1[inds...] = v1
    return _setindex!(atail, vtail, inds...)
end
_setindex!(as::Tuple{}, vals::Tuple{}, inds::Vararg{Int,N}) where {N} = nothing




#testing

function testvalue(data)
    if !isempty(data)
        first(data)
    else
        zero(eltype(data))
    end::eltype(data)
end

#---benchmarking 
function dotop1(a, b)

    return a .== b #Assignment is negligible (so do return)
end

Base.@propagate_inbounds function dotop2(a, b)

    return a .== b #Assignment is negligible (so do return)
end
#--------------PermutedDimsArray application

"""
"""
m = AA = 1;
n = N = 10;
a = ones(N, m)
b = ones(m, N)

#--- permutation


"""
#TODO: get @btime's output 

check stabiltiy way of code coding ,...

reliability vs stanility 
 """
#General code isa good but isa not entirely free of Overhead 

#from (undiscovered source) 


#test a 'dumb wrapper'
T = Int
struct wrapper{T,N} <: AbstractArray{T,N}
    A::Array{T,N}
end


Base.Base.@propagate_inbounds Base.getindex(W::wrapper, i, j, k) = W.A{i,j,k}

"""in llvm most of computations go aways 
inlining the lowest level of computation that Happens
( no matter where you make use of the Array)
Takeaway : try most of the time to use an infix function 
"""
#--- a brief look at SubArray
#changing gears
using Test, BenchmarkTools
@benchmark A = rand(5, 7, 3)#  A is a 3D Array , you can create subarray (view)  # 212.944 ns (1 allocation: 1008 bytes)
@benchmark B = view(A, 2:3, 4, 1:2) #view shoould be 2D (kernel) 2 by 2 #40.061 ns (1 allocation: 80 bytes)

struct subarray{T,N,P,I,L} <: AbstractArray{T,N}
    parent::P # 5 by 7 by 3 Float64 array 
    indexes::I # (2:3, 4, 1:2) 4 is an integers
    """notice number in middle is 4 
    so, it's the Types embedded in indicies tuple, that determine 
    key properties of the output view of this 
    
    what means: 
    when index B it ends up
    getting directly translated into 
    2 gets applied to the first of these
     indicies 
     (so it pulls out th 3 from that)
    
     2nd index: gets copied from th 'defining value'
     B[2,2] gets translated into A[(2:3)[2], 4, (1:2)[2]] = A[3,4,2]
     
     
    2nd index gts skipped over
    doesn't get consumed by the 2nd index
    
    get applied to the final member (of this defining tuple)
    #I hope that's clear 
    based on how you're defining your sub-array
    
    the indicies you supply  to the view 
    nd up getting applied to different dimensions 
    (of the original parent array)
    -not complicated, one you get used to writing code like this 
    
    when i'm first in julia: 
    subarrays defined in strides (parent arrays )  
    into creating a view : has physical existance in memory 
    as many of these 
    
    that doesn't allow you to use non-uniform 
    indicies, like vectors of integers 
    
    we can select out arbitrary columns to slice through  
    you can slice it with a matrix, as one of the indicies
    
    - this creates a 3 Dimnsional view 
    dimemsions 1 & 2 of the view come from the first 
    Dimension A  
    dim 2 is skipped over
    dim 3  comes from dim 3 comes from dimntion 3 of A 
     
    amazing how infrastructuree becom overtime 
    
    #Apply these indicies to the view  indicies
    in a type aware fashion 
    (now) we use tuples, rather than arrays

    """

    B = view(A, [1, 3, 4], 4, 1:2)
    #--- Reindexing using Dispatch: it's all in the Tuples

    # B[ind]
    x = rand(5, 5)
    newinds ↦ (newinds..., x) # instead of push!(newinds,x)
    B[inds...] ↦ A[reindex(inds, B.indexes...)...]
    inds = (2, 2)
    B.indexes = (2:3, 4, 1:2)
    #changing index:
    Base.reindex((2, 2), 2:3, 4, 1:2) -> (3, Base.reindex((2,), 4, 1:2)...) -> (3, 4, Base.reindex((2,), 1:2)...) ->(3, 4, 2, Base.reindex(())) ↦(3, 4, 2)
end

"""
reindex ha to bee type-aware 
"""

"""
reshapedArray 

a neww type array   alwaay returns the view of array 
regardless A type 
""" #rand(5, 7, 3)
B = reshape(A, (3, 5, 7)) #compiles
i = 1;
j = 1;
k = 1;
#where
l = Base.ind2sub(B, i, j, k) # convert into linear index


B[i, j, k] ↦ B[l] ↦ A[l]


"""easy when fast  linear indexng
thethat's lineear indexingissssssssssss

you convet into linrar to cartesian indexes
passed into 

""""

division mwas ccomsumptiopn 
other wise fallkak algorithnm 


"""
"""
i = sub2ind(B, i, j, k)

B[i,j,k] - A[sub2ind( A, sub2ind(B,i,j,k)) ...]
ncl tp cartesian ind for th array 
    """

"""ReshapedArray
-new type:e
"""
a = length(A)
B = reshape(A, (3, 7, 5)) #size 4,5,5 = 4*5*5 = 100 change from (3, 5, 7) to (3, 7, 5)
"""
that line returns a view of A 
if A has fast indexing then 
    l = sub2ind(B,i,j,k)
    B[i,j,k] ↦ B[l] ↦ A[l]
ReshapedArray
    -new type:e
    always returns a view of A ( regardless of A's type )
    one case: 
    -easy if

reverse involvs rrrrrrgivions slow 
"""
↦ = ->
l = Base._sub2ind(B, i, j, k) # compiles returns 
B[i, j, k] --> B[l] --> A[l]
"""

added recetly v fast ingteg dimension

# function 
#focus on iteration 

function mysum(θ)

    s = 0.0
    for I in eachindex(θ)
        s += B[I]
    end
  """


"""
much harder case
if (it has) no fast linear Indexing then
 
    1.convert it to linear index , then

    2. convert it back to the cartesian index 
for the reshaped version (of the Array)

Problem: B[i, j, k] invalid function argument
    """
##otherwise
B[i, j, k] -> A[Base.ind2sub_rs(A, Base._sub2ind(B, i, j, k))...]

"""computes linar index in a tuple as Fast
(as it involves multiplications & additions)
Reverse transformation calls Divisions
-> that's slow 
"""

"""main problem: slow Integer Division  libdivide(g++ O3) v
the fastest c library is written in Julia code

despite getting fast, this Bottleneck is very slow 
"""

""" last topic: Focus on iteration """
#one way to sum an array - like this - standard idiomatic code in julia
function mysum(B)
    s= 0.0 
    for I in eachindex(B)
        s += B[I] #CartesianIndex((2,3,4))
    end
    s
end

"""if B has no 'Fast indexing', then this index here is a CartesianIndex
meaning: one index per dimension (of the underlying array)
if this is a reshapedArray, then problem it has to compute those divisions  each time """
    
    
"""
for code like this, there's no reason to compute , instead
    Iterating (each element) over the array 
     don't care how you name the indices 
     just care that you get the next value (me:as long as they're coming, i'm glad)

     Maybe, you could solve a lot of these cases, where
in cases where the iteration, the 'Index Retrieval' Problem is difficult to solve
maybe you can solve that, by coming up with Smart patterns that Iterate

Idea: why not index this with parent index, relative to the original array ?

the rule is: 
1.simply pop Out of the view 
2. go right back to the original parent 

i.e. 
instead of CartesianIndex((2,3,4))
?: ParentIndex((10,4)), B[ParentIndex((10,4))] -> A[10,4]

that idea works, but runs into little bit of problem:



     """
#instead of 
t = CartesianIndex((2,3,4))
T = ?: ParentIndex((10,4)), B[ParentIndex((10,4))] -> A[10,4]

# Sometimes

"""copies (all) from source to destination
```inputs 
src 
dest  


````
"""
function mycopy(dest, src)
    size(dest) == size(src) || error("sizes must match") # if statement without an iff (plus error handling)
    for I in eachindex(src) 
        dest[I] = src[I]
    end
    return dest
end

@benchmark mycopy()
"""problem specialization:
If Specialize to return v. paarticular type of index
(for a particular array)
 that doesn't really generalize to something else 
like a copy operation 
-then-> you can end up into trouble
"""

"""simple solution"""

"""
# ?. replace the loop with 

what if you give each array its own Iterator  (?)

"""

for (Idest, Isrc) in zip(eachindex(dest), eachindex(src))
    dest[Idest] = src[Isrc]
end 
#almost right, but dangerous

"""
1 check 2 Arrays are of the same sizes
2 say: "U know, I don't care how you Iterate over your own elements"
(Tim Holy: just do your own thing, man)
what to do now: i'll just copy values, 1 by 

this kinda works , but really dangerous
because these axes are not coupled to one another 
(in any fashion)
zip: take 2 iterators , let each along march happily (indepndently)

keything: make it too dangerous 
some joker also added permutedDimsArray

if allow that kinda thing to happen 

    """
#--- the need for synchronized Iteration 

function mycopy(dest, src)
size(dest) == size(src) || error("size must match")
for(Idest, Isrc) in zip(eachindex(dest), eachindex(src))
    dest[Idest] = src[Isrc]
end 
dest 
end 

"""key concept (modern hardawre )
when you iterate, over the elemets of the Array 
you'd like to Do it, in the order which i tored in Memory 
that alone, Makes enormous difference (in terms of performance)

sum function didn't do that, Becaus
"""

#tricks array checkEqualSize

function checkEqualSize(dest, src)
    if size(dest) == size(src) return true; 
    else error("size must match");return false;

end 

""" on modern hardawre - when iterating an instance (object)
you'd like to do it IN order (which it was stored in MEMORY)
[me:  Heap structure FIFO First In First Out]

in sum function: 
    it didn't do that (iterating in order)
     because  it is written Assuming  that 
     all arrays in Julia are indexed by columns - right?


an  e 
#--- the need for synchronized Iteration 
"""
function mycopy(dest, src)
size(dest) == size(src) || error("size must match")
for(Idest, Isrc) in zip(eachindex(dest), eachindex(src))
    dest[Idest] = src[Isrc]
end 
dest 
end 

"""
if change that so each index returns most efficient iterator 
    the problem is 
    your simple copy algorithnm would be then 
end-up becoming 
a  'Transpose Operation'
"""

function mycopy(dest, src)
    for (Idest, Isrc) in Base.sync(index(dest),index(src))
        dest[Idest] = src[Isrc]
    end
    dest
end

"""end-up taking the transpose of this array (here)

which not be what you intended 
In async: end-up needing slightly 

key Point: 
nd-up needing slightly different curve (Dim?)
One (that) it doesn't yet exist [in the julia landscape] - since 2018

means: rather than zip, you need to address the fact, 
1 you can reiterate (over these Arrays
2. you Need to do so in a synchronized fashion 

what I mean by the index Apply(applies)

eventhough those 2 indices are (in a ) Parametrized manner
parametrization

in a Dreamworld (ideally), your iteration pattern (for this kind of problem)

would look like this 

the Dichotomy:
-rather than looking at rows & columns 
--you'd actually working a block [me: zigzag fahion]

-you'd copy that block, then move onto the next (Below)
--& iterate over arrays that way 

you should do sth safe (provided by the synch operation)

the sync operation says:
tim:
-usually iterate over colums, but, one of 'these' have rows 
force one of thm to have a 'slow access pattern' (than the other fast one)
-that would be safe; we can accept that 


"""

"""the long-term goal 

use this block  -tiled iteration pattern 
but in the short-term:
takeaway: all (we) have to do is make our concept safe (for this kind of operation)


#--- working out the future ? in ArrayIteration.jl
"""

"""purely for prototyping purposes 
(abstraction , generalization, etc...)

no really sth you should use for serious work  - right ? 

there are number of things that  already present (in this ) package
1. fast & safe synced ReshapedArray Iterations
(in a sense, the Reshape problem resolves (it) )
It comes under heap vs stack issue (in memory allocation)

2. safe synced PermutedDimsArray iteration 
3. Fast synced PermutedDimsArray iteration

"""


