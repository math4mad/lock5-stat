## 1. load package
include("../../utils.jl")

## 2. load data
desc=Lock5Table(621,"InkjetPrinters","predict laserjet printer price",[:PPM,:CostBW])
data= @pipe load_csv(desc.name)|>select(_,desc.feature)

cor(eachcol(data)...)  # -0.636
model=CorrelationTest(eachcol(data)...)
#= 
Test for nonzero correlation
----------------------------
Population details:
    parameter of interest:   Correlation
    value under h_0:         0.0
    point estimate:          -0.636096
    95% confidence interval: (-0.8417, -0.2694)

Test summary:
    outcome with 95% confidence: reject h_0
    two-sided p-value:           0.0026

Details:
    number of observations:          20
    number of conditional variables: 0
    t-statistic:                     -3.49753
    degrees of freedom:              18
=#

## results
"""
two-sided p-value:           0.0026
因此有充分证据拒绝相关系数为0的假设
"""

confint(model)  #  CI:(-0.8416923532873507, -0.2694102208840082)





