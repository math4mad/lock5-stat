## 1. load package
include("../../utils.jl")

## 2. load data
desc=Lock5Table(560,"PASeniors","Preference",["Preference"])
df=@pipe load_csv(desc.name)|>select(_,desc.feature)
ft=freqtable(df,desc.feature[1])
n=4
#= 
 4-element Named Vector{Int64}
Preference  │ 
────────────┼────
Famous      │  15
Happy       │ 224
Healthy     │  34
Rich        │  58
=#

expected=fill(1/n,n)
res=ChisqTest(ft,expected)
#= 
 Pearson's Chi-square Test
-------------------------
Population details:
    parameter of interest:   Multinomial Probabilities
    value under h_0:         [0.25, 0.25, 0.25, 0.25]
    point estimate:          [0.0453172, 0.676737, 0.102719, 0.175227]
    95% confidence interval: [(0.0, 0.09558), (0.6284, 0.727), (0.05438, 0.153), (0.1269, 0.2255)]

Test summary:
    outcome with 95% confidence: reject h_0
    one-sided p-value:           <1e-71

Details:
    Sample size:        331
    statistic:          332.69788519637467
    degrees of freedom: 3
    residuals:          [-7.44775, 15.5276, -5.35908, -2.72077]
    std. residuals:     [-8.59993, 17.9297, -6.18814, -3.14167]
=#

## 4. results
"""
学生在不同期望上的比例有显著差异
"""


