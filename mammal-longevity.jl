"""
locks5 stat page 94

MammalLongevity
"""

include("utils.jl")
using HypothesisTests,GLMakie,CSV,DataFrames,ScientificTypes,PrettyTables
using Statistics


df= (let str="MammalLongevity"
      df=load_data(str)
  end)
data=select(df,[:Animal,:Longevity])

function plot_animal_longevity()
    fig=Figure()
    ax=Axis(fig[1,1])
    hist!(ax,data[!,:Longevity];bins=8,strokewidth = 1, strokecolor = :black)
    fig
end

#plot_animal_longevity()


function boxplot_animal_longevity()
    fig=Figure()
    ax=Axis(fig[1,1])
    n=length(data[!,:Longevity])
    boxplot!(ax,fill(1,n),data[!,:Longevity]; orientation=:vertical,
    whiskerwidth = 1, width = 2, color = (:orange, 0.95),
    whiskercolor = :red, mediancolor = :yellow, markersize = 8,
    strokecolor = :black, strokewidth = 1,)
    fig
end

boxplot_animal_longevity()
