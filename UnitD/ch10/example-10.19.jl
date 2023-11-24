"""
chapter:10
page 687  predict  final exame score
data:StatGrades

"""


## 1. load package
include("../../utils.jl")

## 2. load data
include("data-10.3.jl")

## 3 linear reg 

@info model=lm(@formula(Final~Exam1+Exam2), data)
## f-test
@info ftest(model.model)
#= 
┌Info: 
│ StatsModels.TableRegressionModel{LinearModel{GLM.LmResp{Vector{Float64}}, GLM.DensePredChol{Float64, CholeskyPivoted{Float64, Matrix{Float64}, Vector{Int64}}}}, Matrix{Float64}}
│ 
│ Final ~ 1 + Exam1 + Exam2
│ 
│ Coefficients:
│ ────────────────────────────────────────────────────────────────────────
│                  Coef.  Std. Error     t  Pr(>|t|)  Lower 95%  Upper 95%
│ ────────────────────────────────────────────────────────────────────────
│ (Intercept)  30.8952      7.99732   3.86    0.0003  14.8067    46.9837
│ Exam1         0.446819    0.160555  2.78    0.0077   0.123825   0.769813
│ Exam2         0.221194    0.176017  1.26    0.2151  -0.132907   0.575295
└ ────────────────────────────────────────────────────────────────────────
┌ Info: 
│ F-test against the null model:
└ F-statistic: 25.98 on 50 observations and 2 degrees of freedom, p-value: <1e-07
=#


