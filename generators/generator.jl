using random
include("randomness")

module generator()

export genericGenerator,randMatrix,randVector,randvalue
#=
references:

-Random Int(64):
https://stackoverflow.com/questions/24326876/generating-a-random-integer-in-range-in-julia


=#

function genericGenerator(sampleSize=300,min=1::Int64,max=10::genericGenerator64, genericModel=exp(-x))
    """
    mimicing a caglag range(d) process
    ("continue à droite, limite à gauche")
    starts from 1 - the origin (not 0?)

    """
    #initializes with a vector
    randVector(min,max)
end



end
