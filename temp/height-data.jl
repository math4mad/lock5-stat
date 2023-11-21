"""
page  179
data:HeightData
"""

include("utils.jl")
using GLMakie,CSV,DataFrames
using DataFramesMeta,StatsBase,Pipe

str="HeightData"
data=load_data(str)
colors=[:blue,:red]

function plot_height_data()
    fig=Figure()
    ax=Axis(fig[1,1],xlabel="Age",ylabel="Height")
    for row in  eachrow(data)
       d=Array(row[3:end])
       c=row[2]=="M" ? colors[1] : colors[2]
       sex=row[2]=="M" ? "Male" :  "Female"
       lines!(ax,d;color=c,label="$sex")
    end
     axislegend(ax, merge = true,unique=false)
    fig
    #save("age-height-2.png",fig)
    
end

plot_height_data()



