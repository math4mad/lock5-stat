"""
page 198
data:CityTemps


"""


include("utils.jl")

using GLMakie,CSV,DataFrames
using DataFramesMeta,StatsBase
using GLM,LinearAlgebra


data_str="CityTemps"
feature=["Moscow","Melbourne","San Francisco"]

data=pair_data(data_str,feature)|>Matrix|>transpose

function plot_spaghetti()
    fig=Figure(resolution=(1000,500))
    ax=Axis(fig[1,1])
    series!(ax,data;linewidth=3,labels=[" $i" for i in feature])
    axislegend()
    fig
    #save("city-temp-spaghetti.png",fig)

end
plot_spaghetti()