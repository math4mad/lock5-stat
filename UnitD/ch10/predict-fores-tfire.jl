
include("utils.jl")
using HypothesisTests,CSV,DataFrames,Distributions,GLMakie,StatsBase
using GLM,Pipe

desc=Lock5Table(685,"ForestFires","predict  forest fire  area ",["Wind","Temp","RH","Rain","Area"])

data=@pipe load_data(desc.name)|>select(_,desc.feature)

fitmodel=lm(@formula(Area ~ Wind+Temp+RH+Rain), data)





