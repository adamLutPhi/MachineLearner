
"""
credits in making this file goes to the julia development team:
         David Widmann @devmotion
        vid Widmann devmotion

@fredrikekre
@staticfloat
Kristoffer Carlsson @KristofferC
Ian Butterworth @IanButterworth
@ianshmean
Tim Holy @timholy
David Widmann @devmotion
David Widmann devmotion

"""

module SubdirTests
import Pkg # ensure we are using the correct Pkg

using Pkg, UUIDs, Test
using Pkg.REPLMode: pkgstr
using Pkg.Types: PackageSpec
using Pkg: stdout_f, stderr_f

using Utils

# turn /-paths into \-paths on Windows
function safe_path(path::String)
    if Sys.iswindows() && !isabspath(path)
        path = joinpath(split(path, "/")...)
    end
    return path
end

# turn /-paths into \-paths on Windows
function safe_path(path::String)
    if Sys.iswindows() && !isabspath(path)
        path = joinpath(split(path, "/")...)
    end
    return path
end