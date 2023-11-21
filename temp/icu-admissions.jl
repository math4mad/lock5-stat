"""
locks5 stat page 100
ICUAdmissions

@pipe  是Pipe.jl 的方法, 简单使用参考 DataFrames cheatsheet.pdf
https://ahsmart.com/assets/pages/data-wrangling-with-data-frames-jl-cheat-sheet/DataFramesCheatSheet_v1.x_rev1_zh.pdf


"""

include("utils.jl")
using HypothesisTests,GLMakie,CSV,DataFrames,ScientificTypes
using Statistics,DataFramesMeta,Pipe

  df= (let str="ICUAdmissions"
      df=load_data(str)
  end)

  #describe(df)
  
  heartrate_of(year,method=mean)=@pipe df|>filter(:Age => ==(year), _) |> select(_,[:HeartRate ])|>Array|>method|>round(_,digits=2)

res=["$i-year-$(j)"=>heartrate_of(i,j) for i in [20,55] for j in [mean,median]]
"""
    "20-year-mean" => 82.2
    "20-year-median" => 80.0
    "55-year-mean" => 108.5
    "55-year-median" => 106.0
"""