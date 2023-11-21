#= 
  lock5stat page 598
  Sandwich Ants and Bread
=#

## 1. load package
include("../../utils.jl")

## 2 load data 
desc=Lock5Table(598,"SandwichAnts","Sandwich Ants and Bread",["Bread", "Ants"])
gdf=@pipe load_csv(desc.name)|>select(_,desc.feature)|>groupby(_,:Bread)
cats= @pipe keys(gdf).|>values(_)[1] 
group_data=[df.Ants for df in gdf ]


## 3. summary data 
function summary_df(cats,group_data)
    summary_df = DataFrame(Group=cats,
    Ants=group_data,
    Mean=mean.(group_data),
    Stddev=std.(group_data))
    return  summary_df
end
summary_df(cats,group_data)

#= 
4×4 DataFrame
 Row │ Group       Ants                      Mean     Stddev  
     │ String15    SubArray…                 Float64  Float64 
─────┼────────────────────────────────────────────────────────
   1 │ Rye         [18, 43, 44, 31, 36, 54]  37.6667  12.4043
   2 │ Wholemeal   [29, 59, 34, 21, 47, 65]  42.5     17.4098
   3 │ Multigrain  [42, 22, 36, 38, 19, 59]  36.0     14.519
   4 │ White       [42, 25, 49, 25, 21, 53]  35.8333  13.8624

=#