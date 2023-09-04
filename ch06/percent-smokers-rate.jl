"""
page 469
data: "NutritionStudy"
question :"the proportion of smokers is different from 20%?
res:  95% confidence interval: (0.1006, 0.1794)
"""


include("$(pwd())/utils.jl")
using HypothesisTests,GLMakie,CSV,DataFrames
using Statistics,Pipe



desc=Lock5Table(469,"NutritionStudy","Is B a Good Choice on a Multiple-Choice Exam?",["Smoke"])

df=@pipe load_data(desc.name)|>select(_,desc.feature)
smokers=filter(row -> row.Smoke =="Yes", df)
cats=levels(df[!,"Smoke"])|>length
x,n=size(smokers,1),size(df,1)

BinomialTest(x,n,0.2)

#= 
        Binomial test
    -------------
    Population details:
        parameter of interest:   Probability of success
        value under h_0:         0.2
        point estimate:          0.136508
        95% confidence interval: (0.1006, 0.1794)

    Test summary:
        outcome with 95% confidence: reject h_0
        two-sided p-value:           0.0043

    Details:
        number of observations: 315
        number of successes:    43
=#