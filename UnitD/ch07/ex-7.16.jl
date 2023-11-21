#= 
lock5stat page 557 
rock-paper-scissors game  freq
=#


include("../../utils.jl")

data=NamedArray([66;39;14;119],(["Rock","Paper","Scissors","Total"]))
#= 
4-element Named Vector{Int64}
A        │ 
─────────┼────
Rock     │  66
Paper    │  39
Scissors │  14
Total    │ 119
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
    point estimate:          [0.554622, 0.327731, 0.117647]
    95% confidence interval: [(0.4706, 0.6522), (0.2437, 0.4254), (0.03361, 0.2153)]

Test summary:
    outcome with 95% confidence: reject h_0
    one-sided p-value:           <1e-07

Details:
    Sample size:        119
    statistic:          34.10084033613447
    degrees of freedom: 2
    residuals:          [4.18112, -0.105851, -4.07527]
    std. residuals:     [5.12081, -0.129641, -4.99117]
=#

## 4. results
"""
point estimate:          [0.554622, 0.327731, 0.117647]
95% confidence interval: [(0.4706, 0.6522), (0.2437, 0.4254), (0.03361, 0.2153)]
reject h_0
三种手势的比例不相同
"""

