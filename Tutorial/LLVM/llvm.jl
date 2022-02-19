#=
2013 - 2013 LLVM Developers’ Meeting: “Julia: An LLVM-based approach to scientific computing”
benchmarks = readtable("http")


=#
username = run(`git config --get user.name`)

#=
benchmarks = readtable(URI("http://julialang.org/benchmarks.csv"); header = false, colnames = ["Language", "Benchmark", "Time"]) #usri Problem #Alternative? 
benchmarks = join(benchmarks, subset(benchmarks, :(Language .== "c")),
    on = "Benchmark", kind = :outer)
within!(benchmarks, :(Time ./= Time_1));
# moving on =

convert # 10 method generic 
+ #196 method generic function (still the largest)

@which convert(Float64, n = 1) #no unique method found #checking uniqueness of method (if method has n n)
@which 1.0 + 2
#=+(x::Number, y::Number) in Base at promotion.jl:321 =#

# Basic Dispatch

=#


f(a::Any, b) = "fallback"
f(a::Number, b::Number) = "a and b are both numbers"
f(a::Number, b) = "a is a number"
f(a, b::Number) = "b is a number"
f(a::Integer, b::Integer) = "a and b are both integers"
f(1, 5.2) # "a and b are both numbers"
f(1, "bar") #= "a is a number" =#
f(1, 2) #= "a and b are both integers" =#

f("foo", [1, 2]) # : "fallback" #arg#1  string (note: arg2 was dynamc ) Infer 1st: f(a::Any, b) = "fallback"

methods(f)
#=julia> methods(f)
# 5 methods for generic function "f":
[1] f(a::Integer, b::Integer) in Main at c:\Users\adamus\.git\DeepLearner\DeepLearner\Tutorial\LLVM\llvm.jl:32
[2] f(a::Number, b::Number) in Main at c:\Users\adamus\.git\DeepLearner\DeepLearner\Tutorial\LLVM\llvm.jl:29
[3] f(a, b::Number) in Main at c:\Users\adamus\.git\DeepLearner\DeepLearner\Tutorial\LLVM\llvm.jl:31[4] f(a::Number, b) in Main at c:\Users\adamus\.git\DeepLearner\DeepLearner\Tutorial\LLVM\llvm.jl:30[5] f(a, b) in Main at c:\Users\adamus\.git\DeepLearner\DeepLearner\Tutorial\LLVM\llvm.jl:28  
=#
#=--- Diagonal Dispatch/ Parametric Dispatch =#

f{T<:Number}(a::T, b::T) = "a and b are both $(T)s"
f{T<:Number}(a::Vector{T}, b::Vector{T}) = "a and b are both vectors of $(T)s"

#=Crossreference  Dispatch on tuples of types https://github.com/JuliaLang/julia/issues/10947
#10947
(Int,) is not a type at all; it's a tuple that contains a type. So you can't use <: on it.

Tuples now "infer" their parameters from constructor arguments just like other parametric types do:
=#
typeof(Int => String)
#Pair{DataType,DataType}
typeof((Int, String))
Tuple{DataType,DataType}
[Int]
#1-element Array{DataType,1}:
#Int64 # Core.Int64 

#=
The difference is that tuples don't provide a way to request parameter types. If you want, you can construct Pair{Any,Any}(1,2), but you can't do the same thing with tuples. Tuple "parameters" are always inferred.

This is normally what you'd expect, but the corner case is that it's impossible to construct a Tuple{Type{Int}}.

To do this dispatch, I think you'll have to pass tuple types --- dispatch on Type{Tuple{T,T}}. Unfortunately the input syntax Tuple{A,B} is much less pleasant than (A,B). Another example in favor of using {A,B} for tuple types.

The difference is that tuples don't provide a way to request parameter types. If you want, you can construct Pair{Any,Any}(1,2), but you can't do the same thing with tuples. Tuple "parameters" are always inferred.

This is normally what you'd expect, but the corner case is that it's impossible to construct a Tuple{Type{Int}}.

To do this dispatch, I think you'll have to pass tuple types --- dispatch on Type{Tuple{T,T}}. Unfortunately the input syntax Tuple{A,B} is much less pleasant than (A,B). Another example in favor of using {A,B} for tuple types.
=#

isa(Int, Any)
#true
isa(Int, Type{Int})
#true
isa(Int, DataType)
#true
isa(("",), Tuple{Any})
#true
isa(("",), Tuple{String})
#true
isa(("",), Tuple{ASCIIString})
#true #2022: Error UndefVarErro (is this normal?)



isa((Int,), Tuple{Any})
true

# isa((Int,), Tuple{Type{Int}}) # false

isa((Int,), Tuple{DataType}) #true

#Edit: Actually, upon further reflection, I understand now. typeof((Int,)) is a Tuple{DataType}. And this is behaving like dispatch:

f(::Tuple{Type{Int}}) = 1 #f (generic function with 1 method)

f((Int,)) #ERROR: MethodError: `f` has no method matching f(::Tuple{DataType}) # Closest candidates are: f(::Tuple{Type{Int64}}) #me : so the

#=To overcome the breaking change of (Normal,Normal) needing to be Tuple{Normal,Normal} I'll try to add another method that dispatches one to the other. =#
Tuple{Normal,Normal}
#= 
ERROR: UndefVarError: Normal not defined
Stacktrace:
 [1] top-level scope
   @ REPL[30]:1=#

Tuple{Normal,Normal} #Error # was working on  commented by @sebastiang , on Apr 22, 2015

#=Yes, it should work to add a method to convert (Normal,Normal) to Tuple{Normal,Normal}, although the resulting dispatch will probably be slow.

here's nothing wrong with using tuples. In fact now using them is a great idea, since they perform well and don't require declarations. One huge benefit is that if everybody who needs "two integers" uses Tuple{Int,Int}, then they can share lots of code. Declaring new types every time can be highly redundant.

JeffBezanson closed this on Apr 24, 2015

toivoh commented on Apr 24, 2015
So if isa shouldn't be used to check the applicability of a method signature to an argument tuple, what should? Isn't this an inconsistency in the type system? (Making tuples not completely covariant?) I can understand if it's tricky to do something about it, but it would be good to get some more perspective about how it could be allowed to behave in the long run.

    JeffBezanson commented on Apr 24, 2015
                **`Tuples are still covariant`** 
Tuple{Type{Int}} <: Tuple{DataType} is true, b=#
Tuple{Type{Int}} <: Tuple{DataType} #True  # ut of course not the other way around. It's just that you can't construct a value of the left-hand type.

#One thing worth considering is making  typeof(T) always return Type{T} for types,
typeof(T)  # Type{T}
DataType{T} #  LoadError: TypeError: in Type{...} expression, expected UnionAll, got Type{DataType}

# and doing reflection some other way. We could maybe even have DataType{T}. There's an awful lot of 
 isa(T, Type) ? Type{T} : typeof(T) # typeof(ones)