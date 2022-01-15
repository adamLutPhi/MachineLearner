#=

(not an) AI package
(but a) Statistics-based one

Inspired by the Keras Project

Ahmad Lutfi

=#

include("seeders")

function seed()

    """
    function: generates a seed
    #TODO: can it be nothing?
    """
    seed = 0 #or
# TODO:generate a seed
return seed
end

function seed()
    """
    function: generates a seed
    #TODO: can it be nothing?
    """
    seed = 0 #or
# TODO:generate a seed

return seed
end

function init(randomGenerator,seed ,μ=1,σ=0)
    """
    a functional function

    inputs:

    Mean μ  (fixed, #TODO: can it be a Variable?)
    STD σ    (fixed , #TODO: can it be Variable?)
    RNG seed
    Function randomGenerator(seed)

    outputs:


    # TODO: Does the seed `remain` the same? can it be(come) changeable afterwards?
    """
    μ = μ
    σ = σ
    seed = seed

    randomGenerator = randomGenerator(seed)

    returns randomGenerator
end


function init(randomGenerator,seed ,μ=1,σ=0)
    """
    inputs:

    Mean μ  (fixed, #TODO: can it be a Variable?)
    STD σ    (fixed , #TODO: can it be Variable?)
    RNG seed
    Function randomGenerator(seed)

    # TODO: Does the seed `remain` the same? can it be(come) changeable afterwards?
    """
    model.μ = μ
    model.σ = σ
    model.seed = seed

    model.randomGenerator = randomGenerator(seed)

    returns randomGenerator
end


function init(randomGenerator,seed ,μ=1,σ=0)
    """
    inputs:

    Mean μ [] (fixed, #TODO: can it be a Variable?)
    STD σ    (fixed , #TODO: can it be Variable?)
    RNG seed
    Function randomGenerator(seed)

    # TODO: Does the seed `remain` the same? can it be(come) changeable afterwards?
    """


    model.μ = μ
    model.σ = σ
    model.seed = seed

    model.randomGenerator = randomGenerator(seed)

    returns randomGenerator
end


#later
z1 = zeros(3,3)
z1!()
