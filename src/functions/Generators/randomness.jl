
#= credits to:
M. Tamas K. Paap [PhD] @tpap, for the idea of  randvector & randmatrix ( plus the tip of reading the docs)

References:
-Random Int(64):
https://stackoverflow.com/questions/24326876/generating-a-random-integer-in-range-in-julia

#(possible) bitwise operation 
=#

export genericGenerator, randvalue, randMatrix, randVector, randvaluerandtemplate
module randomness


function shiftRight(startingHex = 0x2f, offset = 0x1f, h = [+, -])

    return (x >>> (startingHex + offset)) #| (x << (0x3f & k))
end
startingHex = 0x2f
offset = 0x1f
_op = [+, -]
#op
#:op
#eval()
function shiftRight(startingHex = 0x2f, offset = 0x1f, K = -k, op = [+, -])
    return (x >>> (startingHex + offset + 0x3f & K)) #| (x << (0x3f & k))
end

# @double1010x2 #for a common xorshift manupulator #removing the unrelated 
@inline xorshift_rotl(x::UInt64, k::Int) = (x >>> (0x3f & -k)) | (x << (0x3f & k)) #a commons move for a permutation 
@inline xorshift_rotl(x::UInt32, k::Int) = (x >>> (0x1f & -k)) | (x << (0x1f & k))

#----

# delegation of samplers

#=
    rand!(::AbstractRNG, ::Sampleable, ::AbstractArray)
Samples in-place from the sampler and stores the result in the provided array.
=#
#rand!(::AbstractRNG, ::Sampleable, ::AbstractArray)

#=
    rand(::AbstractRNG, ::Sampleable)
Samples from the sampler and returns the result.
=#
rand(T::Type{AbstractRNG}, S::Type{Sampleable}) #error invalid :: Syntax #works

struct Bar{T}
    (T::Type{Bar{S}})() where {S} = new{T.parameters[1]}()
end

Bar{T}() where {T}

#----

using Random, StableRNGs, Test
#LehmerRNG

"""

Construction: `StableRNG(seed::Integer)`.
Seeding: `Random.seed!(rng::StableRNG, seed::Integer)`.
"""
seed = 12346543975
"""
AbstractRNG not defined 
"""
function sumArray(A, range = 1:12)
    return [sum(A .== i) for i = range]
end
global rng = StableRNG(seed)
A = randn(rng, 10, 10) # instead of randn(10, 10)
m = rand(rng, 1:12, 20)
@test inv(inv(A)) ≈ A

sum
_error = inv(inv(A)) - A

#TODO: 1 liner sum 

# [sum()]


#---
#=
mutable struct LehmerRNG <: AbstractRNG
    state::UInt128

    LehmerRNG(seed::Integer) = seed!(new(), seed)

    function LehmerRNG(; state::UInt128)
        isodd(state) || throw(ArgumentError("state must be odd"))
        new(state)
    end
end
=#
using StableRNGs, Random, Test
#--- rng: declare
seed = 3257946
rng = StableRNG(seed)
A = rand(rng, 10, 10) # instead of randn(10, 10)
@test inv(inv(A)) ≈ A

#--- sampler 

maxcount = 100
range = 1:20
sp = Random.Sampler(rng, range) # define a sampler or Random.Sampler(MersenneTwister, 1:20) 
for x in enumerate(maxcount)
    n = rand(rng, sp) # similar to n = rand(rng, 1:20)
    # use n
end
sp

#--- Generate values from sampler 

struct Die
    nsides::Int # number of sides
end

#=
struct Die
    #face
    number = 1:6
end

Random.rand(::Random.SamplerType{Die}, number, rng = StableRNG(seed)::StableRNG, range = min(Die.number):max(Die.number)) = Die(rand(StableRNG(seed), range))
end
=#
# out


rand(Die.number)
rand(rng, Die.number)
rand(MersenneTwister(0), Die) #potentially 2 different  rvs 
Die(11)

rand(Die.number, 3)

a = Vector{Die}(undef, 3)
rand!(a)

#after rng  geneerator 
#generic sampler 
#= StableSampler
"Random.SamplerType" & "Random.SamplerTrivial" are Default Fallbacks for types and values, respectively. 
Random.SamplerSimple can be used to store pre-computed values,
without defining extra types for only this purpose.
using Random, StableRNGs=#
stablerng = Random.rand( StableRNG(seed), d::Random.SamplerTrivial{Int}) = rand(rng, 1:d[].nsides) #tested #works #{Die} # used AbstractRNG (not StableRNG) 

function StableSampler(rng = rng) end #create an empty sampler 
#const StableRNG = LehmerRNG

#--- seed

function seed!( StableRNG(seed), seed::Integer)
    seed >= 0 || throw(ArgumentError("seed must be non-negative"))
    seed <= typemax(UInt64) ||
    # this constraint could be loosened a bit if requested
        throw(ArgumentError("seed must be <= $(typemax(UInt64))"))

    seed = ((seed % UInt128) << 1) | one(UInt128) # must be odd
    rng.state = seed
    rng
end

