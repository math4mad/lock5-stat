## 1. load package
include("../../utils.jl")

## 2. load data
desc = Lock5Table(710, "SleepStudy", "Sleep Study with College Students", ["AverageSleep","Happiness"])
data= @pipe load_csv(desc.name)|>select(_,desc.feature)


## 3. cor test

CorrelationTest(eachcol(data)...)
#= 
Test for nonzero correlation
----------------------------
Population details:
    parameter of interest:   Correlation
    value under h_0:         0.0
    point estimate:          0.103874
    95% confidence interval: (-0.01971, 0.2243)

Test summary:
    outcome with 95% confidence: fail to reject h_0
    two-sided p-value:           0.0993

Details:
    number of observations:          253
    number of conditional variables: 0
    t-statistic:                     1.65462
    degrees of freedom:              251
=#

## 4. results
#= 
  p-value >0.05 
  因此不能决绝 0假设, 两者相关系数为 0
=#