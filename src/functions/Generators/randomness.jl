
"""
#= credits to:
M. Tamas K. Paap [PhD] @tpap, for the idea of  randvector & randmatrix ( plus the tip of reading the docs)

References:
-Random Int(64):
https://stackoverflow.com/questions/24326876/generating-a-random-integer-in-range-in-julia

"""
function shiftRight(startingHex = 0x2f, offset = 0x1f, h = [+, -])

    return (x >>> (startingHex + offset)) #| (x << (0x3f & k))
end
startingHex = 0x2f;
offset = 0x1f;
_op = [+, -]
op
:op
eval()
function shiftRight(startingHex = 0x2f, offset = 0x1f, K = -k, op = [+, -])
    return (x >>> (startingHex + offset + 0x3f & K)) #| (x << (0x3f & k))
end

# @double1010x2 #for a common xorshift manupulator #removing the unrelated 
@inline xorshift_rotl(x::UInt64, k::Int) = (x >>> (0x3f & -k)) | (x << (0x3f & k)) #a commons move for a permutation 
@inline xorshift_rotl(x::UInt32, k::Int) = (x >>> (0x1f & -k)) | (x << (0x1f & k))


#----

using Random, StableRNGs
#LehmerRNG

"""

Construction: `StableRNG(seed::Integer)`.
Seeding: `Random.seed!(rng::StableRNG, seed::Integer)`.
"""
seed = 12346543975
"""
AbstractRNG not defined 
"""

global rng = StableRNG(seed)
A = randn(rng, 10, 10) # instead of randn(10, 10)
@test inv(inv(A)) ≈ A

#---
mutable struct LehmerRNG <: AbstractRNG
    state::UInt128

    LehmerRNG(seed::Integer) = seed!(new(), seed)

    function LehmerRNG(; state::UInt128)
        isodd(state) || throw(ArgumentError("state must be odd"))
        new(state)
    end
end

#--- rng: declare
rng = StableRNG(seed)
A = randn(rng, 10, 10) # instead of randn(10, 10)
@test inv(inv(A)) ≈ A
#after rng  geneerator 
#generic sampler 
"""
"Random.SamplerType" & "Random.SamplerTrivial" are Default Fallbacks for types and values, respectively. 
Random.SamplerSimple can be used to store pre-computed values,
without defining extra types for only this purpose.
"""
Random.rand(rng::AbstractRNG, d::Random.SamplerTrivial{Die}) = rand(rng, 1:d[].nsides); #tested #works 

