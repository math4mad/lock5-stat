#= 
  lock5stat page 494
=#

## 1. load package
include("../../utils.jl")
using UnicodePlots
## 2. load data 
desc=Lock5Table(494,"Smiles","example-6.27",["Leniency", "Group"])
gdf=@pipe load_csv(desc.name)|>groupby(_,desc.feature[2])

## 3. desc table
data=[i.Leniency for i in gdf]
Group=names(gdf)
summary_df=DataFrame(Group=Group,
                     n=size.(data,1),
                     Mean=mean.(data),
                     Stddev=std.(data)
                     )
#@pt summary_df
#= 
┌─────────┬───────┬─────────┬─────────┐
│   Group │     n │    Mean │  Stddev │
│  String │ Int64 │ Float64 │ Float64 │
├─────────┼───────┼─────────┼─────────┤
│   smile │    34 │ 4.91176 │ 1.68087 │
│ neutral │    34 │ 4.11765 │ 1.52285 │
└─────────┴───────┴─────────┴─────────┘
=#

## 4. box plot
UnicodePlots.boxplot(Group,data,title="Grouped Boxplot", xlabel="Leniency",ylabel="Group")

"""
                 Grouped Boxplot              
                 ┌                                        ┐ 
                    ╷     ┌──────┬─────┐                 ╷  
           smile    ├─────┤      │     ├─────────────────┤  
   Group            ╵     └──────┴─────┘                 ╵  
                  ╷    ┌────┬────┐                 ╷        
         neutral  ├────┤    │    ├─────────────────┤        
                  ╵    └────┴────┘                 ╵        
                 └                                        ┘ 
                  2                 5.5                  9  
                                  Leniency                
"""

EqualVarianceTTest(data...)
#= 
Two sample t-test (equal variance)
----------------------------------
Population details:
    parameter of interest:   Mean difference
    value under h_0:         0
    point estimate:          0.794118
    95% confidence interval: (0.01749, 1.571)

Test summary:
    outcome with 95% confidence: reject h_0
    two-sided p-value:           0.0452

Details:
    number of observations:   [34,34]
    t-statistic:              2.04153849287233
    degrees of freedom:       66
    empirical standard error: 0.38898000200894833
=#


