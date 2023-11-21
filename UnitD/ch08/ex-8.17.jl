#= 
  lock5stat page 595
  school stree has relation with time with friends
=#

## 1. load package
include("../../utils.jl")

## 2. load data 
desc=Lock5Table(595,"PASeniors","school stree has relation with time with friends",["HangHours","SchoolPressure"])
gdf=@pipe load_csv(desc.name)|>select(_,desc.feature)|>groupby(_,"SchoolPressure")
cats= @pipe keys(gdf).|>values(_)[1] 
group_data=[df.HangHours for df in gdf ]


## 3. summary data 
summary_table=summary_df(cats,group_data);
@pt summary_table
#= 
┌─────────────┬───────┬─────────┬─────────┐
│       Group │     n │    Mean │  Stddev │
│    String15 │ Int64 │ Float64 │ Float64 │
├─────────────┼───────┼─────────┼─────────┤
│ Very little │    38 │ 16.6316 │ 12.5793 │
│       A lot │   139 │ 10.4173 │ 9.49115 │
│        Some │   143 │ 11.6678 │ 12.4461 │
│        None │    11 │ 10.9091 │ 7.50273 │
└─────────────┴───────┴─────────┴─────────┘
=#

## 5. anvoa test
function anova_test(data)
    OneWayANOVATest(data...)
end

anova_test(group_data)

#= 
  One-way analysis of variance (ANOVA) test
-----------------------------------------
Population details:
    parameter of interest:   Means
    value under h_0:         "all equal"
    point estimate:          NaN

Test summary:
    outcome with 95% confidence: reject h_0
    p-value:                     0.0147

Details:
    number of observations: [38, 139, 143, 11]
    F statistic:            3.55201
    degrees of freedom:     (3, 327)

=#

## 6. results
"""
p-value:                     0.0147
因此有充分证据表明不同学业压力分组的社交时间有显著差异
"""


##  7. plot  boxplot 
UnicodePlots.boxplot(cats, group_data, title="school pressure with social time", xlabel="time", ylabel="school pressure")
#= 
 school pressure with social time      
                               ┌                                        ┐ 
                                ╷     ┌────┬───┐                       ╷  
                   Very little  ├─────┤    │   ├───────────────────────┤  
                                ╵     └────┴───┘                       ╵  
                                ╷  ┌─┬───┐                             ╷  
                         A lot  ├──┤ │   ├─────────────────────────────┤  
   school pressure              ╵  └─┴───┘                             ╵  
                                ╷  ┌─┬───┐                             ╷  
                          Some  ├──┤ │   ├─────────────────────────────┤  
                                ╵  └─┴───┘                             ╵  
                                ╷  ┌─┬────────┐╷                          
                          None  ├──┤ │        ├┤                          
                                ╵  └─┴────────┘╵                          
                               └                                        ┘ 
                                0                 25                  50  
                                                  time  
=#