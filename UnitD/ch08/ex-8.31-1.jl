#= 
LightatNight
lock5stat page 599
LD standard light/dark cycle, 
LL  bright light all the time,
DM  dim light when  normally  darkness.
=#

## 1. load package
include("../../utils.jl")
using GLMakie
## 2.load  data 

desc=Lock5Table(599,"LightatNight4Weeks","anova",["Light", "BMGain"])
gdf=@pipe load_csv(desc.name)|>select(_,desc.feature)|>groupby(_,:Light)
cats= @pipe keys(gdf).|>values(_)[1] 
group_data=[df.BMGain for df in gdf ]


## 3. summary  data
s_df=summary_df(cats,group_data)
@pt s_df
#= 
┌─────────┬───────┬─────────┬─────────┐
│   Group │     n │    Mean │  Stddev │
│ String3 │ Int64 │ Float64 │ Float64 │
├─────────┼───────┼─────────┼─────────┤
│      LL │     9 │   11.01 │ 2.62399 │
│      DM │    10 │   7.859 │ 3.00929 │
│      LD │     8 │ 5.92625 │ 1.89942 │
└─────────┴───────┴─────────┴─────────┘
=#
sort!(s_df,:Mean)
@pt s_df
#= 
┌─────────┬───────┬─────────┬─────────┐
│   Group │     n │    Mean │  Stddev │
│ String3 │ Int64 │ Float64 │ Float64 │
├─────────┼───────┼─────────┼─────────┤
│      LD │     8 │ 5.92625 │ 1.89942 │
│      DM │    10 │   7.859 │ 3.00929 │
│      LL │     9 │   11.01 │ 2.62399 │
└─────────┴───────┴─────────┴─────────┘
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
    p-value:                     0.0017

Details:
    number of observations: [9, 10, 8]
    F statistic:            8.39508
    degrees of freedom:     (2, 24)
=#

## 6. results
  """
  reject h_0 三种光照条件下, 小鼠的体重增加有显著性差异
  """