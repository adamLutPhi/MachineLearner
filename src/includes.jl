module includes

import Random
import REPL
import TOML
using Dates

export @pkg_str
export PackageSpec
export PackageMode, PKGMODE_MANIFEST, PKGMODE_PROJECT
export UpgradeLevel, UPLEVEL_MAJOR, UPLEVEL_MAJOR, UPLEVEL_MINOR, UPLEVEL_PATCH
export PreserveLevel, PRESERVE_TIERED, PRESERVE_ALL, PRESERVE_DIRECT, PRESERVE_SEMVER, PRESERVE_NONE
export Registry, RegistrySpec

depots() = Base.DEPOT_PATH
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

logdir(depot = depots1()) = joinpath(depot, "logs")
devdir(depot = depots1()) = get(ENV, "JULIA_PKG_DEVDIR", joinpath(depot, "dev"))
envdir(depot = depots1()) = joinpath(depot, "environments")
const UPDATED_REGISTRY_THIS_SESSION = Ref(false)
const OFFLINE_MODE = Ref(false)
# For globally overriding in e.g. tests
const DEFAULT_IO = Ref{Union{IO,Nothing}}(nothing)
stderr_f() = something(DEFAULT_IO[], stderr)
stdout_f() = something(DEFAULT_IO[], stdout)
const PREV_ENV_PATH = Ref{String}("")

can_fancyprint(io::IO) = (io isa Base.TTY) && (get(ENV, "CI", nothing) != "true")


"""
note: works on mac( not windows)
"""
include("src")

include("src/functions")
include("src/functions/Generators")
include("Distributions")
include("NeuralNet\Networks")
include("tests")

#Windows directory mapping: #known Issue #TODO:RECHECK ON MAC (mac won't comprehend ,then)
pwd()
#cd("src\functions")

include("src\functions")

end 