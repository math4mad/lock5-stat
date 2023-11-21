
"""
主客场罚球数是否有差异?
比较主客场罚球均值  
"""

include("$(pwd())/utils.jl")
include("data.jl")
using HypothesisTests,GLMakie,CSV,DataFrames,Distributions,Pipe

str="GSWarriors2019"
feature=["Location","FTA"]

gdf=@pipe load_data(str)|> select(_,feature)|>groupby(_,feature[1])

home=gdf[1][!,feature[2]]
away=gdf[2][!,feature[2]]

res=UnequalVarianceTTest(home,away)

#= 
    outcome with 95% confidence: fail to reject h_0
    two-sided p-value:           0.7763
=#