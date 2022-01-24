using StableRNGs, Random, Test
#include("./functions/SmoothFunctions/smoothFunction.jl")
#include("functions/SmoothFunctions/smoothFunction.jl")

if Sys.iswindows() 
slash =  "\" 
else slash = "/";
end

#="""
windowspath = "src\functions\SmoothFunctions\smoothFunction.jl"
macospath = "/functions/SmoothFunctions/smoothFunction.jl"
#include("src\functions\SmoothFunctions\smoothFunction.jl") "./functions/SmoothFunctions/smoothFunction.jl")

slash = Sys.iswindows() ? slash =  "\" : slash = "/"
#windowspath = "src\functions\SmoothFunctions\smoothFunction.jl"
#macospath = "/functions/SmoothFunctions/smoothFunction.jl"
"""=#

include("src/functions/SmoothFunctions/smoothFunction.jl")  
#"/functions/SmoothFunctions/smoothFunction.jl")

function ziggurat(smooth) end

#--- testing area

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

If you need to guarantee exact reproducibility of random data, it is advisable to simply save the data (e.g. as a supplementary attachment in a scientific publication). (You can also, of course, specify a particular Julia version and package manifest, especially if you require bit reproducibility.)

Software tests that rely on specific "random" data should also generally either save the data, embed it into the test code, or
use third-party packages like StableRNGs.jl.
 On the other hand, tests that should pass for most random data (e.g. testing A \ (A*x) ≈ x for a random matrix A = randn(n,n))
 can use an RNG, with a fixed seed, to ensure that simply running the test many times does not encounter a failure due to very improbable data (e.g. an extremely ill-conditioned matrix).

The statistical distribution from which random samples are drawn is guaranteed to be the same across any minor Julia releases.

```

```
Results from the 'MersenneTwister'
were unsatisfactory, I'm afraid 
TODO: delete block once an alternative been found 
```
using Random
seed = 1234; #1= rand(2)# 2 random variables N/a in julia 1.5
rng()
rng = MersenneTwister(seed);
rand(rng, 2) == x1;
reseed = Random.seed!(1234);
Random.seed!(MersenneTwister(seed), seed) # (should be) a reproducible condition
rand(rng, 2) == x1

seed1 = rand(Random.seed!(rng), Bool) # not reproducible

seed2 = rand(Random.seed!(rng), Bool) # (not) reproducible

seed3 = rand(MersenneTwister(), Bool) # not rng has no seed. Infer reproducible either

#---StableRNG - for stability
``` ffrom the docs:
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
num2 = randn(rng, 1) # instead of randn(10, 10)
@test inv(inv(A)) ≈ A
#---range
range1(a = lobound, b = upbound) = lobound:stepSize:length(upbound)
Random.Sampler
rand(range1)


range2(a = lobound, b = upbound) = (lobound in Base.range(lobound, upbound; (upbound - lobound), stepSize))

r = range1(2, 8)

res = rand([rng = GLOBAL_RNG], [r])

#--- Base.://
Function
//(num = 3, den = 5)
"""
Divide two integers or rational numbers, giving a Rational result.
"""



#---range


function range_step_stop_length(a, step, len::Integer)
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
#working 
function range_stop_length(a, len::Integer)
<<<<<<< HEAD
    #@@ -177,7 +184,7 @@ function range_stop_length(a, len::Integer)
    # overflow in recomputing length from stop is okay
    len = length(b - a)
=======
    # overflow in recomputing length from stop is okay
    #return UnitRange(start, oftype(start, a))
    #end
>>>>>>> d1e55e1e3f0cfc36ea6cc436b99e5eeb640f0342
    return StepRangeLen{typeof(start),typeof(start),typeof(step)}(start, step, len)
end
# Stop and length as the only argument

<<<<<<< HEAD
function range_stop_length(a=0,b=100)
# Start and length as the only argument
	# @@ -188,7 +195,7 @@ function range_start_length(a, len::Integer)
        # overflow in recomputing length from stop is okay
		 len = length(b - a)

	type_b = typeof(b)
=======
# double return

a = 0;
b = 100;
len = length(b - a);

#working
function range_stop_length(a = 0, b = 100)
    # Start and length as the only argument

    type_b = typeof(b)
>>>>>>> d1e55e1e3f0cfc36ea6cc436b99e5eeb640f0342
    return StepRangeLen{type_b,typeof(a)}(a, step, len)
end

#---- task
#SamplerType is required
#=
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
<<<<<<< HEAD



=======
=#
# Shared implementation between Xoshiro and TaskLocalRNG -- seeding

>>>>>>> d1e55e1e3f0cfc36ea6cc436b99e5eeb640f0342


#--- convertions

function array2vector1(T::Any)
    return irr(vec(Float64.(T)))
    rationalize(vec(Float64.(T)))
end
function array2vector2(T::Any)
    return
    Float64.(vcat(T[1], vec(T[2])))
end
