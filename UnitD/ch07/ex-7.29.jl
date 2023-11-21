## 1. load package
include("../../utils.jl")

## 2. load data
desc=Lock5Table(560,"PASeniors","popular superpower",["Season"])
df=@pipe load_csv(desc.name)|>select(_,desc.feature)
ft=freqtable(df,"Season")
n=4
#= 
4-element Named Vector{Int64}
Season  │ 
────────┼────
Fall    │ 123
Spring  │  54
Summer  │ 109
Winter  │  45
=#

## 3. chi test

expected=fill(1/n,n)
res=ChisqTest(ft,expected)

#= 
 Pearson's Chi-square Test
-------------------------
Population details:
    parameter of interest:   Multinomial Probabilities
    value under h_0:         [0.25, 0.25, 0.25, 0.25]
    point estimate:          [0.371601, 0.163142, 0.329305, 0.135952]
    95% confidence interval: [(0.3172, 0.4313), (0.1088, 0.2229), (0.2749, 0.3891), (0.08157, 0.1957)]

Test summary:
    outcome with 95% confidence: reject h_0
    one-sided p-value:           <1e-11

Details:
    Sample size:        331
    statistic:          55.11480362537763
    degrees of freedom: 3
    residuals:          [4.42468, -3.16049, 2.88566, -4.14986]
    std. residuals:     [5.10918, -3.64941, 3.33207, -4.79184]
=#

## 4 results
"""
学生对季节的喜好比例有显著差异
"""


