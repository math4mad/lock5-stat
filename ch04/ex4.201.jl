

## 1. load  package
include("../utils.jl")
import StatsBase:sample
using HypothesisTests,GLMakie,CSV,DataFrames
using StatsBase,Random
Random.seed!(3434)

##  2. load data
desc=Lock5Table(388,"MammalLongevity","HowLongAreMammalsPregnant?",["Animal", "Gestation", "Longevity"])
data=@pipe  load_csv(desc.name)|>select(_,desc.feature[2])

## 3. one sample ttest

res=OneSampleTTest(data.Gestation,200)

#= 
 Population details:
    parameter of interest:   Mean
    value under h_0:         200
    point estimate:          194.325
    95% confidence interval: (148.5, 240.2)

Test summary:
    outcome with 95% confidence: fail to reject h_0
    two-sided p-value:           0.8037

Details:
    number of observations:   40
    t-statistic:              -0.2503130862243631
    degrees of freedom:       39
    empirical standard error: 22.67160732824547
=#

## 4. anserver question 
   ## fail to refuce μ₀
   ##  200 in confidence region
