#= 
 lock5stat page 558
 Birth Date and Canadian Ice Hockey
=#

## 1. load package
include("../../utils.jl")
## 2. data
n=4
data=NamedArray([147 0.237;110 0.259;52 0.259;50 0.245],(["q1(Jan-Mar)","q2(Apr-Jun)","q3(Jul-Sep)","q4(Oct-Dec)"],["OHL players","% of Canadian births"]),("Birth Date","Stat"))

#= 
 4×2 Named Matrix{Float64}
Birth Date ╲ Stat │          OHL players  % of Canadian births
──────────────────┼───────────────────────────────────────────
q1(Jan-Mar)       │                147.0                 0.237
q2(Apr-Jun)       │                110.0                 0.259
q3(Jul-Sep)       │                 52.0                 0.259
q4(Oct-Dec)       │                 50.0                 0.245

=#

## 4. chi test
observed=data[:,1].|>Int
expected=fill(1/n,n)
res=ChisqTest(observed,expected)

#= 
  Pearson's Chi-square Test
-------------------------
Population details:
    parameter of interest:   Multinomial Probabilities
    value under h_0:         [0.25, 0.25, 0.25, 0.25]
    point estimate:          [0.409471, 0.306407, 0.144847, 0.139276]
    95% confidence interval: [(0.3565, 0.4659), (0.2535, 0.3628), (0.09192, 0.2012), (0.08635, 0.1957)]

Test summary:
    outcome with 95% confidence: reject h_0
    one-sided p-value:           <1e-15

Details:
    Sample size:        359
    statistic:          74.57103064066851
    degrees of freedom: 3
    residuals:          [6.04308, 2.13751, -3.98474, -4.19585]
    std. residuals:     [6.97795, 2.46818, -4.60118, -4.84495]
=#

## 4. resutls
"""
outcome with 95% confidence: reject h_0
    one-sided p-value:           <1e-15
各个季度出生的运动员比例显著不同
"""

