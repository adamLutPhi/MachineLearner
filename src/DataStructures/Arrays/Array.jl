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


using Test

let x, y, x
    x = TypeVar(:a)
    y = TypeVar(:a)
    z = TypeVar(:a)
    @test repr(UnionAll(z, UnionAll(x, UnionAll(y, Tuple{x,y,z})))) == "Tuple{a1, a2, a} where {a, a1, a2}"
    @test repr(UnionAll(z, UnionAll(x, UnionAll(y, Tuple{z,y,x})))) == "Tuple{a, a2, a1} where {a, a1, a2}"
end

let x = TypeVar(:_, Number), y = TypeVar(:_, Number)
    @test repr(UnionAll(x, UnionAll(y, Pair{x,y}))) == "Pair{_1, _2} where {_1<:Number, _2<:Number}"
    @test repr(UnionAll(y, UnionAll(x, Pair{x,y}))) == "Pair{_2, _1} where {_1<:Number, _2<:Number}"
    @test repr(UnionAll(x, UnionAll(y, Pair{UnionAll(x, Ref{x}),y}))) == "Pair{Ref{_1} where _1<:Number, _1} where _1<:Number"
    @test repr(UnionAll(y, UnionAll(x, Pair{UnionAll(y, Ref{x}),y}))) == "Pair{Ref{_2}, _1} where {_1<:Number, _2<:Number}"
end

