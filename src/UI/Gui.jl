using  Gtk

if isdefined(Base, :Experimental) && isdefined(Base.Experimental, Symbol("@optlevel"))
    @eval Base.Experimental.@optlevel 1
end
 
# Import binary definitions
const suffix = :Leaf
#=include("GLib/GLib.jl") #important =#
#= Import GLib - this is from staticfloat/GlibcBuilder imports  skippable 
using .GLib
using .GLib.MutableTypes
import .GLib: set_gtk_property!, get_gtk_property, getproperty, FieldRef
import .GLib:
    signal_connect, signal_handler_disconnect,
    signal_handler_block, signal_handler_unblock, signal_handler_is_connected,
    signal_emit, unsafe_convert,
    AbstractStringLike, bytestring
=#
"""Guide 

GTK3_jll: standard Gtk package Imports 

#icon packages (2):
##1.hicolor_icon_theme_jll
##2. adwaita_icon_theme_jll


"""
#this is for MinGTK 
using GTK3_jll, Glib_jll, Xorg_xkeyboard_config_jll, gdk_pixbuf_jll, adwaita_icon_theme_jll, hicolor_icon_theme_jll #done 

using Librsvg_jll
using JLLWrappers 
using Pkg.Artifacts #ok # ] add Artifacts
#const libgdk # = libgdk3
#const libgtk # = libgtk3
#const libgdk_pixbuf # = libgdkpixbuf




import Base: convert, show, run, size, resize!, length, getindex, setindex!,
             insert!, push!, append!, pushfirst!, pop!, splice!, delete!, deleteat!,
             parent, isempty, empty!, first, last, in, popfirst!,
             eltype, copy, isvalid, string, sigatomic_begin, sigatomic_end, (:), iterate #fix: adds c.jl fixes sigatomic_begin,  sigatomic_end ccalls #crucil 

export showall, select!, start

using Reexport

#Import Graphics: width, height, getgc

@reexport using Graphics # lets you import the following from Graphics package:
import Graphics: width, height, getgc

using Cairo
import Cairo: destroy
using Serialization

const Index{I<:Integer} = Union{I, AbstractVector{I}}

export GAccessor


#= not found 
include("basic_exports.jl")
include("long_exports.jl")
include("long_leaf_exports.jl")

=#



#=

=#
global const libgtk_version = VersionNumber(
      ccall((:gtk_get_major_version, libgtk), Cint, ()),
      ccall((:gtk_get_minor_version, libgtk), Cint, ()),
      ccall((:gtk_get_micro_version, libgtk), Cint, ()))

      """
        __init__

        ```input
        setting up Gtk required files (icons & schemas)
        sets a particular Environment variable for each OS(OS-specific):
        Windows:  ENV["XDG_DATA_DIRS"]
        

        ```
references to: 
gdk-pixbuf-loaders-cache
gdk-pixbuf-loaders-dir

    """
