#= 
lock5stat page 557 
Gas, Charcoal, or Wood Pellets?
=#

include("../../utils.jl")

data=NamedArray([41;39;34],(["gas grilled","charcoal","wood pellets"]))
#= 
3-element Named Vector{Int64}
A            │ 
─────────────┼───
gas grilled  │ 41
charcoal     │ 39
wood pellets │ 34
=#

## chi test
observed=data[1:3]
expected=fill(1/3,3)
res=ChisqTest(observed,expected)

#= 
  Pearson's Chi-square Test
-------------------------
Population details:
    parameter of interest:   Multinomial Probabilities
    value under h_0:         [0.333333, 0.333333, 0.333333]
    point estimate:          [0.359649, 0.342105, 0.298246]
    95% confidence interval: [(0.2632, 0.4606), (0.2456, 0.4431), (0.2018, 0.3992)]

Test summary:
    outcome with 95% confidence: fail to reject h_0
    one-sided p-value:           0.7103

Details:
    Sample size:        114
    statistic:          0.6842105263157938
    degrees of freedom: 2
    residuals:          [0.486664, 0.162221, -0.648886]
    std. residuals:     [0.59604, 0.19868, -0.794719]
=#

## 4. chi test results 
"""
95% confidence interval: [(0.2632, 0.4606), (0.2456, 0.4431), (0.2018, 0.3992)]
outcome with 95% confidence: fail to reject h_0
    one-sided p-value:           0.7103
0.33 都位于置信区间内, p-value>0.05 
因此三种方法对顾客选择鸡肉没有影响
"""

