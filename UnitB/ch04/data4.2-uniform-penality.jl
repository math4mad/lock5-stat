## 1. load package
include("../../utils.jl")
using HypothesisTests,GLMakie,CSV,DataFrames




## 2. load data
desc=Lock5Table(307,"MalevolentUniformsNFL"," data4.2 Do Teams with Malevolent Uniforms Get More Penalties?",["NFLTeam", "NFL_Malevolence", "ZPenYds"])
df=@pipe load_csv(desc.name)|>select(_,desc.feature[2:3])
#@pt df
#= 
┌─────────────┬─────────────────┬─────────┐
│     NFLTeam │ NFL_Malevolence │ ZPenYds │
│    String15 │         Float64 │ Float64 │
├─────────────┼─────────────────┼─────────┤
│  LA Raiders │             5.1 │    1.19 │
│  Pittsburgh │             5.0 │    0.48 │
│  Cincinnati │            4.97 │    0.27 │
│ New Orleans │            4.83 │     0.1 │
│     Chicago │            4.68 │    0.29 │
└─────────────┴─────────────────┴─────────┘
=#

## 3.plot pair

#plot_pair_cor(df,true)  # ch04/imgs/data3.2-NFL_Malevolence_ZPenYds_cor.png

## 4. cor
   #cor(eachcol(df)...)  #0.4297


