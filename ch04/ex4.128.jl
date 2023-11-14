#= 
 outcome with 95% confidence: fail to reject h_0
    two-sided p-value:           0.5357
 结论:  饮食干预对 BMI 因数没有影响
=#

## 1. load packge
include("../utils.jl")
using HypothesisTests,GLMakie,CSV,DataFrames,Distributions
using StatsBase,DataFramesMeta,Pipe

## 2. load pcakge
#= 
  ["Group", "CESD1", "CESD21", "CESDDiff", "DASS1", "DASS21", "DASSDiff", "BMI1", "BMI21", "BMIDiff"]
=#
desc=Lock5Table(350,"DietDepression","Can a Brief Diet Intervention Change BMI?",["Group","BMIDiff"])
df=@pipe load_data(desc.name)|>select(_,desc.feature)
gdf=groupby(df,:Group)

## 3. test
diet_Group=gdf[1].BMIDiff
control_Group=gdf[2].BMIDiff
res=EqualVarianceTTest(diet_Group,control_Group)

#= 
Two sample t-test (equal variance)
----------------------------------
Population details:
    parameter of interest:   Mean difference
    value under h_0:         0
    point estimate:          0.157255
    95% confidence interval: (-0.3464, 0.6609)

Test summary:
    outcome with 95% confidence: fail to reject h_0
    two-sided p-value:           0.5357

Details:
    number of observations:   [37,38]
    t-statistic:              0.622311612484278
    degrees of freedom:       73
    empirical standard error: 0.25269434137077035
=#