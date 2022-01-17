import random
module generator()

export genericGenerator,
#=
references:

-Random Int(64):
https://stackoverflow.com/questions/24326876/generating-a-random-integer-in-range-in-julia


=#
# function makerange(min=1, max)


function randMatrix(a=10, b= 11, min=1, max=10)
    return rand(min:max,a,b)
end

function randVector(min=1, max=10)
    """
    note: max must be Bounded
    """

    return rand(min:max)

end


function genericGenerator(sampleSize=300, genericModel=exp(-x))
    """
    mimicing a caglag range(d) process
    ("continue à droite, limite à gauche")
    starts from 1 - the origin (not 0?)
    Q. Should n always be an argument?

    """
    n=10
    randVector(1,n)
end



end
