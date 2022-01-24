#=
references:

=#

using random
include("randomness.jl")# fixed: missing .jl !

module generator()

export genericGenerator,randMatrix,randVector,randvalue

 ```
    mimicing a caglag, range(d) Process
    ("continue à droite, limite à gauche")
    starts from 1 - the origin (not 0?) #TODO:Check

    generates 


    Input;
    GenericModel: Must be a Smooth Function:
    1. (Continuous on all Interval)
    2. Differentiable on all Interval 
    TODO: Add an Appropriate Differentiable module                                       

    ```

function genericGenerator(sampleSize = 300, _min = 1.0, _max = 10.0, genericModel(x) = exp(-x))
    ```
    PDF must play a role here
    as 
    TODO: use the argument 'genericModel' in a useful function  - does it need another loop?
    ```
    
    x = linspace(_min, step, _max)
    y = zeros(length(x))
    z=nothing
    a = nothing;b=nothing
    for i = 1 in sampleSize # <= sampleSize #generate sample
        #initializes with a vector (TODO:Q.why a vector? isn't a point enough | this context?) - maybe that is the main problem
        b = randVector(_min, _max)
        c = copy(b)
        a = a(a, b)
        j = x[i]
        y = genericModel(j)
    
    
    end

    x = linspace(_min, step, _max)

    y = zeros(length(x))
  

    return a
end

function createRange(start, stop, length, step)
    return range(start, stop; length, step)
end

```
TODO: we need to figure out 
-the approach of doing the ziggurat
-which RNG to use 

needs at least 2 loops
```
function genSample(sampleSize=50::Int64,min=0.0,max=1.0)
 #range(min=0, stop=max; length=max, step=1)
a= nothing
    for i in enumerate(sampleSize) #range(start=min, stop=max; length=max-min, step=1)    # sampleSize +1 & i < max+1 : #generate sample
       # for #TODO: 
        #initializes with a vector (TODO:Q.why a vector? isn't a point enough | this context?) - maybe that is the main problem
        a= (a, randVector(min,max))

    end
end

 end

#---- testing area -- craziness allowed

using Random, StableRNGs,Test
lobound =  1
upbound = 128
stepSize = 1 # TODO: which steepsize
# 1 is the least Positive integer in Julia
# thus its the best in this contest
#--- rng
```
Reproducibility

By using an RNG parameter initialized with a given seed,
you can reproduce the same pseudorandom number sequence

when running your program multiple times. However,
a minor release of Julia (e.g. 1.3 to 1.4)

may change the sequence of pseudorandom numbers
generated from a specific seed,

 in particular if MersenneTwister is used.
 (Even if the sequence produced by a low-level function

 like rand does not change, the output of higher-level
 functions like randsubseq may change due to algorithm updates.)

Rationale: guaranteeing that pseudorandom streams never change
"Prohibits many algorithmic improvements"

If you need to guarantee exact reproducibility of random data, it is advisable to simply save the data (e.g. as a supplementary attachment in a scientific publication). (You can also, of course, specify a particular Julia version and package manifest, especially if you require bit reproducibility.)

Software tests that rely on specific "random" data should also generally either save the data, embed it into the test code, or
use third-party packages like StableRNGs.jl.
 On the other hand, tests that should pass for most random data (e.g. testing A \ (A*x) ≈ x for a random matrix A = randn(n,n))
 can use an RNG, with a fixed seed, to ensure that simply running the test many times does not encounter a failure due to very improbable data (e.g. an extremely ill-conditioned matrix).

The statistical distribution from which random samples are drawn is guaranteed to be the same across any minor Julia releases.

```
using Random
seed = 1234; x1= rand(2)# 2 random variables
rng()
rng = MersenneTwister(seed); rand(rng, 2) == x1
reseed = Random.seed!(1234);
Random.seed!(MersenneTwister(seed), seed) # (should be) a reproducible condition
rand(rng, 2) == x1

seed1 = rand(Random.seed!(rng), Bool) # not reproducible

seed2 = rand(Random.seed!(rng), Bool) # (not) reproducible

seed3 = rand(MersenneTwister(), Bool) # not rng has no seed. Infer reproducible either

