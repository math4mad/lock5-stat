include("utils.jl")
using HypothesisTests,GLMakie,CSV,DataFrames,ScientificTypes,PrettyTables
using Statistics

df=(let
c2=[372,807,34];c3=[363,1005,44]
typename=["Agree","Disagree","Don't know","Total"]
df=freq_table(DataFrame(Male=c2,Female=c3);typename=typename)
df end)

h1 = Highlighter(f= (data, i, j) -> i==4,crayon = crayon"red bold" )
h2 = Highlighter(f= (data, i, j) -> j==4,crayon = crayon"blue bold" )

pretty_table(df, highlighters =(h1,h2))
#= 
    lock5stat page80 table2.4
    ┌────────────┬───────┬────────┬───────┐
    │       Type │  Male │ Female │ Total │
    │     String │ Int64 │  Int64 │ Int64 │
    ├────────────┼───────┼────────┼───────┤
    │      Agree │   372 │    363 │   735 │
    │   Disagree │   807 │   1005 │  1812 │
    │ Don't know │    34 │     44 │    78 │
    │      Total │  1213 │   1412 │  2625 │
    └────────────┴───────┴────────┴───────┘
=#