"""
page 112
"""

include("utils.jl")
using HypothesisTests,GLMakie,CSV,DataFrames,ScientificTypes
using Statistics,DataFramesMeta,Pipe

  df= (let str="Cars2020"
      df=load_data(str)
  end)

 data=df[!,:QtrMile]

 function plot_QtrMile_hist(data)
    fig=Figure()
    ax=Axis(fig[1,1],title="Car QtrMile",xlabel="QtrMile",ylabel="frequency")
    hist!(ax,data;strokewidth = 1, strokecolor = :black,color=(:gray,0.6))
    fig
    #save("./imgs/Car2020_QtrMile_hist.png",fig)
end 

plot_QtrMile_hist(data)