function __init__()
    #for windows 
    # Set XDG_DATA_DIRS so that Gtk can find its icons & schemas
    ENV["XDG_DATA_DIRS"] = join(filter(x -> x !== nothing, [
            dirname(adwaita_icons_dir),
            dirname(hicolor_icons_dir),
            joinpath(dirname(GTK3_jll.libgdk3_path::String), "..", "share"),
            get(ENV, "XDG_DATA_DIRS", nothing)::Union{String,Nothing}, # getting XDG_DATA_DIRS
        ]), Sys.iswindows() ? ";" : ":")

    # Next, ensure that gdk-pixbuf has its loaders.cache file; we generate a #review#1: what do you mean by this (whomever wrote this)
    # MutableArtifacts.toml file that maps in a loaders.cache we dynamically
    # generate by running `gdk-pixbuf-query-loaders:`
    mutable_artifacts_toml = joinpath(dirname(@__DIR__), "MutableArtifacts.toml")
    loaders_cache_name = "gdk-pixbuf-loaders-cache"
    loaders_cache_hash = artifact_hash(loaders_cache_name, mutable_artifacts_toml)
    loaders_dir_name = "gdk-pixbuf-loaders-dir"
    loaders_dir_hash = artifact_hash(loaders_dir_name, mutable_artifacts_toml)

    if loaders_cache_hash === nothing
        if Librsvg_jll.is_available()
            # Copy loaders into a directory
            loaders_dir_hash = create_artifact() do art_dir
                loaders_dir = mkdir(joinpath(art_dir, "loaders_dir"))
                pixbuf_loaders = joinpath.(gdk_pixbuf_loaders_dir, readdir(gdk_pixbuf_loaders_dir))
                push!(pixbuf_loaders, Librsvg_jll.libpixbufloader_svg)
                cp.(pixbuf_loaders, joinpath.(loaders_dir, basename.(pixbuf_loaders)))
            end

            loaders_dir = joinpath(artifact_path(loaders_dir_hash), "loaders_dir")
            # Pkg removes "execute" permissions on Windows
            Sys.iswindows() && chmod(artifact_path(loaders_dir_hash), 0o755; recursive = true)
            # Run gdk-pixbuf-query-loaders, capture output
            loader_cache_contents = gdk_pixbuf_query_loaders() do gpql
                withenv("GDK_PIXBUF_MODULEDIR" => loaders_dir, JLLWrappers.LIBPATH_env => Librsvg_jll.LIBPATH[]) do
                    return String(readchomp(`$gpql`))
                end
            end

            bind_artifact!(mutable_artifacts_toml,
                loaders_dir_name,
                loaders_dir_hash;
                force = true
            )
        else  # just use the gdk_pixbuf directory
            loader_cache_contents = gdk_pixbuf_query_loaders() do gpql
                withenv("GDK_PIXBUF_MODULEDIR" => gdk_pixbuf_loaders_dir) do
                    return String(read(`$gpql`))
                end
            end
        end
        # Write cache out to file in new artifact
        loaders_cache_hash = create_artifact() do art_dir
            open(joinpath(art_dir, "loaders.cache"), "w") do io
                write(io, loader_cache_contents)
            end
        end
        bind_artifact!(mutable_artifacts_toml,
            loaders_cache_name,
            loaders_cache_hash;
            force = true
        )
    end

    # Point gdk to our cached loaders
    ENV["GDK_PIXBUF_MODULE_FILE"] = joinpath(artifact_path(loaders_cache_hash), "loaders.cache")
    ENV["GDK_PIXBUF_MODULEDIR"] = Librsvg_jll.is_available() && loaders_dir_hash !== nothing ?
                                  joinpath(artifact_path(loaders_dir_hash), "loaders_dir") :
                                  gdk_pixbuf_loaders_dir

    if Sys.islinux() || Sys.isfreebsd()
        # Needed by xkbcommon:
        # https://xkbcommon.org/doc/current/group__include-path.html.  Related
        # to issue https://github.com/JuliaGraphics/Gtk.jl/issues/469
        ENV["XKB_CONFIG_ROOT"] = joinpath(Xorg_xkeyboard_config_jll.artifact_dir::String,
            "share", "X11", "xkb")
    end

    GError() do error_check # GError #not defined
        ccall((:gtk_init_with_args, libgtk), Bool,
            (Ptr{Nothing}, Ptr{Nothing}, Ptr{UInt8}, Ptr{Nothing}, Ptr{UInt8}, Ptr{Ptr{GError}}),
            C_NULL, C_NULL, "Julia Gtk Bindings", C_NULL, C_NULL, error_check)
    end

    # if g_main_depth > 0, a glib main-loop is already running.
    # unfortunately this call does not reliably reflect the state after the
    # loop has been stopped or restarted, so only use it once at the start
    gtk_main_running[] = ccall((:g_main_depth, GLib.libglib), Cint, ()) > 0

    # Given GLib provides `g_idle_add` to specify what happens during idle, this allows
    # that call to also start the eventloop
    GLib.gtk_eventloop_f[] = enable_eventloop

    auto_idle[] = get(ENV, "GTK_AUTO_IDLE", "true") == "true"

    # by default, defer starting the event loop until either `show`, `showall`, or `g_idle_add` is called
    enable_eventloop(!auto_idle[])
end

const auto_idle = Ref{Bool}(true) # control default via ENV["GTK_AUTO_IDLE"]
const gtk_main_running = Ref{Bool}(false)
const quit_task = Ref{Task}()
const enable_eventloop_lock = Base.ReentrantLock() # 