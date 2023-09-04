"""
page 469
data: "NutritionStudy"
question :"the proportion taking a vitamin pill regularly is different from 35%?"
res:     95% confidence interval: (0.3332, 0.4435)
"""


include("$(pwd())/utils.jl")
#include("$(pwd())/myPkg.jl")
using HypothesisTests,GLMakie,CSV,DataFrames
using Statistics,Pipe
#using .myUtils



desc=Lock5Table(469,"NutritionStudy","the proportion taking a vitamin pill regularly is different from 35%?",["VitaminUse"])

df=@pipe load_data(desc.name)|>select(_,desc.feature)
vitaminuser=filter(row -> row[desc.feature[1]] =="Regular", df)
#cats=levels(df[!,desc.feature[1]])|>length
x,n=size(vitaminuser,1),size(df,1)

BinomialTest(x,n,0.35)

#= 
 parameter of interest:   Probability of success
    value under h_0:         0.35
    point estimate:          0.387302
    95% confidence interval: (0.3332, 0.4435)
    outcome with 95% confidence: fail to reject h_0
=#