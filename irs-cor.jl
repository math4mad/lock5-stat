"""
page 157  iris  petal feature cor
data:iris
"""

include("utils.jl")

using GLMakie,CSV,DataFrames
using DataFramesMeta,Pipe,ColorSchemes
using Combinatorics

df= (let str="iris"
df=load_data(str)
end)

data=select(df,1:4)

function plot_cor_group(data::SubDataFrame)
    cats=names(data)
    combinations_x = combinations(1:length(cats),2)
    cbarPal = :thermal
    cmap = cgrad(colorschemes[cbarPal], length(combinations_x), categorical = true)
    fig=Figure(resolution=(900,600))
    
    for (idx,c) in enumerate(combinations_x)
        local row,col=fldmod1(idx,3)
        local ax = Axis(fig[row, col],xlabel=cats[c[1]],ylabel=cats[c[2]])
        Box(fig[row, col], color = (:orange,0.1))
        scatter!(ax,data[!,c[1]],data[!,c[2]];marker=:circle,markersize=12,color=(cmap[idx],0.2),strokewidth=2,strokecolor=:black)
    end
    fig
    #save("./imgs/iris-scatter-plot.png",fig)
end
plot_cor_group(data)