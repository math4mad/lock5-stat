"""
lock5 stat page 102

FloridaLakes

使用  Combinatorics.jl  生成配对索引
"""

include("utils.jl")
using HypothesisTests,GLMakie,CSV,DataFrames,ScientificTypes
using StatsBase,DataFramesMeta,Pipe
using Combinatorics


  df= (let str="FloridaLakes"
      df=load_data(str)
  end)

data=select(df,[:Alkalinity,:pH,:AvgMercury,:ThreeYrStdMercury])
cats=names(data)


function plot_cor()
    combinations_x = combinations([1,2,3,4],2)
    fig=Figure(resolution=(900,600))
    
    for (idx,c) in enumerate(combinations_x)
        local row,col=fldmod1(idx,3)
        local ax = Axis(fig[row, col],xlabel=cats[c[1]],ylabel=cats[c[2]])
        Box(fig[row, col], color = (:orange,0.1))
        scatter!(ax,data[!,c[1]],data[!,c[2]];marker=:circle,markersize=12,color=(:lightgreen,0.2),strokewidth=2,strokecolor=:black)
    end
    fig
    #save("./imgs/floridalakes-scatter-plot.png",fig)
end
#plot_cor()


function computing_cor()
    combinations_x = combinations([1,2,3,4],2)
    Dict("$(cats[c[1]])-$(cats[c[2]])" =>cor(data[!,c[1]],data[!,c[2]])  for (idx,c) in enumerate(combinations_x))
    """
        "Alkalinity-ThreeYrStdMercury" => -0.627958
        "Alkalinity-pH"                => 0.719166
        "pH-ThreeYrStdMercury"         => -0.612849
        "Alkalinity-AvgMercury"        => -0.593897
        "pH-AvgMercury"                => -0.5754
        "AvgMercury-ThreeYrStdMercury" => 0.959215
    """
end
computing_cor()