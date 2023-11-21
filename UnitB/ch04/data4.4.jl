## 1. load package
include("../../utils.jl")
using HypothesisTests,GLMakie,CSV,DataFrames




## 2. load data
desc=Lock5Table(325,"MalevolentUniformsNFL"," data4.2 Do Teams with Malevolent Uniforms Get More Penalties?",["NFLTeam", "NFL_Malevolence", "ZPenYds"])
df=@pipe load_csv(desc.name)|>select(_,desc.feature[2:3])
#@pt df