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

#No method matching +(::Array{Float64,0}, ::Float64)
#myfun
#0-dimensional sum (1 scalar value)
function mysum(A)
    s = zeros(eltype(A))
    @inbounds for a in A
        s .+= a
    end
    s
end
#=should got 1 Dimensional vector=#
function mysum(A)
    s = zeros(eltype(A))
    @inbounds for a in A
        s += a
    end
    s
end

mysum(typeof(rand(5, 5)))

m = mysum(rand(5, 5))

#meanwhile, emulating large dataset 

A = rand(10^4, 10^4)
B = Mappedarray(identity, A) # MappedArray not defined (yet)


@time mysum(A)
@btime mysum(A)
@Benchmarking mysum(A)

@time mysum(B)
@btime mysum(B)
@Benchmarking mysum(B)

#TODO: fix mysum()

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
    1  have dataset 10K "with  different nerouns plotting each one" (of them )
    on the scatterplot 
    2. Click on single one , take us right to raw data 
    3. Might  have tpoint 0.01 of the total data volume
    so, no need to compute Square root (on all pixel intensitiese)
    just compute on the one (I'm zoomed in(?)) , looking at a particular moment )]

    #Defining a new Array Type

    #immu
mapped array isa substype of abstract array type 
-has 2 in it 

1 Function 
2.Original array (we wanting to Create a view of )

array: defines 'a' (which contains ...)
"""

"""
            (Dr.) Tim's lab's favorite is:  



include("MappedArrays.jl")
#=Features
1.lazy Initialization
2.(promise-like async) [me: missed javascript programming]
=#
"""


"""
-1 Create a View of (Initial dataset)
-Only take Roots, when ask the values, from that array
things nice: 

Click on a Single Pixel-Intensity 'Neuron' Lazily Computes 
(Take us to its data)
Might only looking to the "0.01" (1%) percent of the Data 
`No need to compute` on all Pixel-Intensities 

"""

"""
#Self-made: EXPERIMENTAL - This Wrecks the Workplace Variables - DO NOT RUN!

struct Mappedarray{T,N,A<:AbstractArray,f::Int...} <: AbstractArray{T,N}
    f:Int...
    data::A
end
"""

"""
gentle
function + original array (want to create a view of )
    1.This defines a container
    2.Define that happens when you (might) take a value of it 

Apply Function (You store in container) to each element
    (of the data ) as you take it out 
   Notice: have to define this for Integers (it's Significant)

"""
#errors out: f is not defined #that' the point of laziness # there's more into that 
#introduce MappedArray
struct Mappedarray{T,N,A<:AbstractArray,F} <: AbstractArray{T,N}
    f:F
    data::A
end #f not defined, Prof. Holy
###
#or using an already set 
using MappedArrays, Test # ] add MappedArrays

A = rand(5, 5)
T = ones
N= ones
MappedArray{T,N}(f, data::AbstractArray{T,N}) =  #defines f as ones # but N Not defined 
    MappedArray{typeof(f(one(T))),N,typeof(data),typeof(f)}(f, data)

B = Mappedarray(sqrt, A) #only realizes computation whn calling B[i,j,..] # no method matching 

#--- 
#sqrt() & map(sqrt,A) 
#map approximates sqrt correctly 
#Q. how many floating points are necessay? #TODO:

A = rand()
sqrt(A)         #implicit element-wise computation # 0.9328629863877007  

map(sqrt, A)   #explicit element-wise computation # 0.9328629863877007   

@time sqrt(A)  # 0.000005 seconds (1 allocation: 16 bytes)

@assert sqrt(A) == map(sqrt, A)  #True 

#------
@time map(sqrt, A) # 0.000007 seconds (2 allocations: 32 bytes)
@btime map(sqrt, A) #183.176 ns (2 allocations: 32 bytes) ;0.9298476269411314 # 181.304 ns #the BEST  
@benchmark map(sqrt, A)
#=
BenchmarkTools.Trial: 10000 samples with 631 evaluations.
 Range (min … max):  183.043 ns …  1.835 μs  ┊ GC (min … max): 0.00% … 86.16%
 Time  (median):     195.563 ns              ┊ GC (median):    0.00%
 Time  (mean ± σ):   209.635 ns ± 59.076 ns  ┊ GC (mean ± σ):  0.30% ±  1.75%

  █▂▄▇▄▁▅▃▂▂ ▁  ▃▃ ▁▂                                          ▁
  █████████████▇██▇████▇▆▇▇▇▆▆▆▆▇▇▇▇▆▅▆▇▇▆▆▅▆▆▇▅▅▆▆▅▇▆▄▅▄▅▅▅▄▄ █
  183 ns        Histogram: log(frequency) by time       419 ns <

 Memory estimate: 32 bytes, allocs estimate: 2.
 =#

B = mappedarray(sqrt, A) #  either A 's items reach end of program (as expected) #Or   # ERROR: tuple must be non empty 
#B = mappedarray(func, a) #anyways, it's generalization

##
##
@test Base.size(A::AbstractMappedArray) = size(A.data)#copies size of original data  #true #ERROR: (UNEXPECTED) during test
###
Base.Base.@propagate_inbounds Base.getindex(A::Mappedarray, i::Int...) =
    A.f(A.data[i...])

"""
Notice F is representation 
Julia's Compiler 
Knows 
There is a Fucntion ( stored in this object)
2.which Function it is 
this give:
"""

"""
Base.@propagate_inbounds Base.getindex(A::Mappedarray, i::Int...) =
    A.f(A.data[i...])#function call
"""

"""
Define What happens when you Actually 
Want to Take a Value of it right ?
This is The Line that Defines the Bracket Operation 

When you Actually Extract values from it 

Defined in this way , there are a few v. important 
Details 
See: Blake 

Apply function you store it
(in this container)
To each element of the data   
As you take it out 
You notice you only (Have) define 
This for integers 
    I'll point that out (a more)

2nd, you need Define Another Function, which is just 
what's the Size of One of these Objects 

"""


"""#to Uncomment
@deprecate mappedarray(f_finv::Tuple{Any,Any}, args::AbstractArray...) mappedarray(f_finv[1], f_finv[2], args...)
Mappedarray{T,N}(f, data::AbstractArray{T,N}) = Mappedarray{typeof(f(one(T))),N,typeof(data),typeof(f)}(f, data)

Base.size(A::AbstractMappedArray) = size(A.data)

#size( Original Data ), you hav be abl to construct them 
"""
"""
This is the line you need for the constructor 

For a Bare-bones Implementation, this is it- that's all you need to do
    to create one of these views that 
    Computes arbitrary function, on the Datatransformation 
        -static transformation is alomost every where 
"Matt Baumann" method: #TODO: Research "Matt Baumann"                 <---------------------------------------
        get index
"""

#--- isn't there some overhead for this 

"""benchmark it 
Creates function mysum 
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
@time mysum(A) # 499774.5988719051
@benchmark mysum(A)
#=
  0.003270 seconds (2 allocations: 7.629 MiB)
1000×1000 Matrix{Float64}:

BenchmarkTools.Trial: 3940 samples with 1 evaluation.
 Range (min … max):  1.120 ms …   2.929 ms  ┊ GC (min … max): 0.00% … 0.00%
 Time  (median):     1.199 ms               ┊ GC (median):    0.00%
 Time  (mean ± σ):   1.260 ms ± 163.289 μs  ┊ GC (mean ± σ):  0.00% ± 0.00%

  ▁  ▄█▇ ▁    
  █▇██████▆▆▅▃▃▂▃▂▂▂▂▂▂▁▂▁▂▁▂▂▂▂▂▂▂▂▂▁▁▂▂▂▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁ ▂
  1.12 ms         Histogram: frequency by time        1.89 ms <

 Memory estimate: 16 bytes, allocs estimate: 1.
=#
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

"""[{
	"resource": "./DeepLearner/DeepLearner/src/DataStructures/Arrays/Array.jl",
	"owner": "_generated_diagnostic_collection_name_#1",
	"severity": 2,
	"message": "Cannot declare constant; it already has a value.",
	"source": "Julia",
	"startLineNumber": 347,
	"startColumn": 1,
	"endLineNumber": 350,
	"endColumn": 4
}]
#ERROR: MethodError: no method matching Mappedarray(::typeof(identity),::Matrix{Float64})
#--- Q.why is there no overhead?

##F = Base.identity #you can't pre-define it (because it throws error "Cannot Declare a Constant, already has a value")
#Cannot declare constant, already has a value

struct Mappedarray{T,N,A<:AbstractArray,F} <: AbstractArray{T,N}
    f::F
    data::A
end
"""
#set op: Assigning @propagate_inbounds #try-out, on every array Op (Please)
@time Base.@propagate_inbounds Base.getindex(A::Mappedarray, i::Int...) =
    A.f(A.data[i...])

#=  0.008769 seconds (47 allocations: 3.448 KiB, 61.02% compilation time)
    0.005372 seconds (47 allocations: 3.448 KiB, 50.32% compilation time)

    var seconds (const alloc = 47: 3.448 KiB var %compilation time)

Infer:allocations is the only Reliable indicator (across machines)
    [not time(seconds), not %compiliation]
=#

@time Base.getindex(A::Mappedarray, i::Int...) =
    A.f(A.data[i...]) # 0.000115 seconds (22 allocations: 1.415 KiB)

"""Lesson Learned 
Base.@propagate_inbounds (is (called) an Inline Function Inline)
Tells the Compiler to Inline a Function while Retaining the caller's       
  'Inbounds Context'
"""

"""Question essentially for all purposes, 
Compiler knows that f(x) = x

SO It Doesn't Even Bother to make a function call #the whole Point
and returns Value of it immediately (that is how compiler Optimizes)
"""

#--- move as much analysis computation 
"""
To Compile-time
So there is `Less work for the CPU` (at runtime)

    -This takes away the work, from the Cpu 
    "Thee main trick of julia" ( low & Behold?!) 
    """

"""Array Views in Julia 
View is still Tied to original (line)data
Allow sth new values in the data too
(i.e. just find the `inverse function`) (me: if !isa N/A )
mappedarray: a-> f(a) for a in A

SubArray (has a Parentarray)

slicing out a Particular `Rectangular Region` #need-for-Visualization #makie  
in work: 
Variant of subarray (span?)

3.slicePlane
(span?])
pros 
Great for 1 off viewers (10 lines of code)

Opportunity: Great for dimensionality reduction (i.e)
So no need to learn about (deal with) 4D arrays  

Him:doing imaging in a `weird tilts 
(Selcting place of 2D array )


4. ReshapedArray
-Preservees dimensionality 
+ adds dimantionality to 3D objects

5. permutedDimsArray
view, traditional julia Column major 
(v is transpose of this nature)

Don't write any code that Depends on `Internal Representation`

Datastructures present in julia 

Mappedarray types:

1 SubArray : (Parentarray,selectedRegion)

2. ReshapedArray: a x b = n x m 
(#there must be some linear non-linaer relation between domain, co-domain)
3. permutedDimsArray

What's not in julia (made )
4.SlicedPlane: (Parentarray, selectedRegion)

Why: it's very easy for you to create your own data Types 

---------
Now MappedArray is a Scalar Transformation: A  = a*M ; (a isa scalar )
#--- implementing permutedDimsArray (added in 2016)

Concept behind impleementation: P (the view) reindexes as the parent A as 
#To reindex Parent Array
        P[inds...] -> A[inds[iperm]...]

#Anytime it Passes a set of Indicies to the parent array (Permutated View)

Struct permutedDimsArray{T,N,AA <: AbstractArray} <: AbstractArray{T,N}
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
"""
ERROR:
"""

#T not defined: me: so is it only defined on runtime? (as it's lazy?) - at runtime but in debugging, suffice to give it a try 
#T = Int64
 N = 2
Base.@propagate_inbounds function Base.getindex{T,N}(P::PermutedDimsArray{T,N}, I::Vararg{T,N})
    getindex(P.parent, I[P.iperm]...)
end
#ERROR: in Type{...} expression, expected UnionAll, got a value of type typeof(getindex)

"""Lesson Learned: 
Async Method on any Array ( via index)
    Invoke @propagate_inbounds onto any function (Array)

        getindex -then-> @propagate_inbounds

1.Apply Permutation to Indicies (being Supplied here)
2.Reference them to Parent Array

"""

#performance check

@time sum(A)#  0.001322 seconds (1 allocation: 16 bytes) 499814.9740729731

@time sum(P) # in demo: parent is undefined #ways of accumulating,it isa not mentioned

"""Point permutedDimsArray 
(PermutedView , of that array) is 400 times Slower
(v. unhappy with performance)
How do you `go about` getting a better performance?

"""
#--- (Do) An impleementation based on tuples 

""" tuples are the trick behind Almost Everything  #Tonight's Takeaway
(that you do, with an array)

"""
# v2 compiles
"""
PermutedDimsArray

Example: #Do-with-me

  julia> A = rand(3,5,4) #a Humongous Array 
  
  julia> B = PermutedDimsArray(A, (3,1,2)) # a partof the Original Array
"""
#First of all, Define PermutedDimsArray
struct PermutedDimsArray{T,N,AA<:AbstractArray,perm,iperm} <: AbstractArray{T,N}
    parent::AA
    dims::NTuple{N,Int}

end

"""
Moved inverse permutation iperm 
Into the type parameters 
(me: that is an old C trick , inserting functions into parameters)

The Argument Issue: 
1. you Can't put an array in there  (but at the same time )
2. you CAN Put a Tuple (which fastens the Computation Speed, drastically)

storing both `prm` , perminve (me:acutally, just passing (physically stored in Memory: is it? yeah))

so( that), one is `predictable`` from the other 
but, essentially, (It) makes your life more convinient (a bit) 
(in `Certain circumstances` to have both) #need-to-have 
"""


"""
General block: for Generalization & abstraction only - Do not usE THIS code Block -  Compile the next one, please
"""
#General case: don't compile this block
struct structname end #always do this (in OOP Strategy - write (abstract) struct name then end ) #me: what if i have

Base.@propagate_inbounds function (base.getindex{}(A::structname, I::Vararg{typeof,N})
getindex(A.parent, ntuple(d -> I[[]], Val{N})...) #TODO:how to make that line in unicod
)#N above for (Rational?/IRrattional? #numberTheory (numberTheory req.)): Polynomial functions
    #for Real Analysis ok, but 
    #if Complex Analysis required, then [ENTER YOUR METHOD HERE] IS REQUIRED - lvl 3 
end


"""
Reindexing, at Level of Tuples

"""

#----works
Base.@propagate_inbounds _getindex(i, A, As...) = (A[i], _getindex(i, As...)...)
_getindex(i) = ()
#genetic function with 2 methods 
Base.@propagate_inbounds function _setindex!(as::As, vals::Vs, inds::Vararg{Int,N}) where {As,Vs,N}
    a1, atail = as[1], Base.tail(as)
    v1, vtail = vals[1], Base.tail(vals)
    a1[inds...] = v1
    return _setindex!(atail, vtail, inds...)
end
_setindex!(as::Tuple{}, vals::Tuple{}, inds::Vararg{Int,N}) where {N} = nothing



"""
Testing Area
"""
#---testing

m = AA = 1;
n = N = 10;
a = ones(N, m)
b = ones(m, N)
function testvalue(data)
    if !isempty(data)
        first(data)
    else
        zero(eltype(data))
    end::eltype(data)
end
#--- Juliacon 2016 

#=
by Professor David Sanders 
=#

#=
extending arrays
how: by using the push (Bang)
=#
V = []
w = []

push!(w, "adamus")
append!(w, [3, 4.5, "coffee costs"])

push!(V, 1)
#=
Exclamation mark: is convention that says:
1 argument (or more ) is gonna be modified 
this case, it's V 
=#
#- hcat - horizontal cat 
M = @inbounds hcat(V[1], V[2]) # for all elements( hardcoded here for 2 item) #true positive error @even with inbounds, alerts with error  
#vector to Array: horizontal concat hcat: horizontally contatenated vertical vectors  
M = hcat(V...) #...:the splat: for all values of container  ; take each element in array ; put it as an argument (concatenate it)
#splat ...: takes each element, in the Iterable, & make Another Argument (of the function)

#toget it back (as vector of vectors), transpose it 

M = hcat(V...)'
#1x1 adjoint matrix eltype Int64  - example 
#or we directly can write vecto as 

v = Vector{Int}[[3, 4], [5, 6]] #2-element Vector{Vector{Int64}}:
v = [[3, 4], [5, 6]] #2-element Vector{Vector{Int64}}:
#=2-element Vector{Vector{Int64}}:
 [3, 4]
 [5, 6]
 Splat warning: Careful when splatting large objects 
 (objects with many elements )
 e.g.
 1. concat things into 1 huge vector 
2. then, do a reshape 

A view: is a reshape (instead of copy, in Julia)

=#

"""higher-dimensional arrays have a fixed size! 
-Instead of having a fixed size structure  
we can Dynamically allocate vectors 
How: by vector of vectors 
if we want a dynamic array that accets 

"""
w = [] # enmpty array, 0 element , of type {Any,1}
v = Vector{Int}[]
push!(v, [3, 4])
push!(v, [5, 6])

