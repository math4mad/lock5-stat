"""
locks5 stat page 100
ICUAdmissions

ID=772 的患者 血压比均值高2.18 个标准差, 非常罕见
             心率比均值低了-1.75 标准差, 落在 95%区间内

"""

include("utils.jl")
using HypothesisTests,GLMakie,CSV,DataFrames,ScientificTypes
using StatsBase,DataFramesMeta,Pipe

  df= (let str="ICUAdmissions"
      df=load_data(str)
  end)

  data_bp=df[!,:Systolic]
  data_hr=df[!,:HeartRate]
  patient772_bp=@pipe df|>filter(:ID => ==(772), _)|>select(_,:Systolic)|>Array|>d->d[1,1]|>Float64
  patient772_hr=@pipe df|>filter(:ID => ==(772), _)|>select(_,:HeartRate)|>Array|>d->d[1,1]|>Float64

  μ1, σ1 = mean_and_std(data_bp)
  μ2, σ2 = mean_and_std(data_hr)
  patient772_bp_zscore=zscore([patient772_bp], μ1, σ1).|>d->round(d,digits=2)   #2.18
  patient772_hr_zscore=zscore([patient772_hr], μ2, σ2).|>d->round(d,digits=2)   #-1.75

  