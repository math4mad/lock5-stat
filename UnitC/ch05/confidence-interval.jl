using Distributions,GLMakie

d=TDist(5)
xs=Vector(range(-4,4,100))

"""
plot_level_band 的参数 struct
"""
Base.@kwdef struct PvalueParams
    ran::Vector
    dist::ContinuousDistribution
    level::Real=0.05
    double::Bool=true
end



"""
    plot_level_band(ax::Axis,params::PvalueParams)
    绘制 显著性水平 band 图
## params
   1. ax  Makie Axis 对象
   2.  struct  PvalueParams

"""
function plot_level_band(ax::Axis,params::PvalueParams)
    
    l,h=extrema(params.ran)
    as1=Vector(range(l,quantile(params.dist,params.level/2),100))
    as2=Vector(range(quantile(params.dist,1-params.level/2),h,100))
    ys_low1=ys_low2 =fill(0,100)
    ys_high1 = pdf.(params.dist,as1)
    ys_high2 = pdf.(params.dist,as2)
 return  (band!(ax, as1,ys_low1, ys_high1,color=(:red,0.5)),
          band!(ax, as2,ys_low2, ys_high2,color=(:red,0.5)))
    
end


params=PvalueParams(ran=xs,dist=d)

function plot_demo()
    fig=Figure()
    ax=Axis(fig[1,1])
    lines!(ax, xs, pdf.(d,xs))
    plot_level_band(ax,params)
    fig
    #ave("significance-levels.png",fig)
end

plot_demo()