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
paths = ["functions", "functions/Generators", "Distributions", "NeuralNet/Networks", "src/DataStructures/Arrays/Array.jl", "tests"]
#TODO: Iterate all locations in paths
#include(safe_path(".")) #why refeing to thyself?
include(safe_path("functions"))
include(safe_path("functions/Generators"))
include(safe_path("Distributions"))
include(safe_path("NeuralNet/Networks"))
include(safe_path("tests"))
include(safe_path("src/constants.jl"))
include(safe_path("src/DataStructures/Arrays/Array.jl"))

"""
to be called upon path error 
"""
#= #nice try , needs further checking to see why it defaults to last catch #systemError: Permission Denied (on Windows) # check common # solution?
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
#TODO: Iterate all locations in paths
#
try

    #include(safe_path(".")) #why refeing to thyself?
    include(safe_path("functions"))
    include(safe_path("functions/Generators"))
    include(safe_path("Distributions"))
    include(safe_path("NeuralNet/Networks"))
    include(safe_path("tests"))
    include(safe_path("src/constants.jl"))
    include(safe_path("src/DataStructures/Arrays/Array.jl"))

catch
    try
        strings = split(path, "/")
        n = length(strings)
        for i in enumerate(n)

            strings[1] = Upper(strings[1])#try Uppercasing the first letter
            path = joinpath(strings...)
        end
    catch

        println("path does not exist")
    end
end

end
=#
"""

DEPOT_PATH

  A stack of "depot" locations where the package manager, as well as Julia's code loading mechanisms, look for package registries, installed packages, named    
  environments, repo clones, cached compiled package images, and configuration files. By default it includes:

    1. ~/.julia where ~ is the user home as appropriate on the system;

    2. an architecture-specific shared system directory, e.g. /usr/local/share/julia;

    3. an architecture-independent shared system directory, e.g. /usr/share/julia.

  So DEPOT_PATH might be:

  [joinpath(homedir(), ".julia"), "/usr/local/share/julia", "/usr/share/julia"]

  The first entry is the "user depot" and should be writable by and owned by the current user. The user depot is where: registries are cloned, new package      
  versions are installed, named environments are created and updated, package repos are cloned, newly compiled package image files are saved, log files are
  written, development packages are checked out by default, and global configuration data is saved. Later entries in the depot path are treated as read-only    
  and are appropriate for registries, packages, etc. installed and managed by system administrators.

  DEPOT_PATH is populated based on the JULIA_DEPOT_PATH environment variable if set.

  DEPOT_PATH contents
  =====================

  Each entry in DEPOT_PATH is a path to a directory which contains subdirectories used by Julia for various purposes. Here is an overview of some of the        
  subdirectories that may exist in a depot:

    •  clones: Contains full clones of package repos. Maintained by Pkg.jl and used as a cache.

    •  compiled: Contains precompiled *.ji files for packages. Maintained by Julia.

    •  dev: Default directory for Pkg.develop. Maintained by Pkg.jl and the user.  <--- ok

    •  environments: Default package environments. For instance the global environment for a specific julia version. Maintained by Pkg.jl.

    •  logs: Contains logs of Pkg and REPL operations. Maintained by Pkg.jl and Julia. 

    •  packages: Contains packages, some of which were explicitly installed and some which are implicit dependencies. Maintained by Pkg.jl.

    •  registries: Contains package registries. By default only General. Maintained by Pkg.jl.

  See also: JULIA_DEPOT_PATH, and Code Loading.
"""

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