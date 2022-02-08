"""
KristofferC
IanButterworth
00vareladavid
timholy
GunnarFarneback
fredrikekre
DilumAluthge
devmotion
aviatesk

inspired by file: manifest.jl 

"""

function safe_uuid(uuid::String)::UUID
    try
        uuid = UUID(uuid)
    catch err
        err isa ArgumentError || rethrow()
        pkgerror("Could not parse `uuid` field as a UUID.")
    end
    return uuid
end

function safe_bool(bool::String)
    try
        bool = parse(Bool, bool)
    catch err
        err isa ArgumentError || rethrow()
        pkgerror("Could not parse `pinned` field as a Bool.")
    end
    return bool
end

# note: returns raw version *not* parsed version
function safe_version(version::String)::VersionNumber
    try
        version = VersionNumber(version)
    catch err
        err isa ArgumentError || rethrow()
        pkgerror("Could not parse `version` as a `VersionNumber`.")
    end
    return version
end

# turn /-paths into \-paths on Windows
function safe_path(path::String)
    if Sys.iswindows() && !isabspath(path)
        path = joinpath(split(path, "/")...)
    end
    return path
end

read_deps(::Nothing) = Dict{String,UUID}()
read_deps(deps) = pkgerror("Expected `deps` field to be either a list or a table.")
function read_deps(deps::AbstractVector)
    ret = String[]
    for dep in deps
        dep isa String || pkgerror("Expected `dep` entry to be a String.")
        push!(ret, dep)
    end
    return ret
end
function read_deps(raw::Dict{String,Any})::Dict{String,UUID}
    deps = Dict{String,UUID}()
    for (name, uuid) in raw
        deps[name] = safe_uuid(uuid)
    end
    return deps
end