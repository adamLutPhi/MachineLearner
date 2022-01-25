using StableRNGs, Random, Test
#include("./functions/SmoothFunctions/smoothFunction.jl")
#include("functions/SmoothFunctions/smoothFunction.jl")


#TODO: needs resolution for windows PC 
#=
if Sys.iswindows() 
slash =  "\" 
else slash = "/";
end

=#
#checking path difference:
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

#--- RNG

"""
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
"""

"""
Results from the 'MersenneTwister'
were unsatisfactory, I'm afraid 
TODO: delete block once an alternative been found 

"""
#NOT RECOMMENDED USING THE MersenneTwister (very bad in number generation)

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
"""from the docs:
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
"""
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
    # overflow in recomputing length from stop is okay
    len = length(b - a)

    # overflow in recomputing length from stop is okay
    #return UnitRange(start, oftype(start, a))
    #end

    return StepRangeLen{typeof(start),typeof(start),typeof(step)}(start, step, len)
end
# Stop and length as the only argument

function range_stop_length(a=0,b=100)
# Start and length as the only argument
        # overflow in recomputing length from stop is okay
		 len = length(b - a)

	type_b = typeof(b)

# double return


#len = length(b - a);

#working
function range_stop_length(a = 0, b = 100)
    # Start and length as the only argument
     len = length(b - a)
    type_b = typeof(b)

    return StepRangeLen{type_b,typeof(a)}(a, step, len)
end

using Distributions

function algorithm2()
    """Rejection sampling method : 3 step process
    does PRN means RNG? (maybenot, more likely a whole PDF)
    idea: probability distribution P(x) is subsumed by a set of boxes, resembling a ziggurat

   1. Generate 2 PRNs x, y #from a uniform distribution , together, form a point 
    
   2. If y < P(x) return x # accepted retrun true too if possible

   3. else point rejected 
   then go back & draw another point (select & test )
 
   --------------
In a ziggurat algorithm, 
the desired probability distribution P(x) lies beneath a 
stack of rectangular layers. Layers are designed such that 
they all contain the exact same area, so that each box can be randomly
chosen with equal probability using a uniform random integer i 
to ensure uniform coverage of P(x). The height fi and length Xi of 
each ziggurat layer are pre-calculated in lookup tables.
 Because of these lookup tables, ziggurat algorithms are most
efficiently implemented on systems with large caches (e.g. modern CPUs,
but not current GPUs) 

  """

end
function algorithm1()
    """
    1. Generate U1, i #from a uniform distribution 
    2. If i < Lmax, return U1Xi
    3. Generate j from A
    4. Ifj=0, returna value from the tail 5. Generate U2
    6. x ← Xj + U1(Xj−1 − Xj) # Q1. what is U1(Xj−1 − Xj), again? 
    7. If (fi−1 − fi)U2 < P(x), return x
    8. Go to 4.
    """
    i = Distributions.Uniform(0, 1)
    U1 = Uniform(0, 1)
    #3. Generate j from A # Q.what is lmax?
    rng = StableRNG(123)
    Lmax = [ rand(rng, 1)
    if (i < Lmax)
        return U1Xi #returns a max  value
    end #otherwise  create a random array A 
    A = smooth()  # randn(rng, 0, 1) #generate A matrix , via a stable RNG from 0 to 1
    j = A[rand(1:end)] #randn(rng, 1) #pick 1 value for R  j from A  #done 

for i in enumerate ([i in rand(0,1,1])
#DEFINE X
j = A[rand(1:end)] #pick j randomly (from a Uniform distribution)
#https://discourse.julialang.org/t/generate-random-value-from-a-given-function-out-of-box/5793/4
using StatsBase, Gadfly

x = linspace(0,π,100)
P = smooth(x)     # pdf
P = P/sum(P)   #cdf 

r = StatsBase.sample(1:100, Weights(P),10000)
plot(x=x[r],Geom.histogram)

if j isa 0
        return returnValfromTrail()
    
        If (fi−1 − fi) U2 < P(x) return x end 

    end
end

"""
total number of layers in the modified algorihtm Lmax cannot be determined, 
until the last layer is calculated,
"""
#testing area 

x = X[j] + U1(Xj−1 − Xj)

ε = max(x ,[fi +(x−X[i])*(fi−1 −fi)−P(x)] )

ε=f[i−1] +Log(f[i] −f[i−1])+Xi)*(fi −fi−1))
 
end 

n = 1000000000
for j in numerate(n)

    
if 

end 

end


function returnValfromTrail() end 
    
end


