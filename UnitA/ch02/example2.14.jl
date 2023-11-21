#= 
  ["ID", "Lake", "Alkalinity", "pH", "Calcium", "Chlorophyll", "AvgMercury", "NumSamples", "MinMercury", "MaxMercury", "ThreeYrStdMercury", "AgeData"]
=#
include("../../utils.jl")
using HypothesisTests,GLMakie,CSV,DataFrames,ScientificTypes,PrettyTables
using Statistics,DataFramesMeta
desc=Lock5Table(102,"FloridaLakes","desc Alkalinity values",[])
data= @pipe load_csv(desc.name) #|>select(_,desc.feature)

function plot_hist()
    fig=Figure()
    ax=Axis(fig[1,1],xlabel="Alkalinity value",ylabel="Frequency")
    hist!(ax,data.Alkalinity;stroke=:black,strokewidth=1)
    fig
end

fig=plot_hist();save("./ch02/imgs/lake-alkaline-hist.png",fig)