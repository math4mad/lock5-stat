#= 
D.6 Does Size of the Bill Vary by Server?
=#

## 1.load package
include("../../utils.jl")

## 2. load data 
include("restaurant-tips-data.jl")

data=select(df,:Server,:Bill)
gdf=groupby(data,:Server)
cats = @pipe keys(gdf) .|> values(_)[1]
group_data=[df.Bill for df in gdf]
summary_data=summary_df(cats,group_data);

#= 
┌─────────┬───────┬─────────┬─────────┐
│   Group │     n │    Mean │  Stddev │
│ String1 │ Int64 │ Float64 │ Float64 │
├─────────┼───────┼─────────┼─────────┤
│       A │    60 │  22.755 │ 12.7116 │
│       B │    65 │ 21.1365 │ 10.1935 │
│       C │    32 │ 25.9153 │ 14.3496 │
└─────────┴───────┴─────────┴─────────┘
=#

OneWayANOVATest(group_data...)

#= 
One-way analysis of variance (ANOVA) test
-----------------------------------------
Population details:
    parameter of interest:   Means
    value under h_0:         "all equal"
    point estimate:          NaN

Test summary:
    outcome with 95% confidence: fail to reject h_0
    p-value:                     0.1643

Details:
    number of observations: [60, 65, 32]
    F statistic:            1.8273
    degrees of freedom:     (2, 154)
=#

## 4. results
#= 
  不同服务商的账单大小没有差异
=#

