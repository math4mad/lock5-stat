#= 
D.5 Does Average Tip Percentage Vary by Server?
=#

## 1.load package
include("../../utils.jl")

## 2. load data 
include("restaurant-tips-data.jl")

data=select(df,:Server,:PctTip)
gdf=groupby(data,:Server)
cats = @pipe keys(gdf) .|> values(_)[1]
group_data=[df.PctTip for df in gdf]


summary_data=summary_df(cats,group_data)

#= 
┌─────────┬───────┬─────────┬─────────┐
│   Group │     n │    Mean │  Stddev │
│ String1 │ Int64 │ Float64 │ Float64 │
├─────────┼───────┼─────────┼─────────┤
│       A │    60 │ 17.5433 │ 5.50397 │
│       B │    65 │ 16.0169 │ 3.48517 │
│       C │    32 │ 16.1094 │ 3.37556 │
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
    p-value:                     0.1132

Details:
    number of observations: [60, 65, 32]
    F statistic:            2.21008
    degrees of freedom:     (2, 154)
=#

## 4. results
#= 
  三个服务商之间的小费比例均值不同
=#


