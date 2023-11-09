include("../utils.jl")
  using GLMakie,CSV,DataFrames,Random,StatsBase,PrettyTables,Pipe,Bootstrap

##  2. load data
  #= 
    feature :["InterferonGamma", "Drink"]
  =#
  desc=Lock5Table(282,"ImmuneTea","3.100 Tea, Coffee, and Your Immune System",["InterferonGamma", "Drink"])
  df=@pipe load_csv(desc.name)
  gdf=groupby(df,:Drink)

  tea=gdf[1].InterferonGamma
  coffee=gdf[2].InterferonGamma


  