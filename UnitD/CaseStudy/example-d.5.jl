## 1 load package
include("../../utils.jl")
import GLM: coef, predict,confint,ftest

## 2. load data
include("sleepstudy_data.jl")

gdf=@pipe select(data,["EarlyClass", "GPA"])|>groupby(_,:EarlyClass)
cats=cats= @pipe keys(gdf).|>values(_)[1]
group_data=[df.GPA for df in gdf]
summary_table=summary_df(cats,group_data)

#= 
┌───────┬───────┬─────────┬──────────┐
│ Group │     n │    Mean │   Stddev │
│ Int64 │ Int64 │ Float64 │  Float64 │
├───────┼───────┼─────────┼──────────┤
│     0 │    85 │ 3.19871 │ 0.420577 │
│     1 │   168 │ 3.26661 │ 0.395103 │
└───────┴───────┴─────────┴──────────┘
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
    p-value:                     0.1823

Details:
    number of observations: [85, 168]
    F statistic:            1.78841
    degrees of freedom:     (1, 251)
=#

