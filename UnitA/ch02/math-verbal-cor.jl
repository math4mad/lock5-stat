"""
page 155  2.226 SAT Scores: Math vs Verbal
data:StudentSurvey
"""

include("utils.jl")

using GLMakie,CSV,DataFrames
using DataFramesMeta,Pipe,ColorSchemes

str="StudentSurvey"
@pipe load_data(str)|>select(_,[:MathSAT,:VerbalSAT])|>plot_pair_cor(_,false)


