include("../../utils.jl")
using HypothesisTests,GLMakie,CSV,DataFrames,Distributions
using StatsBase,DataFramesMeta,Pipe

## 2. load data

desc=Lock5Table(395,"RestaurantTips","",["Bill", "Tip", "Credit", "Guests", "Day", "Server", "PctTip"])
data=@pipe load_data(desc.name)

#= 
┌─────────┬─────────┬─────────┬────────┬─────────┬─────────┬─────────┐
│    Bill │     Tip │  Credit │ Guests │     Day │  Server │  PctTip │
│ Float64 │ Float64 │ String1 │  Int64 │ String3 │ String1 │ Float64 │
├─────────┼─────────┼─────────┼────────┼─────────┼─────────┼─────────┤
│    23.7 │    10.0 │       n │      2 │       f │       A │    42.2 │
│   36.11 │     7.0 │       n │      3 │       f │       B │    19.4 │
│   31.99 │    5.01 │       y │      2 │       f │       A │    15.7 │
│   17.39 │    3.61 │       y │      2 │       f │       B │    20.8 │
│   15.41 │     3.0 │       n │      2 │       f │       B │    19.5 │
│   18.62 │     2.5 │       n │      2 │       f │       A │    13.4 │
│    ⋮    │    ⋮    │    ⋮    │   ⋮    │    ⋮    │    ⋮    │    ⋮    │
└─────────┴─────────┴─────────┴────────┴─────────┴─────────┴─────────┘
=#