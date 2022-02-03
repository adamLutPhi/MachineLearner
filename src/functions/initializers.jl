
function init(randomGenerator::Any, seed::Any, μ = 1, σ = 0)
    """
      the First (Functional) Function

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

    return randomGenerator
end

function init(randomGenerator, seed, μ = 1, σ = 0)
    """
    inputs:

    Mean μ [1st-Order  moment-generating function]  (fixed, #TODO: can it be a Variable?)
    STD σ  [2nd-Order moment-generating function] (fixed , #TODO: can it be Variable?)

    seed: RNG seed
    Function randomGenerator(seed)

    # TODO: Does the seed `remain` the same? can it be(come) changeable afterwards?
    """

    model.μ = μ
    model.σ = σ
    model.seed = seed

    model.randomGenerator = randomGenerator(seed)

    return randomGenerator()
end


function init(randomGenerator, seed, μ = 1, σ = 0)
    """
    inputs:

    Mean μ [1st moment] (fixed, #TODO: can it be a Variable?)
    STD σ   [2nd moment] (fixed , #TODO: can it be a Variable?)
    RNG seed
    Function randomGenerator(seed)

    # TODO:
    Q1. Does the seed `remain` the same? OR
    Q2.can it be(come) changeable afterwards?
    """

    model.μ = μ
    model.σ = σ
    model.seed = seed

    model.randomGenerator = randomGenerator(seed)

    return randomGenerator

end

#---  arrays = convertions - 

function array2rational(T::Any)
    return rationalize(vec(Float64.(T)))

end

function array2irrational(T::Any)
    return irr(vec(Float64.(T)))
end 

function array2vector(T::Any)
    return
    Float64.(vcat(T[1], vec(T[2])))
end

#working
function randomArray(min=0,max=1,n=100,y = exp(1 / -x))
    a=[];b=[];X=[]
    for i in enumerate(n)
        x = [i in rand(min,max)];X=[X x]
        c=[i in rand(1, y)]; a = [a c]
        d=[j in rand(1, y)]; b = [b d]
    end 
    return X,a,b
end
