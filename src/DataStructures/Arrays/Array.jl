"""
Credits:

 Tim Holy - JuliaCon 2016 


"""


"""
transformations are a
#1: vectorized functions -Heratige of programming languages operates element-wise on the array 

amounts: Viewd as  not desirable 
    -Explicit mapping function  (over the elements)
    --vectorized functions
"""


"""

Meaning#1 
the best optimization is 
not Doing the Computation 
(at ll)

gregory 
scotland Yard detcctiv 
is thr any othr point 
which you wish to draw my attention 

Holmes: the curious incidnt of the dog in th night-time 

gregory: th dog did nothing in th night-time 
Holmes: that was th curious incident
- silver blaze - conan Doyle
"""
A = rand()
sqrt(A)         #implicit element-wise computation

map(sqrt, A)    #explicit element-wise computation 

B = mappedarray(sqrt, A)
B = mappedarray(func, a)

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
    just compute on the onee I'm zoomed in , looking at a particular moment )]

    #Defining a new array type

    immu
mapped array isa substype of abstract array type 
-has 2 in it 
1 function 
2. original array (we wanting to Create a view of )

array: defines a containes
"""

include("MappedArrays.jl")

struct Mappedarray{T,N,A<:AbstractArray,f::Int...} <: AbstractArray{T,N}
    f:Int...
    data::A
end

struct Mappedarray{T,N,A<:AbstractArray,F<: AbstractArray{T,N}
    f:F
    data::A
end

"""

notice F is representation 
julia's compileer 
knows 
ther is a fucntion ( stroed in this objct)
2.which function it is 
this give
"""
Base.@propagate_inbounds Base.getindex(A::Mappedarray, i::Int...) =
    A.f(A.data[i...])#function call


"""

define what happens when you actually 
want to take a value of it right ?
this is the line that defines the bracket operation 

whn you actually extract values from it 

D efined in this way , there are a few v. important 
details 
see: blake 
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
@deprecate mappedarray(f_finv::Tuple{Any,Any}, args::AbstractArray...) mappedarray(f_finv[1], f_finv[2], args...)
Mappedarray{T,N}(f, data::AbstractArray{T,N}) = Mappedarray{typeof(f(one(T))),N,typeof(data),typeof(f)}(f, data)

Base.size(A::AbstractMappedArray) = size(A.data)

#size( original data ), you hav be abl to construct them 

"""
this is the line you need for the constructor 

for a bare-bones impleementation , this is it- that's all you need to do
    to create one of these views that 
    computes arbitrary function, on the datatransformation 
        -static transformation is alomost every where 
Matt Baumann method:
get index
"""


Base.@propagate_inbounds Bas.getindex(A::Mappedarray, 1::Int...) =
    A.f(A.data[1...])

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