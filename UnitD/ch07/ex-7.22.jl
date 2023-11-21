#= 
 lock5stat page 558
 Birthdate and Australian Football 
=#

## 1. load package
include("../../utils.jl")
## 2. data
n=4
data=NamedArray([196 0.248;162 0.251;137 0.254;122 0.247],(["q1(Jan-Mar)","q2(Apr-Jun)","q3(Jul-Sep)","q4(Oct-Dec)"],["Actual for AFL Players","Proportion Nationally"]),("Birth Date","Stat"))

#= 
 4×2 Named Matrix{Float64}
Birth Date ╲ Stat │ Actual for AFL Players   Proportion Nationally
──────────────────┼───────────────────────────────────────────────
q1(Jan-Mar)       │                  196.0                   0.248
q2(Apr-Jun)       │                  162.0                   0.251
q3(Jul-Sep)       │                  137.0                   0.254
q4(Oct-Dec)       │                  122.0                   0.247
=#


## chi test
observed=data[:,1].|>Int
expected=fill(1/n,n)
res=ChisqTest(observed,expected)

#= 
  Pearson's Chi-square Test
-------------------------
Population details:
    parameter of interest:   Multinomial Probabilities
    value under h_0:         [0.25, 0.25, 0.25, 0.25]
    point estimate:          [0.317666, 0.262561, 0.222042, 0.197731]
    95% confidence interval: [(0.2729, 0.3661), (0.2208, 0.309), (0.1831, 0.2665), (0.1608, 0.2407)]

Test summary:
    outcome with 95% confidence: reject h_0
    one-sided p-value:           0.0001

Details:
    Sample size:        617
    statistic:          20.361426256077756
    degrees of freedom: 3
    residuals:          [3.36158, 0.624007, -1.38892, -2.59667]
    std. residuals:     [3.88162, 0.720541, -1.60378, -2.99838]
=#

## 4 results
"""
在一年中不同时间段出生的人成为运动员的比例显著不同
"""


