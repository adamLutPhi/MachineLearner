#=
references:

-Random Int(64):
https://stackoverflow.com/questions/24326876/generating-a-random-integer-in-range-in-julia

# credits to @tpap (Tamas K. Paap [PhD])
=#

export genericGenerator,randMatrix,randVector,randvalue

module randomness()

export randvalue, randMatrix
    """ 
eturns a single value x ∈ [min,max]
input:
min :  (moInt64
max:
    """
    using StableRNGs
    rng = StableRNG(1234)
    rand()
    function randvalue(min = 1::int64, max = 10::Int64)
        """
        retunrs a single value
        note: max must be Bounded
    
        TODO: return a Float  between 2 Integers x ∈ [min,max]
        """
        rand(rng,min,max)
        A = rand(rng,min,max)
        return A # returns a single value  x ∈ [min,max]
    
    end
    
randvalue(rng,0,1)

    function randVector(a=10, min=1::Float64, max=10::Float64)
        """
        returns a single Vector
        Uniformly
        """
        return rand(min:max,a) # 1D array - n-element Array{Int64,1}

    end


    function randMatrix(a=10, b= 11, min=1::Int64, max=10::Int64)
        """
        returns a single Matrix (2D - Array)
        """
        return rand(min:max,a,b)
    end

end
