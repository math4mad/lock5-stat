## 1. load package
include("../../utils.jl")

## 2. load data
desc=Lock5Table(560,"PASeniors","popular superpower",["Superpower"])
df=@pipe load_csv(desc.name)|>select(_,desc.feature)
ft=freqtable(df,"Superpower")
n=5
#= 
  5-element Named Vector{Int64}
Superpower     │ 
───────────────┼───
Fly            │ 93
Freeze time    │ 94
Invisibility   │ 56
Super strength │ 16
Telepathy      │ 72
=#

## 3. chi test

expected=fill(1/n,n)
res=ChisqTest(ft,expected)
#= 
  Pearson's Chi-square Test
-------------------------
Population details:
    parameter of interest:   Multinomial Probabilities
    value under h_0:         [0.2, 0.2, 0.2, 0.2, 0.2]
    point estimate:          [0.280967, 0.283988, 0.169184, 0.0483384, 0.217523]
    95% confidence interval: [(0.2266, 0.3394), (0.2296, 0.3424), (0.1148, 0.2276), (0.0, 0.1068), (0.1631, 0.276)]

Test summary:
    outcome with 95% confidence: reject h_0
    one-sided p-value:           <1e-12

Details:
    Sample size:        331
    statistic:          62.67069486404832
    degrees of freedom: 4
    residuals:          [3.29387, 3.41677, -1.25364, -6.16985, 0.712851]
    std. residuals:     [3.68265, 3.82007, -1.40161, -6.8981, 0.796992]
=#

## 4. results
  """
  学生对希望拥有的超能力比例有差异
  """


