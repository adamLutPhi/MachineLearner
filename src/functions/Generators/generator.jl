#=
references:

=#
#using Rebugger

using Random, Test, StableRNGs, BenchmarkTools #94 dependencies omg  #ERROR: Init nomethod matching TOMLCache #possibly from Rebugger or #UNKNOWN ERROR
include("randomness.jl")# fixed: missing .jl ! #ERRORs Found
module generator

export genericGenerator, randMatrix, randVector, randvalue

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
'Distinct type' from StableRNG in any upcoming minor
(i.e. non-breaking) release.
```

function stableGenerator(rng = StableRNG(seed), seed = 1234)

    rng = StableRNG(seed)
    return rng
end

rng = stableGenerator(StableRNG(seed), seed) #works 
""" 
yeilds randomized nsamples 

input: 
seed: both fixed ()random ()
nsize:100 
"""
function randomizeStable(rng, nSize = 10, seed = 1234) #ERROR:Runtime - out of Memory #unsuitable for this pc- consider a simpler rng
    """
#pay attention: this one is not a uniform  
    A Random Must Use a Uniform Distribution 
    
    """
    #pay attention: this one is not a uniform  
    return rand(rng, nSize, seed) # uses default Normal  (not uniform )
end

randomizeStable(rng, 1, seed) #ERROR:Runtime - out of Memory #unsuitable for this pc- consider a simpler rng
#error (Compiler)
#range2(a = lobound, b = upbound) = (lobound in Base.range(lobound, upbound; (upbound - lobound), stepSize))

##r range1(2,8)

rand([rng = GLOBAL_RNG], [r]) #docs

#--- Base.://
Function
//(num = 3, den = 5)
"""
Divides two integers or rational numbers, giving a Rational result
"""
#... 

#---range test
using Test, BenchmarkTools
lobound = 1
upbound = 100

@time r1 = range1(a = lobound, b = upbound) # lobound:stepSize=1,length(upbound)
@benchmark r1 = range1(0, 10)
# 0.000050 seconds (55 allocations: 3.714 KiB)

#@time r2 = Random.Sampler(a, b) # MethodError no matching method 
#rand(range1)
@time r3 = rand(a, b) #   0.000010 seconds (1 allocation: 896 bytes)
#@time r4 = range2(a, b)
@time r2 = rand(rng, a, b) #  0.028962 seconds (51.49 k allocations: 3.117 MiB, 99.84% compilation time)


#---

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

```
PDF must play a role here #genericModel: is the PDF - HERE
as 
TODO: the argument 'genericModel' is a useful function  - does it need another loop?
```
#working
function genericGenerator(sampleSize = 300, _min = 1.0, _max = 10.0, genericModel = exp(-x))


    x = linspace(_min, step, _max)
    y = zeros(length(x))
    # z=nothing
    a = nothing
    b = nothing
    for i in enumerate(sampleSize) # <= sampleSize #generate sample #OPTIMIZE THIS LOOP
        #initializes with a vector (TODO:Q.why a vector? isn't a point enough | this context?) - maybe that is the main problem
        b = randVector(_min, _max)
        # c = copy(b)
        a = a(a, b)
        j = x[i]
        y = genericModel(j)


    end

    x = linspace(_min, step, _max)

    y = zeros(length(x))


    return a
end

#---range 
#Compiles
function createRange(start, stop, length, step)
    return range(start, stop; length, step)
end

```
TODO:
needs at least 2 loops, for a 2DArray matrix (or n loops for an n Array)
```
function genSample(sampleSize = 50::Int64, min = 0.0, max = 1.0)
    #range(min=0, stop=max; length=max, step=1)
    a = nothing
    for i in enumerate(sampleSize) #range(start=min, stop=max; length=max-min, step=1)    # sampleSize +1 & i < max+1 : #generate sample #OPTIMIZE
        # for #TODO: 
        #initializes with a vector (TODO:Q.why a vector? isn't a point enough | this context?) - maybe that is the main problem
        a = (a, randVector(min, max))

    end
end

end

#---- testing area -- craziness allowed

using Random, StableRNGs, Test
lobound = 1
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

If you need to guarantee `exact Reproducibility`` of random data, 
it is advisable to simply save the data [me: to a text file]
(e.g. as a supplementary attachment in a scientific publication). 
(manifest: can also, of course, specify a particular Julia version and package manifest, 
especially if you require bit reproducibility)

Software tests that rely on specific "random" data should also generally either save the data, embed it into the test code, or
use third-party packages like StableRNGs.jl.
On the other hand, tests that should pass for most random data (e.g. testing A \ (A*x) ≈ x for a random matrix A = randn(n,n))
can use an RNG, with a fixed seed, to ensure that simply running the test many times does not encounter a failure due to very improbable data (e.g. an extremely ill-conditioned matrix).

The Statistical Distribution from which random samples are drawn is guaranteed to be the same across any minor Julia releases.

```
using Random#,  # UUIDs # why added this , here?
#seed = 1234;
rng = stableGenerator()
x1 = rand(rng, 2);# returns Uniformly, 2 random variables #rand([rng=GLOBAL_RNG], [S], [dims...])

#rng = MersenneTwister(seed); #create a MersenneTwister #TODO:tobeREPLACED
rand(rng, 2) == x1;#whats the pint storing x1 [reusability]
reseed = Random.seed!(1234);
# Random.seed!(MersenneTwister(seed), seed) # (should be) a reproducible condition
@test rand(rng, 2) == x1 #rand() regenerates everytime it's called 

#rng()
_3points = rand(MersenneTwister(1234), 3) #retired
seed1 = rand(Random.seed!(MersenneTwister(1234)), Bool) # not reproducible

seed2 = rand(Random.seed!(MersenneTwister(1234)), Bool) # (not) reproducible

seed3 = rand(MersenneTwister(), Bool) # not rng has no seed. Infer reproducible either




#---range


function range_step_stop_length(a, step, len::Integer)
    start = a - step * (len - oneunit(len))
    if start isa Signed
        # overflow in recomputing length from stop is okay
        return StepRange{typeof(start),typeof(step)}(start, step, convert(typeof(start), a))
    end
    return StepRangeLen{typeof(start),typeof(start),typeof(step)}(start, step, len)
end

for i in enumerate(1000) #OPTIMIZE
    @test(range_step_stop_length(1, 1, 100))

end
# Stop and length as the only argument
function range_stop_length(start, a, len::Integer)
    # overflow in recomputing length from stop is okay

    return StepRangeLen{typeof(start),typeof(start),typeof(step)}(start, step, len)
end
# Stop and length as the only argument

#a=0;b=100;len = length(b - a)

function range_stop_length(a = 0, b = 100)
    # Start and length as the only argument

    type_b = typeof(b) # ge type
    return StepRangeLen{type_b,typeof(a)}(a, step, len)
end

#--- convertions credits: Tamas papp @tpapp

function array2vector1(T::Any)
    return irr(vec(Float64.(T)))
    rationalize(vec(Float64.(T)))
end
function array2vector2(T::Any)
    return
    Float64.(vcat(T[1], vec(T[2])))
end
