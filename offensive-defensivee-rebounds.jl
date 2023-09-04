"""
page 158    Offensive Rebounds vs Defensive Rebounds
data: NBAPlayers2019
"""

#names(df)
include("utils.jl")

using GLMakie,CSV,DataFrames
using DataFramesMeta,StatBase

str="NBAPlayers2019"
@pipe load_data(str)|>select(_,["OffRebound","DefRebound"])|>plot_pair_cor(_,true)




