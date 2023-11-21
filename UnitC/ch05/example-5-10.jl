include("../../utils.jl")
include("./confidence-interval.jl")


d=Normal(40,5)
xs=Vector(range(-10,10,100))

params=PvalueParams(ran=xs,dist=d)

function plot_95levels()
    fig=Figure()
    ax=Axis(fig[1,1])
    #limits!(ax,20,60,0,0.1)
    lines!(ax, xs, pdf.(d,xs))
    plot_level_band(ax,params)
    fig
    #ave("significance-levels.png",fig)
end


plot_95levels()