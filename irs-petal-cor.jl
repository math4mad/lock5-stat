"""
page 157  iris  petal feature cor
data:iris
"""

include("utils.jl")

using GLMakie,CSV,DataFrames
using DataFramesMeta,Pipe,ColorSchemes

str="iris"
@pipe load_data(str)|>select(_,[:petal_length,:petal_width])|>plot_pair_cor(_,true)