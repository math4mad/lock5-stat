"""
使用 CorrelationTest(x, y) 检验两个变量的相关性
"""

include("$(pwd())/utils.jl")
using HypothesisTests,GLMakie,CSV,DataFrames,Distributions,RCall,GLMakie,LinearAlgebra
using GLM,Pipe

desc=Lock5Table(643,"InkjetPrinters","PPM and  BW  correlation?",["PPM","CostBW"])

data=@pipe load_data(desc.name)|>select(_,desc.feature)

CorrelationTest(data[!,desc.feature[1]], data[!,desc.feature[2]])

#= 
  t-statistic:-3.49753
  point estimate:          -0.636096
  95% confidence interval: (-0.8417, -0.2694)

=#