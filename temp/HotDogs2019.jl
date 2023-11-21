"""
page 121
HotDogs2019
"""

include("utils.jl")
using HypothesisTests,GLMakie,CSV,DataFrames,ScientificTypes
using StatsBase,DataFramesMeta,Pipe

  df= (let str="HotDogs2019"
      df=load_data(str)
  end)

  data=df[!,:HotDogs]
  μ,σ=mean_and_std(data)
  
