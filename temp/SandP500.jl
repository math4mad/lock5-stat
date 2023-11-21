"""
page 114

"""

include("utils.jl")
using HypothesisTests,GLMakie,CSV,DataFrames,ScientificTypes
using StatsBase,DataFramesMeta,Pipe

  df= (let str="SandP500"
      df=load_data(str)
  end)

  data=df[!,:Volume ]

  Dict(:nq4=>nquantile(data,4),:ran=>span(data),:iqr=>iqr(data))

