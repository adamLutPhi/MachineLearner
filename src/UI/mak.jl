using MakieLayout
using Makie
using KernelDensity


function kdepoly!(la::LAxis, vec, reverse=false; kwargs...)
    kderesult = kde(vec; npoints=32)

    x = kderesult.x
    y = kderesult.density

    if reverse
        poly!(la, Point2.(y, x); kwargs...)
    else
        poly!(la, Point2.(x, y); kwargs...)
    end
end

begin
    scene = Scene(resolution = (1000, 1000));
    screen = display(scene)
    campixel!(scene);

    la1 = LAxis(scene)
    la2 = LAxis(scene)
    la3 = LAxis(scene)
    la4 = LAxis(scene)
    la5 = LAxis(scene)

    linkxaxes!(la3, la4)
    linkyaxes!(la3, la5)

    fakeaudiox = LinRange(0f0, 1000f0, 100_000)
    fakeaudioy = (rand(Float32, 100_000) .- 0.5f0) .+ 2 .* sin.(fakeaudiox .* 10)
    lines!(la1, fakeaudiox, fakeaudioy, show_axis=false)
    la1.attributes.title[] = "A fake audio signal"
    la1.attributes.ypanlock[] = true
    la1.attributes.yzoomlock[] = true

    linkeddata = randn(200, 2) .* 15 .+ 50
    green = RGBAf0(0.05, 0.8, 0.3, 0.6)
    scatter!(la3, linkeddata, markersize=3, color=green, show_axis=false)
    kdepoly!(la4, linkeddata[:, 1], false, color=green, linewidth=2, show_axis=false)
    kdepoly!(la5, linkeddata[:, 2], true, color=green, linewidth=2, show_axis=false)

    linkeddata2 = randn(200, 2) .* 20 .+ 70
    red = RGBAf0(0.9, 0.1, 0.05, 0.6)
    scatter!(la3, linkeddata2, markersize=3, color=red, show_axis=false)
    kdepoly!(la4, linkeddata2[:, 1], false, color=red, linewidth=2, show_axis=false)
    kdepoly!(la5, linkeddata2[:, 2], true, color=red, linewidth=2, show_axis=false)

    maingl = GridLayout(scene, 2, 1, alignmode=Outside(40)) #makie error in the tutorial #scene rendering  function

    sledg = maingl[2, 1] = LSlider(scene, range = LinRange(0.0, 150.0, 200))


    gl = maingl[1, 1] = GridLayout(
        2, 2;
        rowsizes = [Aspect(1, 1.0), Auto()], #Comment:Aspect Ratio is not a Golden Ratio  
        colsizes = [Relative(0.5), Auto()],
        addedrowgaps = Fixed(20),
        addedcolgaps = Fixed(20),
        alignmode = Outside(0))

    on(slalign.value) do v
        with_updates_suspended(maingl) do
            gl.addedrowgaps = MakieLayout.GapSize[Fixed(v)]
            gl.addedcolgaps = MakieLayout.GapSize[Fixed(v)]
        end
    end

    gl_slider = gl[1, 2] = GridLayout(
        3, 1;
        rowsizes = [Auto(), Auto(), Auto()],
        colsizes = [Relative(1)],
        addedrowgaps = [Fixed(15), Fixed(15)])

    gl_colorbar = gl_slider[1, 1] = GridLayout(1, 2; colsizes=[Auto(), Relative(0.1)])

    gl_colorbar[1, 1] = la2
    # gl_colorbar[1, 2] = LColorbar(scene)

    sl1 = gl_slider[2, 1] = LSlider(scene, range = 1:0.01:10)
    sl2 = gl_slider[3, 1] = LSlider(scene, range = 0.1:0.01:1)

    xrange = LinRange(0, 2pi, 500)
    lines!(
        la2,
        xrange ./ 2pi .* 100,
        lift((x, y)->sin.(xrange .* x) .* 40 .* y .+ 50, sl1.value, sl2.value),
        color=:blue, linewidth=2, show_axis=false)

    gl[2, :] = la1

    gl2 = gl[1, 1] = GridLayout(
        2, 2,
        rowsizes = [Auto(), Relative(0.8)],
        colsizes = [Aspect(2, 1.0), Auto()],
        addedrowgaps = [Fixed(10)],
        addedcolgaps = [Fixed(10)])

    gl2[2, 1] = la3
    la3.titlevisible[] = false

    gl2[1, 1] = la4
    la4.xlabelvisible[] = false
    la4.xticklabelsvisible[] = false
    la4.xticksvisible[] = false
    la4.titlevisible[] = false
    la4.ypanlock[] = true
    la4.yzoomlock[] = true

    gl2[2, 2] = la5
    la5.ylabelvisible[] = false
    la5.yticklabelsvisible[] = false
    la5.yticksvisible[] = false
    la5.titlevisible[] = false
    la5.xpanlock[] = true
    la5.xzoomlock[] = true
end