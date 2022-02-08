module includes

import Random
import REPL
import TOML
using Dates

"""
note: works on mac & windows
"""
# turn /-paths into \-paths on Windows
function safe_path(path::String)
    if Sys.iswindows() && !isabspath(path)
        path = joinpath(split(path, "/")...)
    end
    return path
end

"""
to be called upon path error 
"""
function pathRevise(path::String)
    strings = split(path, "/")
    try
        strings[1] = Upper(strings[1])#try Uppercasing the f
        path = joinpath(strings...)
    catch
    end
    #=for i in enumerate length(strings)
        #TODO: do minor changes to path - i.e. uppercase other words #todo how to spot others , first?

    end=#
end
paths = ["functions", "functions/Generators", "Distributions", "NeuralNet/Networks", "src/DataStructures/Arrays/Array.jl", "tests"]
try

    #include(safe_path(".")) #why refeing to thyself?
    include(safe_path("functions"))
    include(safe_path("functions/Generators"))
    include(safe_path("Distributions"))
    include(safe_path("NeuralNet/Networks"))
    include(safe_path("tests"))

    include(safe_path("src/DataStructures/Arrays/Array.jl"))

catch
    try
        strings = split(path, "/")
        n=length(strings)
        for i in enumerate(n)

            strings[1] = Upper(strings[1])#try Uppercasing the first letter
            path = joinpath(strings...)
        end
    catch

        println("path not exist")
    end
end

end


depots() = Base.DEPOT_PATH

logdir(depot = depots1()) = joinpath(depot, "logs")
devdir(depot = depots1()) = get(ENV, "JULIA_PKG_DEVDIR", joinpath(depot, "dev"))
envdir(depot = depots1()) = joinpath(depot, "environments")
const UPDATED_REGISTRY_THIS_SESSION = Ref(false)
const OFFLINE_MODE = Ref(false)

function depots1()
    d = depots()
    isempty(d) && Pkg.Types.pkgerror("no depots found in DEPOT_PATH")
    return d[1]
end

function pkg_server()
    server = get(ENV, "JULIA_PKG_SERVER", "https://pkg.julialang.org")
    isempty(server) && return nothing
    startswith(server, r"\w+://") || (server = "https://$server")
    return rstrip(server, '/')
end



#--- For globally overriding in e.g. tests
const DEFAULT_IO = Ref{Union{IO,Nothing}}(nothing)
stderr_f() = something(DEFAULT_IO[], stderr)
stdout_f() = something(DEFAULT_IO[], stdout)
const PREV_ENV_PATH = Ref{String}("") #a goo rule of thumb 

can_fancyprint(io::IO) = (io isa Base.TTY) && (get(ENV, "CI", nothing) != "true") # fancyprint: <interesting>


end 