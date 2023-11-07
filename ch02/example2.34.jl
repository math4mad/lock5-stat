## 1. load package
include("utils.jl")
using HypothesisTests, GLMakie, CSV, DataFrames, ScientificTypes
using StatsBase, DataFramesMeta, Pipe


## 2. data processing
#= 
 feature ["ID", "Lake", "Alkalinity", "pH", "Calcium", "Chlorophyll", "AvgMercury", "NumSamples", "MinMercury", "MaxMercury", "ThreeYrStdMercury", "AgeData"]
=#
desc = Lock5Table(141, "FloridaLakes", "Scatterplots from Florida Lakes", ["Alkalinity", "pH", "AvgMercury", "ThreeYrStdMercury"])
data = @pipe load_csv(desc.name) |> select(_, desc.feature)

function plot_cor(df::AbstractDataFrame, ax)
    cats = names(df)
    ax.xlabel = cats[1]
    ax.ylabel = cats[2]
    scatter!(ax, eachcol(df)...; markersize=12, color=(:lightgreen, 0.2), strokecolor=:black, strokewidth=1)
end

features = [["pH", "AvgMercury"],
    ["Alkalinity", "AvgMercury"],
    ["pH", "Alkalinity"],
    ["ThreeYrStdMercury", "AvgMercury"]
]
function plot_res()
    fig = Figure(resolution=(800, 800))
    axs = [Axis(fig[i, j]) for i in 1:2, j in 1:2]
    for (idx, ax) in enumerate(axs)
        df = select(data, features[idx])
        plot_cor(df, ax)
    end
    fig
end
fig = plot_res()
#save("./ch02/example2-34.png",fig)
