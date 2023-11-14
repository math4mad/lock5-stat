

include("../utils.jl")
using HypothesisTests,GLMakie,CSV,DataFrames
using Statistics,DataFramesMeta,Pipe




desc1=Lock5Table(351,"HeatCognition","DoesHeatAffectMathReactionTime?",["AC","MathZRT"])
desc2=Lock5Table(352,"HeatCognition","Does Heat Affect Color Dissonance Reaction Time??",["AC","ColorsZRT"])



make_ttest(desc1)
#= 
    Two sample t-test (equal variance)
    ----------------------------------
    Population details:
        parameter of interest:   Mean difference
        value under h_0:         0
        point estimate:          -0.102612
        95% confidence interval: (-0.3761, 0.1709)

    Test summary:
        outcome with 95% confidence: fail to reject h_0
        two-sided p-value:           0.4535

    Details:
        number of observations:   [20,26]
        t-statistic:              -0.7562261120844451
        degrees of freedom:       44
        empirical standard error: 0.1356899531038106
 =#


make_ttest(desc2)
#= 
    Two sample t-test (equal variance)
    ----------------------------------
    Population details:
        parameter of interest:   Mean difference
        value under h_0:         0
        point estimate:          -0.780326
        95% confidence interval: (-1.355, -0.2059)

    Test summary:
        outcome with 95% confidence: reject h_0
        two-sided p-value:           0.0089

    Details:
        number of observations:   [20,26]
        t-statistic:              -2.737618916010699
        degrees of freedom:       44
        empirical standard error: 0.28503833741803253 
=#
