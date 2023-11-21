"""
page 158    Do Movies with Larger Budgets Get Higher Audience Ratings?
data: HollywoodMovies
"""

#names(df)
include("utils.jl")

using GLMakie,CSV,DataFrames
using DataFramesMeta,StatsBase

str="HollywoodMovies"
data::AbstractDataFrame=@pipe load_data(str)|>select(_,["Budget","AudienceScore"])

#plot_pair_cor(data,true)

pair_corletation(data)
 