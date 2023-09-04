"""
Doing Bayesian Data Analysis.pdf  page 103
"""

include("utils.jl")
using DataFrames, DataFramesMeta,PrettyTables


EyeColor=["Brown","Blue","Hazel","Green","Marginal (hair color)"]
h1=[0.11,0.03,0.03,0.01]
h2=[0.20,0.14,0.09,0.05]
h3=[0.04,0.03,0.02,0.03]
h4=[0.01,0.16,0.02,0.03]

df=DataFrame(Black=h1,Brunette=h2,Red=h3,Blond=h4)

ft=freq_table(df;typename=EyeColor)
rename!(ft,:Total=>"Marginal (Eye color)")

h1 = Highlighter(f= (data, i, j) -> i==5,crayon = crayon"red bold" )
h2 = Highlighter(f= (data, i, j) -> j==6,crayon = crayon"blue bold" )
formatter = (v, i, j) -> j>1&&round(v, digits = 2);
#pretty_table(ft, highlighters =(h1,h2), formatters = formatter)
pretty_table(ft, highlighters =(h1,h2), formatters = ft_round(2))

"""
┌───────────────────────┬─────────┬──────────┬─────────┬─────────┬──────────────────────┐
│                  Type │   Black │ Brunette │     Red │   Blond │ Marginal (Eye color) │
│                String │ Float64 │  Float64 │ Float64 │ Float64 │              Float64 │
├───────────────────────┼─────────┼──────────┼─────────┼─────────┼──────────────────────┤
│                 Brown │    0.11 │      0.2 │    0.04 │    0.01 │                 0.36 │
│                  Blue │    0.03 │     0.14 │    0.03 │    0.16 │                 0.36 │
│                 Hazel │    0.03 │     0.09 │    0.02 │    0.02 │                 0.16 │
│                 Green │    0.01 │     0.05 │    0.03 │    0.03 │                 0.12 │
│ Marginal (hair color) │    0.18 │     0.48 │    0.12 │    0.22 │                  1.0 │
└───────────────────────┴─────────┴──────────┴─────────┴─────────┴──────────────────────┘
"""

