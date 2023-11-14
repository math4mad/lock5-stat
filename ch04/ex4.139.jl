#= 
  p353, ex4.139
=#


## 1. load  package
include("../utils.jl")
import StatsBase:sample
using HypothesisTests,GLMakie,CSV,DataFrames
using StatsBase,Random
Random.seed!(3434)

data=[0.6,4.7,3.8, 0.4, 1.5, -1.2, 2.8 ,-0.4,1.4, 3.5 -2.8]
bs_sample=sample(data,1000)
