## 1. load package
include("../../utils.jl")
  using GLMakie,CSV,DataFrames,Random,StatsBase,PrettyTables,Pipe,Bootstrap

##  2. load data
  #= 
    feature :["City", "Age", "Distance", "Time", "Sex"]
  =#
  desc=Lock5Table(270,"CommuteAtlanta","data3.1",["City", "Age", "Distance", "Time", "Sex"])
  df=@pipe load_csv(desc.name)|>select(_,desc.feature[4])

  
##  3. bootstrap workflow

    cil = 0.95;n_boot
    """
    bs(data::Vector)
    bootstraping 包装方法
    """
    bs(data::Vector) = bootstrap(mean,data, BasicSampling(n_boot))

## 3.1 bootstrap sampling
    bs1=bs(df.Time)
## 3.2 confidence
    bci1 = confint(bs1, BasicConfInt(cil))