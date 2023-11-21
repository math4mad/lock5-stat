
## 1. load package
include("../../utils.jl")
include("data-8.1-SandwichAnts.jl")
##  2. load data

gdf=@pipe select(df,["Filling","Ants"])|>groupby(_,"Filling")
cats= @pipe keys(gdf).|>values(_)[1] 
group_data=[df.Ants for df in gdf ]


## 3. summary_df
summary_table=summary_df(cats,group_data);
#@pt summary_table
#= 
┌───────────────┬───────┬─────────┬─────────┐
│         Group │     n │    Mean │  Stddev │
│      String15 │ Int64 │ Float64 │ Float64 │
├───────────────┼───────┼─────────┼─────────┤
│      Vegemite │     8 │   30.75 │ 9.25434 │
│ Peanut Butter │     8 │    34.0 │ 14.6287 │
│ Ham & Pickles │     8 │   49.25 │ 10.7935 │
└───────────────┴───────┴─────────┴─────────┘
=#

## 4. boxplot 
UnicodePlots.boxplot(cats, group_data, title="ants in diff filling", xlabel="ants", ylabel="group")
"""
   ants in diff filling            
                       ┌                                        ┐ 
                            ╷   ┌───┬─────┐ ╷                     
              Vegemite      ├───┤   │     ├─┤                     
                            ╵   └───┴─────┘ ╵                     
                             ╷ ┌─────┬────────┐         ╷         
   group Peanut Butter       ├─┤     │        ├─────────┤         
                             ╵ └─────┴────────┘         ╵         
                                       ╷    ┌─────┬──┐      ╷     
         Ham & Pickles                 ├────┤     │  ├──────┤     
                                       ╵    └─────┴──┘      ╵     
                       └                                        ┘ 
                        10                40                  70  
                                          ants       
"""

##  5. all data  summary

all_mean_std=@pipe select(df,"Ants")|>_.Ants|>mean_and_std #(38.0, 13.947105044791007)

