using GLMakie,Distributions,Pipe

ws=[1,0.8,0.5,0.3,0.2,0.1] #Δx 数组
d=Normal()
xs=-3:0.1:3 
ys=pdf.(d,xs)

"""
## define Rect
rect = Rect(start-x,start-y,width,height)
"""
function  rect(;x=0,w=0.5)
    return  Rect(x,0,w,pdf.(d,x))
end

"""
    plot_hist(ax,box)
    绘制欧拉方法中的矩形

    ## 参数
    1. ax:makie axis
    2. box: @ref rect
    ## 函数体
```julia
        mesh!(ax, box, color=(:lightblue,0.4))
        wireframe!(ax, box; color = :black, transparency=true)
```
    

TBW
"""
function plot_hist(ax,box)
    mesh!(ax, box, color=(:lightblue,0.4))
    wireframe!(ax, box; color = :black, transparency=true)
end

function plot_res()
    fig=Figure()
    for (idx,w) in enumerate(ws)
        local ax=Axis(fig[fldmod1(idx,3)...],title=L"Δx=%$(w)")
        lines!(ax,xs,ys)
        @pipe  Vector(-3:w:3).|>rect(;x=_,w=w).|>plot_hist(ax,_)
    end
    fig
    #save("one-single-variable-euler-method-2.png",fig)
end

plot_res()


