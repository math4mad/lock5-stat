"""
    outcome with 95% confidence: reject h_0
    two-sided p-value:           0.0026
    健康饮食对改善抑郁水平有作用
"""

## 1. load packge
include("../../utils.jl")
using HypothesisTests,GLMakie,CSV,DataFrames,Distributions
using StatsBase,DataFramesMeta,Pipe

## 2. load pcakge
#= 
  ["Group", "CESD1", "CESD21", "CESDDiff", "DASS1", "DASS21", "DASSDiff", "BMI1", "BMI21", "BMIDiff"]
=#
desc=Lock5Table(350,"DietDepression","Can a Brief Diet Intervention Help Depres- sion??",["Group","DASSDiff"])
df=@pipe load_data(desc.name)|>select(_,desc.feature)
gdf=groupby(df,:Group)

## 3. test
diet_Group=gdf[1].DASSDiff
control_Group=gdf[2].DASSDiff
res=EqualVarianceTTest(diet_Group,control_Group)

#= 
Two sample t-test (equal variance)
----------------------------------
Population details:
    parameter of interest:   Mean difference
    value under h_0:         0
    point estimate:          7.10171
    95% confidence interval: (2.56, 11.64)

Test summary:
    outcome with 95% confidence: reject h_0
    two-sided p-value:           0.0026

Details:
    number of observations:   [37,38]
    t-statistic:              3.1162849369003123
    degrees of freedom:       73
    empirical standard error: 2.278901677454407
=#