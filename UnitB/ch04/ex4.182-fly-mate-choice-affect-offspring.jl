"""
果蝇对交配对象的选择是否影响到后代的存活力?

"""


"""
locks5 page369
"""

## 1. load pacakge

include("../../utils.jl")
using HypothesisTests,GLMakie,CSV,DataFrames,Distributions
using StatsBase,DataFramesMeta,Pipe


## 2. load data

    desc=Lock5Table(369,"MateChoice","果蝇对交配对象的选择是否影响到后代的存活力?",["Choice","NoChoice","Difference"])
    data=@pipe load_data(desc.name)|>select(_,desc.feature[3])



## 3. fisherExactTest
#qa
a,c,b,d=6067,10000,5967,10000
#m1=FisherExactTest(a,b,c,d)  
#=
 95% confidence interval: (0.9715, 1.064)
 fail to reject h_0,p-value:0.4785
=#

# 检测两组差值是否属于均值为0的正态分布数据
#OneSampleTTest(data[!,3])   #p-value=0.41,fail to reject h_0

## 4. onesampletest  检测两种组别的重复试验的差值是否与μ=0有差异

OneSampleTTest(data.Difference, 0)

#= 
  One sample t-test
-----------------
Population details:
    parameter of interest:   Mean
    value under h_0:         0
    point estimate:          1.82
    95% confidence interval: (-2.676, 6.316)

Test summary:
    outcome with 95% confidence: fail to reject h_0
    two-sided p-value:           0.4198

Details:
    number of observations:   50
    t-statistic:              0.8135509454186975
    degrees of freedom:       49
    empirical standard error: 2.237106367153601
=#