using random
include("randomness")

module generator()

export genericGenerator,randMatrix,randVector,randvalue
#=
references:



=#

function genericGenerator(sampleSize=300,min=1::Int64,max=10::genericGenerator64, genericModel=exp(-x))
    """
    mimicing a caglag, range(d) process
    ("continue à droite, limite à gauche")
    starts from 1 - the origin (not 0?)

    """
    for i < sampleSize: #generate sample


        #initializes with a vector (TODO:Q.why a vector? isn't a point enough | this context?)
        randVector(min,max)
    end
end



end
