"""
FTA-FT  proportion  CI
BinomialTest(success, attempt)
BinomialTest(FT, FTA)
"""

include("$(pwd())/utils.jl")
include("data.jl")
using HypothesisTests,GLMakie,CSV,DataFrames,Distributions,Pipe
fta,ft=sum(data[!,:FTA]),sum(data[!,:FT])

fta_ft_rate=@pipe BinomialTest(ft,fta)|>confint(_;level=0.99)
#(0.774533079988662, 0.8254043179447903)


