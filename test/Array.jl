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
@test replstr(Int32[]) == "Int32[]"
@test replstr([Int32[]]) == "1-element Vector{Vector{Int32}}:\n []"

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
#using ..AlsoExportsPair
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

struct PermutedDimsArray{T,N,AA<:AbstractArray,perm,iperm} <: AbstractArray{T,N}
    parent::AA
    dims::NTuple{N,Int}

end
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
"""


