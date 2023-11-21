#= 
 lock5stat page 587 figure8.4
=#

include("../../utils.jl")

d=FDist(2, 21)

xs=0:0.1:8
xs2=0:0.2:8
ys=pdf.(d,xs)

"""
## define Rect
rect = Rect(start-x,start-y,w,height)
"""
function  rect(;x=0,w=0.2)
    return  Rect(x,0,w,pdf.(d,x))
end

boxs=[rect(;x=x,w=0.2) for x in  xs2]

function plot_res()
    fig=Figure()
    ax=Axis(fig[1,1])
    ax.title="fdist(2,21)"
    lines!(ax,xs,ys;linewidth=3,color=:purple)
    
    for  i in eachindex(boxs)
        mesh!(ax, boxs[i], color=(:lightblue,0.4))
        wireframe!(ax, boxs[i]; color = :black, transparency=true)
    end
    fig
    #save("UnitD/ch08/fdist-21-2.png",fig)
end

plot_res()