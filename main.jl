"""
Inspired by the Keras Project
"""
function seed()
    seed = 0
# TODO:generate a seed
return seed
end

function init(randomGenerator,seed=nothing ,μ=1,σ=0)
    """

    inputs:

    Mean μ  (fixed, can it be a Variable?)
    STD σ    (fixed , can it be Variable?)
    RNG seed
    Function randomGenerator(seed)

    Does the seed remains the same? can it be(come) changeable afterwards?
    """

    model.μ = μ
    model.σ = σ
    model .seed = seed
    self.randomGenerator = randomGenerator(seed)
end


z1 = zeros(3,3)
z1!()
