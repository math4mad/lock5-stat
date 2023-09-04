"""
page 487  Alkalinity ttest
data:FloridaLakes

"""


include("$(pwd())/utils.jl")

using CSV,DataFrames
using DataFramesMeta,StatsBase
using HypothesisTests


desc=Lock5Table(487,"FloridaLakes","the average alkalinity of all Florida lakes is greater than 35 mg/L?",["Alkalinity"])

μ₀=35.0

data=@pipe load_data(desc.name)|>select(_,desc.feature)|>Matrix|>_[:,1]
    
res=OneSampleTTest(data,μ₀) 

#= 
        One sample t-test
    -----------------
    Population details:
        parameter of interest:   Mean
        value under h_0:         35.0
        point estimate:          37.5302
        95% confidence interval: (27.0, 48.06)

    Test summary:
        outcome with 95% confidence: fail to reject h_0
        two-sided p-value:           0.6317

    Details:
        number of observations:   53
        t-statistic:              0.48215579018696153
        degrees of freedom:       52
        empirical standard error: 5.247657978480706
=#