Base.show(io::IO, rng = StableRNG(seed)::StableRNG) =
    print(io, LehmerRNG, "(state=0x", string(rng.state, base = 16, pad = 32), ")")

function Base.copy!(dst = StableRNG(seed), src=S::StableRNG)
    dst.state = src.state
    dst
end

#--- 

#=
export genericGenerator, randMatrix, randVector, randvalue

using Random;
using StableRNGs;
# e1e8635157374d87126d9d13be15a2679bccb5f0
=#


global seed = 1234
global rng = StableRNG(seed) #defaults to LehmerRNG - StableRNG should be specified  # new- display error LehmerRNG not defined 

#= module randomness =#
"""
TODO(1):change non-existing MersenneTwister to anything else...
TODO(3): If is persistent, do Not Reseed (dedault: otherwise reseed) #later #how to not reseed???
"""
function randtemplate(seed = 1234, ispersistent = yes)
    return rng(seed)
end

"""
Returns a single value

```Inputs: 

    rng(seed) Random Number Generator 
    _min:_max: range any 

    Note: Max must be Bounded

        # 1, 10,  1234, MersenneTwister(seed),  []
    #TODO: fill an array
"""
function randvalue(rng = StableRNG(seed), m = 5, n = 5, s = rand(m, n), p = 0.4) #working 


    return randsubseq(rng, s, p) #ok# change rng 
    #return rand(min:max) # returns a single value x ∈ [min,max]

end

res = randvalue() #ERROR: Type Assert 
"""
returns a single value
    returns a single Vector

```inputs:

_min: minimum   , integer , Int64
_max: maximum   , integer , Int64
n:    Number of samples Int64 integer

Note: both maximum & minimum are assumed to be Reachable
  
e.g.
1. (There are) no Discontinuities at both bounds , & 
2. Anomalies' (_min's & _max's) value is Reachable


note: max must be Bounded
```Inputs:
min : minimum value  ::Int64 
max:  maimum value  ::Int64

TODO(2): return a Float  between 2 Integers x ∈ [min,max]
"""
#=
function randvalue(rng = StableRNG(seed), _min = 1::int64, _max = 10::Int64)

    # rand(rng,_min,_max)
    A = rand(rng, _min, _max) #ERROR:sampler is not defimed 

    return A # returns a single value  x ∈ [min,max]

end

r = randvalue(StableRNG, 1, 2) #test
=#

"""
   Returns a single Vector Uniformly

   Example: randVector(_1::Int64, _max = 10::Int64, n = 10::Int64
   

  #TODO: Test the output 
"""
function randVector(rng = StableRNG, _min = 1, _max = 10, n = 10)

    return rand(rng, _min:_max) # 1D array - n-element Array{Int64,1}
end
randVector()

function randVector(_min = 1::Int64, _max = 10::Int64, n = 10::Int64)

    return rand(_min:_max, n) # 1D array - n-element Array{Int64,1}

end


""" 
 Returns a single Vector with n 
"""

function randVector(_min = 1::Int64, _max = 10::Int64, n = 10::Int64)

    return rand(_min:_max, n) # 1D array - n-element Array{Int64,1}

end

"""
 Returns a single Matrix (2D - Array)
"""
#=
function randMatrix(rng = StableRNG(seed), min = 1::Int64, max = 10::Int64, a = 10, b = 11)

    return #=rand(rng, min:max, a, b)=#
end
=#

rand(StableRNG(seed), min, max, 10, 10)

"""
Returns a single Matrix (2D - Array)

"""
function randMatrix(_min = 1::Int64, _max = 10::Int64)

    return rand(_min:_max, n)
end

"""
Returns a single Matrix (2D - Array)
range(start[, stop]; length, stop, step=1)
range(1, step=5, length=100)
range(1, step=5, length=100)
"""
function randMatrix(r = _min:_max::range(Int64, Int64)) #::range(Int64,Int64))
    r = _min:_max
    #do a computation
    return rand(r, 2)
end

#=
function randArray(r = _min:_max)

        r = _min:_max
    #do a computation
    return r
=#

#--- helper functions 

function permutate(rng = StableRNG(seed), n = 10) #sanity-check #where's the input? (value,Vector,...)
    return randperm(rng(seed), n)
end

permutate(StableRNG)

#--- testing 4
#permutate(MersenneTwisters(1234,n)

#randvalue(min = 1, max = 10, rng = )#TODO: uncomment lated 

#randvalue(1, 10,  1234, MersenneTwisters(1234),  []) #MersenneTwister has been removed in julia 1.7 

#--- 

#=
    LehmerRNG
    StableRNG
Simple RNG with stable streams, usually suitable for testing.
Use only the alias `StableRNG`, as the name `LehmerRNG` is not
part of the API.
Construction: `StableRNG(seed::Integer)`.
Seeding: `Random.seed!(rng::StableRNG, seed::Integer)`.
=#
mutable struct randomRNG <: StableRNGs #  AbstractRNG
    state::UInt64

    randomRNG(seed::Integer) = seed!(new(), seed)

    #if redundant, please do Delete 
    function StableRNG(; state::UInt128)
        isodd(state) || throw(ArgumentError("state must be odd"))
        new(state)
    end
