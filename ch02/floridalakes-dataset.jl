"""
lock5 stat page 102

FloridaLakes
"""

include("utils.jl")
using HypothesisTests,GLMakie,CSV,DataFrames,ScientificTypes
using Statistics,DataFramesMeta,Pipe

  df= (let str="FloridaLakes"
      df=load_data(str)
  end)

  
function plot_alkalinity_hist(df)
    alkalinity=select(df,:Alkalinity)|>Array|>d->d[:,1]
    mea,med=mean(alkalinity),median(alkalinity)
    fig=Figure()
    ax=Axis(fig[1,1],title=" floridalakes alkalinity",xlabel="alkalinity",ylabel="frequency")
    hist!(ax,alkalinity;strokewidth = 1, strokecolor = :black,color=(:gray,0.6))
    vlines!(ax,[mea],label="mean")
    vlines!(ax,[med],label="median")
    axislegend(ax)
    fig
    #save("./imgs/floridalakes-alkalinity.png",fig)
end 

plot_alkalinity_hist(df)
