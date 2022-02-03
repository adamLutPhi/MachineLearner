
"""
#= credits to:
M. Tamas K. Paap [PhD] @tpap, for the idea of  randvector & randmatrix ( plus the tip of reading the docs)
=======
@double1010x2 for a common xorshift manupulator

@inline xorshift_rotl(x::UInt64, k::Int) = (x >>> (0x3f & -k)) | (x << (0x3f & k))
@inline xorshift_rotl(x::UInt32, k::Int) = (x >>> (0x1f & -k)) | (x << (0x1f & k))

References:
-Random Int(64):
https://stackoverflow.com/questions/24326876/generating-a-random-integer-in-range-in-julia
"""

using Random
export genericGenerator, randMatrix, randVector, randvalue
global seed = 1234;


module randomness

#TODO: If is persistent, do Not Reseed (dedault: otherwise reseed)
export randvalue, randMatrix, randtemplate

#TODO:change MersenneTwister to anything else
function randtemplate(seed = 1234, rng = MersenneTwister(seed), ispersistent = yes)
    return rng(seed)
end

    """
    Returns a single value
    
    ```Inputs: 


    rng(seed) Random Number Generator 
    _min:_max: range any 
    
    Note: Max must be Bounded
    
    """

function randvalue(min = 1::Int64, max = 10::Int64, s = []::Int64, rng = MersenneTwisters(seed))

    # 1, 10,  1234, MersenneTwister(seed),  []
    #TODO: fill an array 
    return randsubseq(rng, 3, min:max)
    #return rand(min:max) # returns a single value x ∈ [min,max]

end

randvalue()

    """
    returns a single Vector
    
    ```inputs:
    
    _min: minimum   , integer , Int64
    _max: maximum   , integer , Int64
    n:    Number of samples Int64 integer

    Note: both maximum & minimum are assumed to be Reachable
      
    e.g.
    1. (There are) no Discontinuities at both bounds , & 
    2. Anomalies' (_min's & _max's) value is Reachable
    

"""
export randvalue, randMatrix
    
    """
    Returns c x ∈ [min,max]

    Input:
    min : minimum value  ::Int64 
    max:  maimum value  ::Int64
    """    
    using StableRNGs
    rng = StableRNG(1234)
    rand()
    function randvalue(_min = 1::int64, _max = 10::Int64)
        """
        returns a single value
        note: max must be Bounded
    
        TODO: return a Float  between 2 Integers x ∈ [min,max]
        """
       # rand(rng,_min,_max)
        A = rand(rng,_min,_max)
        return A # returns a single value  x ∈ [min,max]
    
    end
    
randvalue(rng,0,1) #test


    """
       Returns a single Vector
       Uniformly

       Example: randVector(_1::Int64, _max = 10::Int64, n = 10::Int64
       

      #TODO: Test the output 
    """
    function randVector(_min=1::Int64, _max=10::Int64,n=10)

      return rand(_min:_max,n) # 1D array - n-element Array{Int64,1}
    end


function randVector(_min = 1::Int64, _max = 10::Int64, n = 10::Int64)

    return rand(_min:_max, n) # 1D array - n-element Array{Int64,1}

end

   """ 
    Returns a single Vector with n 
   """ 

"""
function randVector(_min = 1::Int64, _max = 10::Int64, n = 10::Int64)

  return rand(_min:_max, n) # 1D array - n-element Array{Int64,1}

 end

  """
  """
     returns a single Matrix (2D - Array)
     """
    function randMatrix(a=10, b= 11, min=1::Int64, max=10::Int64)

        return rand(min:max,a,b)
    end



end


    """
    Returns a single Matrix (2D - Array)

    """
function randMatrix(_min = 1::Int64, _max = 10::Int64)

    return rand(_min:_max, n)
end

    """
    Returns a single Matrix (2D - Array)
    range(start[, stop]; length, stop, step=1)
    range(1, step=5, length=100)
    range(1, step=5, length=100)
    """
function randMatrix(r = _min:_max::range(Int64, Int64)) #::range(Int64,Int64))
    r = _min:_max
    #do a computation
    return rand(r, 2)
end

#=
function randArray(r = _min:_max)

        r = _min:_max
    #do a computation
    return r
=#

#--- helper functions 

#=
function permutate(rng = MersenneTwisters(1234), n = 10)
    return randperm(rng(seed), n)
end
=#
#--- testing 4
#permutate(MersenneTwisters(1234,n)

#randvalue(min = 1, max = 10, rng = )#TODO: uncomment lated 

#randvalue(1, 10,  1234, MersenneTwisters(1234),  []) #MersenneTwister has been removed in julia 1.7 

print(randvalue(4, 4))