@testset "matrix printing" begin
    # print_matrix should be able to handle small and large objects easily, test by
    # calling show. This also indirectly tests print_matrix_row, which
    # is used repeatedly by print_matrix.
    # This fits on screen:
    @test replstr(Matrix(1.0I, 10, 10)) == "10×10 Matrix{Float64}:\n 1.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0\n 0.0  1.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0\n 0.0  0.0  1.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0\n 0.0  0.0  0.0  1.0  0.0  0.0  0.0  0.0  0.0  0.0\n 0.0  0.0  0.0  0.0  1.0  0.0  0.0  0.0  0.0  0.0\n 0.0  0.0  0.0  0.0  0.0  1.0  0.0  0.0  0.0  0.0\n 0.0  0.0  0.0  0.0  0.0  0.0  1.0  0.0  0.0  0.0\n 0.0  0.0  0.0  0.0  0.0  0.0  0.0  1.0  0.0  0.0\n 0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  1.0  0.0\n 0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  1.0"
    # an array too long vertically to fit on screen, and too long horizontally:
    @test replstr(Vector(1.0:100.0)) == "100-element Vector{Float64}:\n   1.0\n   2.0\n   3.0\n   4.0\n   5.0\n   6.0\n   7.0\n   8.0\n   9.0\n  10.0\n   ⋮\n  92.0\n  93.0\n  94.0\n  95.0\n  96.0\n  97.0\n  98.0\n  99.0\n 100.0"
    @test occursin(r"1×100 adjoint\(::Vector{Float64}\) with eltype Float64:\n 1.0  2.0  3.0  4.0  5.0  6.0  7.0  …  95.0  96.0  97.0  98.0  99.0  100.0", replstr(Vector(1.0:100.0)'))
    # too big in both directions to fit on screen:
    @test replstr((1.0:100.0) * (1:100)') == "100×100 Matrix{Float64}:\n   1.0    2.0    3.0    4.0    5.0    6.0  …    97.0    98.0    99.0    100.0\n   2.0    4.0    6.0    8.0   10.0   12.0      194.0   196.0   198.0    200.0\n   3.0    6.0    9.0   12.0   15.0   18.0      291.0   294.0   297.0    300.0\n   4.0    8.0   12.0   16.0   20.0   24.0      388.0   392.0   396.0    400.0\n   5.0   10.0   15.0   20.0   25.0   30.0      485.0   490.0   495.0    500.0\n   6.0   12.0   18.0   24.0   30.0   36.0  …   582.0   588.0   594.0    600.0\n   7.0   14.0   21.0   28.0   35.0   42.0      679.0   686.0   693.0    700.0\n   8.0   16.0   24.0   32.0   40.0   48.0      776.0   784.0   792.0    800.0\n   9.0   18.0   27.0   36.0   45.0   54.0      873.0   882.0   891.0    900.0\n  10.0   20.0   30.0   40.0   50.0   60.0      970.0   980.0   990.0   1000.0\n   ⋮                                  ⋮    ⋱                          \n  92.0  184.0  276.0  368.0  460.0  552.0     8924.0  9016.0  9108.0   9200.0\n  93.0  186.0  279.0  372.0  465.0  558.0     9021.0  9114.0  9207.0   9300.0\n  94.0  188.0  282.0  376.0  470.0  564.0     9118.0  9212.0  9306.0   9400.0\n  95.0  190.0  285.0  380.0  475.0  570.0     9215.0  9310.0  9405.0   9500.0\n  96.0  192.0  288.0  384.0  480.0  576.0  …  9312.0  9408.0  9504.0   9600.0\n  97.0  194.0  291.0  388.0  485.0  582.0     9409.0  9506.0  9603.0   9700.0\n  98.0  196.0  294.0  392.0  490.0  588.0     9506.0  9604.0  9702.0   9800.0\n  99.0  198.0  297.0  396.0  495.0  594.0     9603.0  9702.0  9801.0   9900.0\n 100.0  200.0  300.0  400.0  500.0  600.0     9700.0  9800.0  9900.0  10000.0"

    # test that no spurious visual lines are added when one element spans multiple lines
    v = fill!(Array{Any}(undef, 9), 0)
    v[1] = "look I'm wide! --- "^9
    r = replstr(v)
    @test startswith(r, "9-element Vector{Any}:\n  \"look I'm wide! ---")
    @test endswith(r, "look I'm wide! --- \"\n 0\n 0\n 0\n 0\n 0\n 0\n 0\n 0")

    # test vertical/diagonal ellipsis
    v = fill!(Array{Any}(undef, 50), 0)
    v[1] = "look I'm wide! --- "^9
    r = replstr(v)
    @test startswith(r, "50-element Vector{Any}:\n  \"look I'm wide! ---")
    @test endswith(r, "look I'm wide! --- \"\n 0\n 0\n 0\n 0\n 0\n 0\n 0\n 0\n 0\n ⋮\n 0\n 0\n 0\n 0\n 0\n 0\n 0\n 0\n 0")

    r = replstr([fill(0, 50) v])
    @test startswith(r, "50×2 Matrix{Any}:\n 0  …   \"look I'm wide! ---")
    @test endswith(r, "look I'm wide! --- \"\n 0     0\n 0     0\n 0     0\n 0     0\n 0  …  0\n 0     0\n 0     0\n 0     0\n 0     0\n ⋮  ⋱  \n 0     0\n 0     0\n 0     0\n 0     0\n 0  …  0\n 0     0\n 0     0\n 0     0\n 0     0")

    # issue #34659
    @test replstr(Int32[]) == "Int32[]"
    @test replstr([Int32[]]) == "1-element Vector{Vector{Int32}}:\n []"
    @test replstr(permutedims([Int32[], Int32[]])) == "1×2 Matrix{Vector{Int32}}:\n []  []"
    @test replstr(permutedims([Dict(), Dict()])) == "1×2 Matrix{Dict{Any, Any}}:\n Dict()  Dict()"
    @test replstr(permutedims([undef, undef])) == "1×2 Matrix{UndefInitializer}:\n UndefInitializer()  UndefInitializer()"
    @test replstr([zeros(3, 0), zeros(2, 0)]) == "2-element Vector{Matrix{Float64}}:\n 3×0 Matrix{Float64}\n 2×0 Matrix{Float64}"
end
# of a subarray
a = rand(5 * 10^2, 5 * 10^2) #5 x 5
s = view(a, 2:3, 2:3) # view
p = permutedims(s, [2, 1]) #permutation 
@benchmark sum(p)

"""a = rand(5 * 10^2, 5 * 10^2)
27.711 ns (1 allocation: 16 bytes)
2.776234565017754


BenchmarkTools.Trial: 10000 samples with 996 evaluations.
 Range (min … max):  27.410 ns …  2.695 μs  ┊ GC (min … max): 0.00% … 97.07%
 Time  (median):     36.747 ns              ┊ GC (median):    0.00%
 Time  (mean ± σ):   46.968 ns ± 45.473 ns  ┊ GC (mean ± σ):  1.31% ±  1.69%

  █▇▁▁▃▆▂▂▃▁▁▂▁▂▄▅▂▁▂▁▂▂▃▂▂▁▁▁▁▁    ▁▁▁                       ▂
  ██████████████████████████████████████▇▇▇▇▇▅▆▆▅▅▅▅▅▅▆▅▅▄▅▄▅ █
  27.4 ns      Histogram: log(frequency) by time       136 ns <

 Memory estimate: 16 bytes, allocs estimate: 1.

 5 * 10, 5 * 10
BenchmarkTools.Trial: 10000 samples with 995 evaluations.
 Range (min … max):  25.729 ns …  2.042 μs  ┊ GC (min … max): 0.00% … 97.26%
 Time  (median):     28.744 ns              ┊ GC (median):    0.00%
 Time  (mean ± σ):   36.749 ns ± 38.906 ns  ┊ GC (mean ± σ):  1.47% ±  1.69%

   ▄█▅▁▃▅▄▂ ▁▂▂▁ ▁▁   ▁                                        ▁
  █████████████████████▇▇███▇███▇▇▇▆▇▆▆▆▆▅▅▅▅▅▅▅▃▄▃▄▅▅▅▅▆▅▅▅▅ █
  25.7 ns      Histogram: log(frequency) by time       115 ns <

 Memory estimate: 16 bytes, allocs estimate: 1.

"""
# ok
# of a non-strided subarray
a = reshape(1:60, 3, 4, 5)
s = view(a, :, [1, 2, 4], [1, 5])
c = convert(Array, s) #ok

for p in ([1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 1, 2], [3, 2, 1])
    @test permutedims(s, p) == permutedims(c, p)
    @test PermutedDimsArray(s, p) == permutedims(c, p) #ok
end
@test_throws ArgumentError permutedims(a, (1, 1, 1))
@test_throws ArgumentError permutedims(s, (1, 1, 1))
@test_throws ArgumentError PermutedDimsArray(a, (1, 1, 1))
@test_throws ArgumentError PermutedDimsArray(s, (1, 1, 1))
cp = PermutedDimsArray(c, (3, 2, 1))

v = view(A, :, 3, 2:5) # bounds error
@test summary(v) == "2×4 view(::Array{Int16, 3}, :, 3, 2:5) with eltype Int16"
@test Base.showarg(io, v, false) === nothing
@test String(take!(io)) == "view(::Array{Int16, 3}, :, 3, 2:5)"


r = reshape(v, 4, 2) #reshape inconsistent
@test summary(r) == "4×2 reshape(view(::Array{Int16, 3}, :, 3, 2:5), 4, 2) with eltype Int16"
@test Base.showarg(io, r, false) === nothing
@test String(take!(io)) == "reshape(view(::Array{Int16, 3}, :, 3, 2:5), 4, 2)"

@testset "showarg" begin
    io = IOBuffer()

    A = reshape(Vector(Int16(1):Int16(2 * 3 * 5)), 2, 3, 5)
    @test summary(A) == "2×3×5 Array{Int16, 3}"

    v = view(A, :, 3, 2:5)
    @test summary(v) == "2×4 view(::Array{Int16, 3}, :, 3, 2:5) with eltype Int16"
    @test Base.showarg(io, v, false) === nothing
    @test String(take!(io)) == "view(::Array{Int16, 3}, :, 3, 2:5)"

    r = reshape(v, 4, 2)
    @test summary(r) == "4×2 reshape(view(::Array{Int16, 3}, :, 3, 2:5), 4, 2) with eltype Int16"
    @test Base.showarg(io, r, false) === nothing
    @test String(take!(io)) == "reshape(view(::Array{Int16, 3}, :, 3, 2:5), 4, 2)"

    p = PermutedDimsArray(r, (2, 1))
    @test summary(p) == "2×4 PermutedDimsArray(reshape(view(::Array{Int16, 3}, :, 3, 2:5), 4, 2), (2, 1)) with eltype Int16"
    @test Base.showarg(io, p, false) === nothing
    @test String(take!(io)) == "PermutedDimsArray(reshape(view(::Array{Int16, 3}, :, 3, 2:5), 4, 2), (2, 1))"

    p = reinterpret(reshape, Tuple{Float32,Float32}, [1.0f0 3.0f0; 2.0f0 4.0f0])
    @test summary(p) == "2-element reinterpret(reshape, Tuple{Float32, Float32}, ::Matrix{Float32}) with eltype Tuple{Float32, Float32}"
    @test Base.showarg(io, p, false) === nothing
    @test String(take!(io)) == "reinterpret(reshape, Tuple{Float32, Float32}, ::Matrix{Float32})"

    r = Base.IdentityUnitRange(2:2)
    B = @view ones(2)[r]
    Base.showarg(io, B, false)
    @test String(take!(io)) == "view(::Vector{Float64}, $(repr(r)))"
end


@testset "Methods" begin
    m = which(sin, (Float64,))
    io = IOBuffer()
    show(io, "text/html", m)
    s = String(take!(io))
    @test occursin(" in Base.Math ", s)
end

module AlsoExportsPair
Pair = 0
export Pair
end

module TestShowType
export TypeA
struct TypeA end
using ..AlsoExportsPair
end

B[3, 1, 2] == A[1, 2, 3] # true

Base.@propagate_inbounds function (Base.getindex{typeof(T, N, AA, perm, iperm)}(A::PermutedDimsArray{T,N,AA,perm,iperm},  #T errors our 
    I::Vararg{Int,N}))
    getindex(A.parent, ntuple(d --> I[iperm[d]], Val{N})...) #TODO:arrow is just -->  T is not defined 
end
"""
Base.@propagate_inbounds _getindex(i, a, parent...) = (a[i], _getindex(i, b'...)...)
_getindex(i) = ()
"""


m = 1;
n = 10;
a = ones(n, m)
b = ones(m, n)

#--- permutation

parent = [a b']
perm = sqrt.(parent)

iperm = perm .^ 2
P = PermutedDimsArray{a,n,parent,perm,iperm}





@time res1 = dotop1(a, b)
"""  0.691503 seconds (1.10 M allocations: 56.898 MiB, 9.34% gc time, 99.99% compilation time)
10×10 BitMatrix
on rerun:
 0.000039 seconds (2 allocations: 144 bytes)
10×10 BitMatrix
"""

using BenchmarkTools
function dotop2(a, b)
    @benchmark a .== b
end
res2 = dotop2(a, b)



"""
BenchmarkTools.Trial: 10000 samples with 136 evaluations.
 Range (min … max):  708.824 ns … 98.607 μs  ┊ GC (min … max): 0.00% … 98.60% 
 Time  (median):     963.235 ns              ┊ GC (median):    0.00%
 Time  (mean ± σ):     1.143 μs ±  1.564 μs  ┊ GC (mean ± σ):  2.79% ±  2.19%
   █            
  ▃█▅▄▆▆▃▂▃▂▂▂▂▃▃▄▄▄▄▃▃▃▂▂▂▂▂▂▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁ ▂
  709 ns          Histogram: frequency by time         2.78 μs <

 Memory estimate: 208 bytes, allocs estimate: 4.
"""
res3 = @btime a .== b # how to store it's values 
"""
 rerun:

BenchmarkTools.Trial: 10000 samples with 138 evaluations.
 Range (min … max):  710.145 ns … 59.049 μs  ┊ GC (min … max): 0.00% … 96.91% 
blue Time  (median):     841.304 ns              ┊ GC (median):    0.00%
green Time  (mean ± σ):     1.019 μs ±  1.329 μs  ┊ GC (mean ± σ):  2.98% ±  2.39%
  ▇█▆▅▅▅▅▃▄▄▄▃▃▃▃▃▃▃▃▃▂▂▁▁▁▁▁▁ ▁▁                              ▂
  ███████████████████████████████████▇█▇▇▇▇▆▇▆▇▆▆▅▅▆▅▄▆▄▃▅▄▄▄▄ █
  710 ns        Histogram: log(frequency) by time      2.47 μs <

 Memory estimate: 208 bytes, allocs estimate: 4.
 
where blue < green  (if there's a way to compare both distributions 
including 
the most frequency
blue line marker (median)
gren line marker (mean ± σ)  (alas, porvocu)
Notice: different runs yeilds hugely different discrepencies 
(that may Hugely affect performance, on medium & long-run)
#TODO: get @btime's output 

check stabiltiy way of code coding ,...

reliability vs stanility 
 """
#General code isa good but isa not entirely free of Overhead 

#from (undiscovered source) 


#test a 'dumb wrapper'
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
A = rand(5, 7, 3)#  A is a 3D Array , you can create subarray (view)
B = view(A, 2:3, 4, 1:2) #view shoould be 2D (kernel) 2 by 2

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
    x = rand(5,5)
    newinds ↦ (newinds..., x) # instead of push!(newinds,x)
    B[inds...] ↦ A[reindex(inds, B.indexes...)...]
    inds = (2, 2)
    B.indexes = (2:3, 4, 1:2)
    #changing index:
    Base.reindex(( 2, 2), 2:3, 4, 1:2) ↦
    (3, Base.reindex((2,), 4, 1:2)...) ↦
    (3, 4, Base.reindex((2,), 1:2)...) ↦
    (3, 4, 2, Basse.reindex(())) ↦
    (3, 4, 2)
end

"""
reindex ha to bee type-aware 
"""

"""
reshapedArray 

a neww type array   alwaay returns the view of array 
regardless A type 
"""
B = reshape(A, (4,5,7))

B[i,j,k] --> B[l] - A[l]

where l = subsizr(B, i , j, k) # convert into linear index

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
ncl tp cartisian ind for th array 
    """
reverse invvolvs rrrrrrgivions slow 


added recetly v fast ingteg dimension

# function 
#focus on iteration 

function mysum(θ)

    s = 0.0
    for I in eachindex(θ)
        s += B[I]
    end
    s

    humor
    go back to original patter 

    indexes