#---StableRNG - for stability
```
StableRNG is currently an alias for LehmerRNG,
and implements a well understood
linear congruential generator (LCG);
an LCG is not state of the art,
but is fast and is believed to have
reasonably good Statistical Properties [1],
suitable at least for tests of a wide range of packages.
The choice of this particular RNG is based on its simplicity,
 which limits the chances for bugs. Note that only
StableRNG is exported from the package,
& should be the only type used in client code;
LehmerRNG might be renamed, or might be made a
distinct type from StableRNG in any upcoming minor
(i.e. non-breaking) release.
```
rng = StableRNG(123)
A = randn(rng, 10, 10)
num1 = randn(rng, 1)
num2=randn(rng,1) # instead of randn(10, 10)
@test inv(inv(A)) ≈ A
#---range
range1(a=lobound,b=upbound) = lobound:stepSize:length(upbound)
Random.Sampler
rand(range1)


range2(a=lobound,b=upbound) = (lobound in Base.range(lobound,upbound;(upbound-lobound),stepSize))

##r range1(2,8)

rand([rng=GLOBAL_RNG],[r])

#--- Base.://
Function
//(num=3, den=5)
"""
Divide two integers or rational numbers, giving a Rational result.
"""



#---range


function range_step_stop_length(a,step, len::Integer)
    start = a - step * (len - oneunit(len))
    if start isa Signed
        # overflow in recomputing length from stop is okay
        return StepRange{typeof(start),typeof(step)}(start, step, convert(typeof(start), a))
    end
    return StepRangeLen{typeof(start),typeof(start),typeof(step)}(start, step, len)
end

for i in range(1000)
	@test(range_step_stop_length)

end
# Stop and length as the only argument
function range_stop_length(start,a, len::Integer)
        # overflow in recomputing length from stop is okay

    return StepRangeLen{typeof(start),typeof(start),typeof(step)}(start, step, len)
end
# Stop and length as the only argument

a=0;b=100;len = length(b - a)
#working 
function range_stop_length(a=0,b=100)
# Start and length as the only argument

	type_b = typeof(b) # ge type
    return StepRangeLen{type_b,typeof(a)}(a, step, len)
end

#---- task
#define a sampler 
@inline function rand(::TaskLocalRNG, ::SamplerType{UInt64})
    task = current_task()
    s0, s1, s2, s3 = task.rngState0, task.rngState1, task.rngState2, task.rngState3
    tmp = s0 + s3
    res = ((tmp << 23) | (tmp >> 41)) + s0
    t = s1 << 17
    s2 = xor(s2, s0)
    s3 = xor(s3, s1)
    s1 = xor(s1, s2)
    s0 = xor(s0, s3)
    s2 = xor(s2, t)
    s3 = s3 << 45 | s3 >> 19
    task.rngState0, task.rngState1, task.rngState2, task.rngState3 = s0, s1, s2, s3
    res
end


#--- TaskLocalRNG

# Shared implementation between Xoshiro and TaskLocalRNG -- seeding

function seed!(rng::Union{TaskLocalRNG,Xoshiro})
    # as we get good randomness from RandomDevice, we can skip hashing
    rd = RandomDevice()
    setstate!(rng, rand(rd, UInt64), rand(rd, UInt64), rand(rd, UInt64), rand(rd, UInt64))
end


function seed!(rng::Union{TaskLocalRNG,Xoshiro}, seed::Union{Vector{UInt32},Vector{UInt64}}) # TaskLocalRNG defined 
    c = SHA.SHA2_256_CTX()
    SHA.update!(c, reinterpret(UInt8, seed))
    s0, s1, s2, s3 = reinterpret(UInt64, SHA.digest!(c))
    setstate!(rng, s0, s1, s2, s3)
end

seed!(rng::Union{TaskLocalRNG, Xoshiro}, seed::Integer) = seed!(rng, make_seed(seed))

#= TaskLocalRNG is undfined for  julia 1.6.5
@inline function rand(rng::Union{TaskLocalRNG, Xoshiro}, ::SamplerType{UInt128})
    first = rand(rng, UInt64)
    second = rand(rng,UInt64)
    second + UInt128(first)<<64
end
=#
#--- convertions

function array2vector1(T::Any)
return irr(vec(Float64.(T)))
rationalize(vec(Float64.(T)))
end
function array2vector2(T::Any)
return
Float64.(vcat(T[1], vec(T[2])))
end
