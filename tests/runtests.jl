#stableRNG 
rng = StableRNG(123)
A = randn(rng, 10, 10)
num1 = randn(rng, 1)
num2 = randn(rng, 1) # instead of randn(10, 10)
@test inv(inv(A)) ≈ A
@test inv(randn(A))
