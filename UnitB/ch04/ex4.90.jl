## 1. load packge
include("../../utils.jl")
using HypothesisTests,GLMakie,CSV,DataFrames,Distributions
using StatsBase,DataFramesMeta,Pipe

## 2. load pcakge
desc=Lock5Table(336,"ProcessedFoods","ARE ULTRA-PROCESSED FOODS MAKING US FAT??",["Taps","Group"])
df=@pipe load_data(desc.name)
@pt  df[:,12:end]


## 3. test