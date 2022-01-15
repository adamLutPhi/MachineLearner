
function init(randomGenerator ::Any, seed ::Any , μ=1, σ=0)
    """
    the First Functional Function

    Inputs:

    Mean μ [1st-Order  moment-generating function]  (fixed, #TODO: can it be a Variable?)
    STD σ  [2nd-Order moment-generating function] (fixed , #TODO: can it be Variable?)

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

    Mean μ [1st-Order  moment-generating function]  (fixed, #TODO: can it be a Variable?)
    STD σ  [2nd-Order moment-generating function] (fixed , #TODO: can it be Variable?)

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

    return randomGenerator

end
