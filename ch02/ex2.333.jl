## 1. load package
include("utils.jl")
using HypothesisTests, GLMakie, CSV, DataFrames, ScientificTypes
using StatsBase, DataFramesMeta, Pipe

## 2. data processing
#= 
feature ["Player", "Pos", "Age", "Team", "Games", "Starts", "Mins", "MinPerGame", "FGMade", "FGAttempt", "FGPct", "FG3Made", "FG3Attempt", "FG3Pct", "FTMade", "FTAttempt", "FTPct", "OffRebound", "DefRebound", "Rebounds", "Assists", "Steals", "Blocks", "Turnovers", "Fouls", "Points"]
=#
desc = Lock5Table(158, "NBAPlayers2019", "Offensive Rebounds vs Defensive Rebounds", ["OffRebound", "DefRebound"])
data = @pipe load_csv(desc.name)|>select(_,desc.feature)

## 3. plot cor 

function plot_cor()
    fig=Figure()
    ax=Axis(fig[1,1])
    ax.xlabel=desc.feature[1]
    ax.ylabel=desc.feature[2]
    scatter!(ax,eachcol(data)...; markersize=10, color=(:lightgreen, 0.5), strokecolor=:black, strokewidth=1)

    fig
end
fig=plot_cor()
#save("./ch02/imgs/ex2.233.png",fig)

## 4.  summary of  cor  
#cor(eachcol(data)...)  #0.729