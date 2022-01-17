#=
references:

-Random Int(64):
https://stackoverflow.com/questions/24326876/generating-a-random-integer-in-range-in-julia


=#

export randvalue,randVector,randMatrix

module randomness()

# export randvalue, randMatrix
    function randvalue(min=1::Int64, max=10::Int64)
        """
        retunrs a single value
        note: max must be Bounded
        """

        return rand(min:max) # returns a single value x ∈ [min,max]

    end


    function randVector(a=10, min=1::Int64, max=10::Int64)
        """
        returns a single Vector
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
