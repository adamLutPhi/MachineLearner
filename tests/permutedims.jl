#
function permutedims(A::AbstractArray, perm)
    dest = similar(A, genperm(axes(A), perm))
    permutedims!(dest, A, perm)
end

"""
    permutedims(m::AbstractMatrix)
Permute the dimensions of the matrix `m`, by flipping the elements across the diagonal of
the matrix. Differs from `LinearAlgebra`'s [`transpose`](@ref) in that the
operation is not recursive.
# Examples
```jldoctest; setup = :(using LinearAlgebra)
julia> a = [1 2; 3 4];
julia> b = [5 6; 7 8];
julia> c = [9 10; 11 12];
julia> d = [13 14; 15 16];
julia> X = [[a] [b]; [c] [d]]
2×2 Matrix{Matrix{Int64}}:
 [1 2; 3 4]     [5 6; 7 8]
 [9 10; 11 12]  [13 14; 15 16]
julia> permutedims(X)
2×2 Matrix{Matrix{Int64}}:
 [1 2; 3 4]  [9 10; 11 12]
 [5 6; 7 8]  [13 14; 15 16]
julia> transpose(X)
2×2 transpose(::Matrix{Matrix{Int64}}) with eltype Transpose{Int64, Matrix{Int64}}:
 [1 3; 2 4]  [9 11; 10 12]
 [5 7; 6 8]  [13 15; 14 16]
```
"""
permutedims(A::AbstractMatrix) = permutedims(A, (2,1))

"""
    permutedims(v::AbstractVector)
Reshape vector `v` into a `1 × length(v)` row matrix.
Differs from `LinearAlgebra`'s [`transpose`](@ref) in that
the operation is not recursive.
# Examples
```jldoctest; setup = :(using LinearAlgebra)


 """

permutedims([1, 2, 3, 4])
"""1×4 Matrix{Int64}:
 1  2  3  4"""

 V = [[[1 2; 3 4]]; [[5 6; 7 8]]]

 """2-element Vector{Matrix{Int64}}:
 [1 2; 3 4]
 [5 6; 7 8]
"""

permutedims(V)
"""1×2 Matrix{Matrix{Int64}}:
 [1 2; 3 4]  [5 6; 7 8]"""

transpose(V)

"""1×2 transpose(::Vector{Matrix{Int64}}) with eltype Transpose{Int64, Matrix{Int64}}:
 [1 3; 2 4]  [5 7; 6 8]"""
