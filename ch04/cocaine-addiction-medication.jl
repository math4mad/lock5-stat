
"""
不同药物对可卡因戒断效果
locks5 stat page 375

"""

include("$(pwd())/utils.jl")
using HypothesisTests,GLMakie,CSV,DataFrames,ScientificTypes,PrettyTables
using Statistics

df=(let
c1=["Desipramine","Lithium","Placebo","Total"]
c2=[10,18,20];c3=[14,6,14]
df=freq_table(DataFrame(Relapse=c2,NoRelapse=c3);typename=c1)
df end)

@pt df
#=
┌─────────────┬─────────┬───────────┬───────┐
│        Type │ Relapse │ NoRelapse │ Total │
│      String │   Int64 │     Int64 │ Int64 │
├─────────────┼─────────┼───────────┼───────┤
│ Desipramine │      10 │        14 │    24 │
│     Lithium │      18 │         6 │    24 │
│     Placebo │      20 │        14 │    34 │
│       Total │      48 │        34 │    82 │
└─────────────┴─────────┴───────────┴───────┘
=#

#test 1  Lithum-Placebo  proprotion ttest 

test1=()->begin
      a,c,b,d=df[2,2],df[2,4],df[3,2],df[3,4]
      model1= FisherExactTest(a,b,c,d)
end
#test1()
#= 
  95% confidence interval: (0.5153, 3.145)
  two-sided p-value:           0.7119
  fail to reject h_0
=#


# test2  Desipramine-Placebo  proprotion ttest
test2=()-> begin a,c,b,d=df[1,2],df[1,4],df[3,2],df[3,4]
     res=FisherExactTest(a,b,c,d)
end
#= 
  p-value:0.6179
  95% confidence interval: (0.2497, 1.939)
  95% confidence: fail to reject h_0
=#