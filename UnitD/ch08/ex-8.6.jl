#= 
 lock5stat page 591
=#

## 1. load package
include("data-8.1-SandwichAnts.jl")
gdf=@pipe select(df,["Filling","Ants"])|>groupby(_,"Filling")
cats= @pipe keys(gdf).|>values(_)[1] 
group_data=[df.Ants.|>Int for df in gdf ]

n=size(df,1)
ants_mean_std=df.Ants|>mean_and_std

sstotal=mapreduce(x->(x-ants_mean_std[1])^2,+,df.Ants)
