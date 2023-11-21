include("../../utils.jl")
  using GLMakie,CSV,DataFrames,Random,StatsBase,PrettyTables,Pipe,Bootstrap

##  2. load data
  #= 
    feature :["Sex", "Empathy"]
  =#
  desc=Lock5Table(281,"CompassionateRats","3.97 Rats with Compassion ",["Sex", "Empathy"])
  df=@pipe load_csv(desc.name)
  #@pt df
  #= 
  ┌─────────┬─────────┐
  │     Sex │ Empathy │
  │ String1 │ String3 │
  ├─────────┼─────────┤
  │       M │     yes │
  │       M │     yes │
  │       M │     yes │
  │       M │      no │
  │       M │      no │
  └─────────┴─────────┘
  =#

  ## transformation of df 
  transform!(df, :Empathy => ByRow(x->x=="yes" ? 1 : 0) => :Empathy)
  
  data=df.Empathy|>Vector
  cil = 0.95;n_boot=1000
  """
  bs(data::Vector)
  bootstraping 包装方法
  """
  bs(data::Vector) = bootstrap(sum,data, BasicSampling(n_boot))
  bs1=bs(data)



  