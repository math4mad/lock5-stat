

include("$(pwd())/utils.jl")

using GLMakie,CSV,DataFrames,HypothesisTests
using DataFramesMeta,Pipe,ColorSchemes

desc=Lock5Table(653,"SampCountries","spent on health care predict life expectancy?",["Health","LifeExpectancy"])

data=@pipe load_data(desc.name)|>select(_,desc.feature)
#plot_pair_cor(data)

CorrelationTest(eachcol(data)...)
#= 
    point estimate:          0.704277
    95% confidence interval: (0.402, 0.8681)
    outcome with 95% confidence: reject h_0
    two-sided p-value:           0.0003
=#

 

