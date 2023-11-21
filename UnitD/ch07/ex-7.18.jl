#= 
  lock5stat page  557
  What Is Your Sleep Position?
=#


## 1. load package
include("../../utils.jl")

## 2. data
data=NamedArray([391;257;156;89;107],(["Fetal","Side,legs straight","Back","Stomach","None"]))
n=5
#= 
5-element Named Vector{Int64}
A                  │ 
───────────────────┼────
Fetal              │ 391
Side,legs straight │ 257
Back               │ 156
Stomach            │  89
None               │ 107

=#

## 3. chi- test
observed=data[1:n]
expected=fill(1/n,n)
res=ChisqTest(observed,expected)

#= 
 Pearson's Chi-square Test
-------------------------
Population details:
    parameter of interest:   Multinomial Probabilities
    value under h_0:         [0.2, 0.2, 0.2, 0.2, 0.2]
    point estimate:          [0.391, 0.257, 0.156, 0.089, 0.107]
    95% confidence interval: [(0.3521, 0.4313), (0.2231, 0.2941), (0.1287, 0.1878), (0.06843, 0.115), (0.08436, 0.1348)]

Test summary:
    outcome with 95% confidence: reject h_0
    one-sided p-value:           <1e-65

Details:
    Sample size:        1000
    statistic:          313.18
    degrees of freedom: 4
    residuals:          [13.5057, 4.03051, -3.11127, -7.84889, -6.57609]
    std. residuals:     [15.0999, 4.50625, -3.47851, -8.77532, -7.3523]
=#

## 4. results
"""
with 95% confidence: reject h_0
"""


