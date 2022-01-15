"""
Inspired by the Keras Project
"""
function seed()
    seed = 0
# TODO:generate a seed
return seed
end

function init(randomGenerator,seed=nothing ,μ=1,σ=0)
    self.μ = μ
    self.σ = σ
    self.seed = seed
    self.randomGenerator = randomGenerator(seed)
end


z1 = zeros(3,3)
z1!()