function StableSampler(rng) 
end
    #const StableRNG = LehmerRNG

    #--- seed

    function seed!(rng::LehmerRNG, seed::Integer)
        seed >= 0 || throw(ArgumentError("seed must be non-negative"))
        seed <= typemax(UInt64) ||
        # this constraint could be loosened a bit if requested
            throw(ArgumentError("seed must be <= $(typemax(UInt64))"))

        seed = ((seed % UInt128) << 1) | one(UInt128) # must be odd
        rng.state = seed
        rng
    end

    Base.show(io::IO, rng::LehmerRNG) =
        print(io, LehmerRNG, "(state=0x", string(rng.state, base = 16, pad = 32), ")")

    function Base.copy!(dst::LehmerRNG, src::LehmerRNG)
        dst.state = src.state
        dst
    end

    #--- 

    """
    export genericGenerator, randMatrix, randVector, randvalue
    
    using Random;
    using StableRNGs;
    # e1e8635157374d87126d9d13be15a2679bccb5f0
    """
    export genericGenerator, randvalue, randMatrix, randVector, randvaluerandtemplate
    global seed = 1234
    global rng = StableRNG(seed)

    module randomness
    """
    TODO(1):change non-existing MersenneTwister to anything else...
    TODO(3): If is persistent, do Not Reseed (dedault: otherwise reseed) #later 
    """
    function randtemplate(seed = 1234, rng = MersenneTwister(seed), ispersistent = yes)
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

    function randvalue(min = 1::Int64, max = 10::Int64, s = []::Int64, rng = MersenneTwisters(seed))


        return randsubseq(rng, 3, min:max) #ok# change rng 
        #return rand(min:max) # returns a single value x ∈ [min,max]

    end

    randvalue()

    function randvalue(_min = 1::int64, _max = 10::Int64)
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
        # rand(rng,_min,_max)
        A = rand(rng, _min, _max)
        return A # returns a single value  x ∈ [min,max]

    end

    randvalue(rng, 0, 1) #test


    """
       Returns a single Vector Uniformly
    
       Example: randVector(_1::Int64, _max = 10::Int64, n = 10::Int64
       
    
      #TODO: Test the output 
    """
    function randVector(_min = 1::Int64, _max = 10::Int64, n = 10)

        return rand(_min:_max, n) # 1D array - n-element Array{Int64,1}
    end


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
    function randMatrix(a = 10, b = 11, min = 1::Int64, max = 10::Int64)

        return rand(min:max, a, b)
    end



    end


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

    permutate(rng)

    #--- testing 4
    #permutate(MersenneTwisters(1234,n)

    #randvalue(min = 1, max = 10, rng = )#TODO: uncomment lated 

    #randvalue(1, 10,  1234, MersenneTwisters(1234),  []) #MersenneTwister has been removed in julia 1.7 

    #--- 

    """
        LehmerRNG
        StableRNG
    Simple RNG with stable streams, usually suitable for testing.
    Use only the alias `StableRNG`, as the name `LehmerRNG` is not
    part of the API.
    Construction: `StableRNG(seed::Integer)`.
    Seeding: `Random.seed!(rng::StableRNG, seed::Integer)`.
    """
    mutable struct randomRNG <: AbstractRNG
        state::UInt64

        randomRNG(seed::Integer) = seed!(new(), seed)

        function LehmerRNG(; state::UInt128)
            isodd(state) || throw(ArgumentError("state must be odd"))
            new(state)
        end
    end

    state #2 cannot declare a constant, it has already a value 
    #const StableRNG = LehmerRNG #invalid redefinition 


    function seed!(rng::LehmerRNG, seed::Integer)
        seed >= 0 || throw(ArgumentError("seed must be non-negative"))
        seed <= typemax(UInt64) ||
        # this constraint could be loosened a bit if requested
            throw(ArgumentError("seed must be <= $(typemax(UInt64))"))

        seed = ((seed % UInt128) << 1) | one(UInt128) # must be odd
        rng.state = seed
        rng
    end

    print(seed!(stableRNG, seed))

    Base.show(io::IO, rng::LehmerRNG) =
        print(io, LehmerRNG, "(state=0x", string(rng.state, base = 16, pad = 32), ")")

    function Base.copy!(dst::LehmerRNG, src::LehmerRNG)
        dst.state = src.state
        dst
    end

    Base.copy(src::LehmerRNG) = LehmerRNG(state = src.state)

    Base.:(==)(x::LehmerRNG, y::LehmerRNG) = x.state == y.state

    Base.hash(rng::LehmerRNG, h::UInt) = hash(rng.state, 0x93f376feff2bc48e % UInt ⊻ h)


    ## Sampling

    rng = LehmerRNG()

    function rand(rng::LehmerRNG, ::SamplerType{UInt64})
        rng.state *= 0x45a31efc5a35d971261fd0407a968add
        (rng.state >> 64) % UInt64
    end

    for T = [Bool, Base.BitInteger64_types...]
        T === UInt64 && continue
        @eval rand(rng::LehmerRNG, ::SamplerType{$T}) = rand(rng, UInt64) % $T
    end

    rand(rng::LehmerRNG, ::SamplerType{UInt128}) =
        rand(rng, UInt64) | ((rand(rng, UInt64) % UInt128) << 64)

    rand(rng::LehmerRNG, ::SamplerType{Int128}) = rand(rng, UInt128) % Int128

    Random.rng_native_52(::LehmerRNG) = UInt64


    #--- within a range

    # adapted verion of Random.SamplerRangeFast for native 64 bits generation
    # we don't use "near division-less algorithm", as it doesn't work for Int128,
    # and we want to maintain as little code as possible here

    using Base: BitUnsigned, BitInteger
    using Random: LessThan, Masked, uniform

    struct SamplerRangeFast{U<:BitUnsigned,T<:BitInteger} <: Sampler{T}
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

    function rand(rng::LehmerRNG, sp::SamplerRangeFast{UInt64,T}) where {T}
        a, bw, m, mask = sp.a, sp.bw, sp.m, sp.mask
        x = rand(rng, LessThan(m, Masked(mask, uniform(UInt64))))
        (x + a % UInt64) % T
    end

    function rand(rng::LehmerRNG, sp::SamplerRangeFast{UInt128,T}) where {T}
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


#--- 
