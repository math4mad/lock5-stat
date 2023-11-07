## 1. load package
include("utils.jl")
using HypothesisTests, GLMakie, CSV, DataFrames, ScientificTypes
using StatsBase, DataFramesMeta, Pipe


## 2. data processing
#= 
 feature ["Name", "Brewer", "WifeRating", "HusbandRating", "WifeComments", "HusbandComments", "Average", "Year"]
=#
desc = Lock5Table(155, "PumpkinBeer", "", ["Year","Average"])
data = @pipe load_csv(desc.name)|>select(_,desc.feature)

@info cor(eachcol(data)...)  # 0.08
function plot_cor()
    fig=Figure()
    ax=Axis(fig[1,1],title="year-average-rating-cor")
    ax.xlabel=desc.feature[1]
    ax.ylabel=desc.feature[2]
    scatter!(ax,eachcol(data)...; markersize=10, color=(:lightgreen, 0.5), strokecolor=:black, strokewidth=1)
    fig
end

plot_cor()