end

state #2 cannot declare a constant, it has already a value 
#const StableRNG = LehmerRNG #invalid redefinition 


function seed!(seed::Integer,rng=StableRNG(seed) )
    seed >= 0 || throw(ArgumentError("seed must be non-negative"))
    seed <= typemax(UInt64) ||
    # this constraint could be loosened a bit if requested
        throw(ArgumentError("seed must be <= $(typemax(UInt64))"))

    seed = ((seed % UInt128) << 1) | one(UInt128) # must be odd
    rng.state = seed
    rng
end
using StableRNGs
print(seed!(StableRNG(seed), seed))# something seems off - 

Base.show(io::IO, rng = StableRNG::stableRNG) =
    print(io, StableRNG, "(state=0x", string(rng.state, base = 16, pad = 32), ")") # how state can be relevant ( to my situation?)

function Base.copy!(dst = StableRNG::stableRNG, src = StableRNG::stableRNG)
    dst.state = src.state #copy state 
    dst
end

Base.copy(src = StableRNG(seed)::stableRNG) = stableRNG(state = src.state)

Base.:(==)(x = StableRNG(seed)::stableRNG, y = 

StableRNG(seed) = x.state == y.state #y.state is indifferent , honestly 


hash = Base.hash( StableRNG(seed)::StableRNG, h::UInt) = hash(rng.state, 0x93f376feff2bc48e % UInt ⊻ h)


## Sampling

using StableRNGs
#=
rng = StableRNG(seed = 1234, state = randState()) # cyclic code detected: State not asssignment (state dependent method )# self-referencing detected: randState()requires StableRNG,with StableRNG requires RandomState ! 
=#

function randState(rng)#::SamplerType{UInt128})
    rng.state *= 0x45a31efc5a35d971261fd0407a968add
    return (rng.state >> 64) % UInt128 #waiting UInt128 ! (i cannot comfortably work with that - too much on the memory)
end

function isEqual(rng, ::SamplerType{T}) #ok #SamplerType #TODO: define 


    for T = [Bool, Base.BitInteger64_types...]
        T === UInt128 && continue
        @eval rand(rng::stableRNG, ::SamplerType{$T}) = rand(rng, UInt128) % $T
    end

end
rand(rng::stableRNG, ::SamplerType{UInt64}) = #UInt128 is bit too large for my requirements  
    rand(rng, UInt64) | ((rand(rng, UInt64) % UInt128) << 64)

rand(rng::stableRNG, ::SamplerType{UInt64}) = rand(rng, UInt128) #Int128  

Random.rng_native_52(::stableRNG(seed)) = UInt64


#--- within a range

# adapted verion of Random.SamplerRangeFast for native 64 bits generation
# we don't use "near division-less algorithm", as it doesn't work for Int128,
# and we want to maintain as little code as possible here

using Base: BitUnsigned, BitInteger
using Random: LessThan, Masked, uniform

struct SamplerRangeFast{U<:BitUnsigned,T<:BitInteger} <: Sampler{T} # define  a sampler 
    a::T      # first element of the range
    bw::UInt  # bit width
    m::U      # range length - 1
    mask::U   # mask generated values before threshold rejection
end

SamplerRangeFast(r::AbstractUnitRange{T}) where {T<:BitInteger} =
    SamplerRangeFast(r, T <: Base.BitInteger64 ? UInt64 : UInt128)

function SamplerRangeFast(r::AbstractUnitRange{T}, ::Type{U}) where {T,U}
    isempty(r) && throw(ArgumentError("range must be non-empty"))
    m = (last(r) - first(r)) % unsigned(T) % U
    #                        ^--- % unsigned(T) to not propagate sign bit
    bw = (sizeof(U) << 3 - leading_zeros(m)) % UInt # bit-width
    mask = ((1 % U) << bw) - (1 % U)
    SamplerRangeFast{U,T}(first(r), bw, m, mask)
end

function rand(rng=StableRNG:StableRNG, sp::SamplerRangeFast{UInt64,T}) where {T}
    a, bw, m, mask = sp.a, sp.bw, sp.m, sp.mask
    x = rand(rng, LessThan(m, Masked(mask, uniform(UInt64))))
    (x + a % UInt64) % T
end

#--- 
function rand(rng=StableRNG()::StableRNG, sp::SamplerRangeFast{UInt128,T}) where {T}
    a, bw, m, mask = sp.a, sp.bw, sp.m, sp.mask
    x = bw <= 64 ?
        rand(rng,
        LessThan(m % UInt64,
            Masked(mask % UInt64, uniform(UInt64)))) % UInt128 :
        rand(rng, LessThan(m, Masked(mask, uniform(UInt128))))
    x % T + a
end

function unknownOne()
    for T in Base.BitInteger_types
        # eval because of ambiguities with `where T <: BitInteger`
        @eval Sampler(::Type{LehmerRNG}, r::AbstractUnitRange{$T}, ::Random.Repetition) =
            SamplerRangeFast(r)
    end

end
end 
