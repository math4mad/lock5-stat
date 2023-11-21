## 1. load package
include("../../utils.jl")
using HypothesisTests,GLMakie,CSV,DataFrames




## 2. load data
desc=Lock5Table(305,"LightatNight"," data4.1 Does Light at Night Affect Weight Gain?",["Group","BMGain"])
df=@pipe load_csv(desc.name)
gdf=groupby(df,:Group)