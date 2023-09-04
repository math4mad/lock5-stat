using GLMakie,Distributions

ws=[1,0.8,0.5,0.3,0.2,0.1]
d=Normal()
xs=-3:0.1:3
xs2=-3:w:5
ys=pdf.(d,xs)

"""
## define Rect
rect = Rect(start-x,start-y,w,height)
"""
function  rect(;x=0,w=0.5)
    return  Rect(x,0,w,pdf.(d,x))
end

boxs=[rect(;x=x,w=w) for x in  xs2]

function plot_res()
    fig=Figure()
    ax=Axis(fig[1,1])
    lines!(ax,xs,ys)
    # for  x in xs2
    #     rect=Rect(0,0,w,pdf.(d,x))
    #     #mesh!(ax, rect(;x=x) ; color=(:gray,0.3),transparency=false)
    #     meshscatter!(ax,Vec(x,0); marker=rect,markersize=0.97, color=(:blue,0.4))
    # end
    for  i in eachindex(boxs)
        mesh!(ax, boxs[i], color=(:lightblue,0.4))
        wireframe!(ax, boxs[i]; color = :black, transparency=true)
    end
    fig
    #save("one-single-variable-euler-method.png",fig)
end

plot_res()


