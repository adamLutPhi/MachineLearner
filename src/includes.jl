include(".")
include("./src/functions")
include("src/functions/Generators")
include("src/Distributions")
include("src/NeuralNet")

include("tests")
include("tests/runtests.jl")

#windows directory mapping: #known Issue (mac won't comprehend ,then)
pwd()
cd("src\functions")