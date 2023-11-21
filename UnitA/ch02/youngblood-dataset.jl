"""
年轻生物的血浆是对衰老的大脑是否有帮助?
lock5 stat page 107

YoungBlood
"""


include("utils.jl")
using HypothesisTests,GLMakie,CSV,DataFrames,ScientificTypes
using Statistics,DataFramesMeta,Pipe

  df= (let str="YoungBlood"
      df=load_data(str)
  end)

  ages=levels(df[!,:Plasma])

  treadmill_of(year,method=mean)=@pipe df|>filter(:Plasma => ==(year), _) |> select(_,[:Runtime])|>Array|>method|>round(_,digits=2)
  res=["$i-treadmill-$(j)"=>treadmill_of(i,j) for i in ages for j in [mean,median]]