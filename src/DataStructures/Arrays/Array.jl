"""
Credits:

 Tim Holy - JuliaCon 2016 


"""
abstract type AbstractMappedArray{T,N} <: AbstractArray{T,N} end
abstract type AbstractMultiMappedArray{T,N} <: AbstractMappedArray{T,N} end

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
mysum(typeof(rand(5,5)))

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
using MappedArrays;
T = ones
MappedArray{T,N}(f, data::AbstractArray{T,N}) =  #defines f as ones
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
#compiles (ok)
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

#----works
Base.@propagate_inbounds _getindex(i, A, As...) = (A[i], _getindex(i, As...)...)
_getindex(i) = ()

Base.@propagate_inbounds function _setindex!(as::As, vals::Vs, inds::Vararg{Int,N}) where {As,Vs,N}
    a1, atail = as[1], Base.tail(as)
    v1, vtail = vals[1], Base.tail(vals)
    a1[inds...] = v1
    return _setindex!(atail, vtail, inds...)
end
_setindex!(as::Tuple{}, vals::Tuple{}, inds::Vararg{Int,N}) where {N} = nothing


"""
"""
m = AA = 1;
n = N = 10;
a = ones(N, m)
b = ones(m, N)


#testing
function testvalue(data)
    if !isempty(data)
        first(data)
    else
        zero(eltype(data))
    end::eltype(data)
end
