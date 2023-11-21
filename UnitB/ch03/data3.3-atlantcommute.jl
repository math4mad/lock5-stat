
## 1. load package
include("../../utils.jl")
  using GLMakie,CSV,DataFrames,Random,StatsBase,PrettyTables,Pipe

##  2. load data
  #= 
    feature :["City", "Age", "Distance", "Time", "Sex"]
  =#
  desc=Lock5Table(270,"CommuteAtlanta","data3.1",["City", "Age", "Distance", "Time", "Sex"])
  df=@pipe load_csv(desc.name)|>select(_,desc.feature[4])
#= 
┌─────────┬───────┬──────────┬───────┬─────────┐
│    City │   Age │ Distance │  Time │     Sex │
│ String7 │ Int64 │    Int64 │ Int64 │ String1 │
├─────────┼───────┼──────────┼───────┼─────────┤
│ Atlanta │    19 │       10 │    15 │       M │
│ Atlanta │    55 │       45 │    60 │       M │
│ Atlanta │    48 │       12 │    45 │       M │
│ Atlanta │    45 │        4 │    10 │       F │
│ Atlanta │    48 │       15 │    30 │       F │
└─────────┴───────┴──────────┴───────┴─────────┘
=#

function plot_dotplot(gdf::GroupedDataFrame;title="CommuteAtlanta Time sampling")
  xs=@pipe keys(gdf).|>values(_)[1]
  ys=[nrow(g) for g in gdf]
  fig=Figure(resolution=(1200,500))
  ax=Axis(fig[1,1],xlabel="Time",ylabel="Count",title=title)
  Box(fig[1,1];color =(:orange,0.1),strokewidth=0.2)

  for (idx, x) in enumerate(xs)
      
      for y in 1:ys[idx]
          
          scatter!(ax,x,y
          ;marker=:circle,markersize=10,color=:black
          ,strokewidth=0.1,strokecolor=:black)
      end
  end
  
 fig
end


fig=groupby(df,:Time)|>plot_dotplot
#save("data3.3-atlantcommute-dotplot.png",fig)

