"""
page 490  pH ttest
data:FloridaLakes

"""


include("$(pwd())/utils.jl")

using CSV,DataFrames
using DataFramesMeta,StatsBase
using HypothesisTests


desc=Lock5Table(490,"FloridaLakes","Are Florida Lakes Acidic or Alkaline?",["pH"])

μ₀=7.0

data=@pipe load_data(desc.name)|>select(_,desc.feature)|>Matrix|>_[:,1]
    
res=OneSampleTTest(data,μ₀) 


#= 
    One sample t-test
    -----------------
    Population details:
        parameter of interest:   Mean
        value under h_0:         7.0
        point estimate:          6.59057
        95% confidence interval: (6.235, 6.946)

    Test summary:
        outcome with 95% confidence: reject h_0
        two-sided p-value:           0.0247

    Details:
        number of observations:   53
        t-statistic:              -2.3134198913532305
        degrees of freedom:       52
        empirical standard error: 0.1769821223524862
=#

