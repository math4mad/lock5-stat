

## 1. load package
include("../../utils.jl")

## 2. load data
desc = Lock5Table(710, "SleepStudy", "Sleep Study with College Students", ["CognitionZscore","GPA"])
data= @pipe load_csv(desc.name)|>select(_,desc.feature)

## 3. cor test

CorrelationTest(eachcol(data)...)

#= 
Test for nonzero correlation
----------------------------
Population details:
    parameter of interest:   Correlation
    value under h_0:         0.0
    point estimate:          0.266822
    95% confidence interval: (0.1484, 0.3777)

Test summary:
    outcome with 95% confidence: reject h_0
    two-sided p-value:           <1e-04

Details:
    number of observations:          253
    number of conditional variables: 0
    t-statistic:                     4.38628
    degrees of freedom:              251
=#

## 4. results
#= 
  p-value 远小于 0 
  因此有充分证据显示 认知得分和 GPA 相关系数不为 0
=#


