

include("$(pwd())/utils.jl")

using GLMakie,CSV,DataFrames,HypothesisTests
using DataFramesMeta,Pipe,ColorSchemes

desc=Lock5Table(652,"Honeybee","Is the Honeybee Population Shrinking?",["Year","Colonies"])

data=@pipe load_data(desc.name)|>select(_,desc.feature)
#plot_pair_cor(data)

CorrelationTest(eachcol(data)...)
#= 
    value under h_0:         0.0
    point estimate:          -0.409848
    95% confidence interval: (-0.7359, 0.07052)
    outcome with 95% confidence: fail to reject h_0
    two-sided p-value:           0.0912
 =#

 

