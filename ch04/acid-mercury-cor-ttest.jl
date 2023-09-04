include("utils.jl")
using HypothesisTests,GLMakie,CSV,DataFrames,Distributions
using StatsBase,DataFramesMeta,Pipe


desc=Lock5Table(348,"FloridaLakes","Water pH vs mercury has negative relationship",["pH","AvgMercury"])

make_cor_ttest(desc)

#= 
    Test for nonzero correlation
    ----------------------------
    Population details:
        parameter of interest:   Correlation
        value under h_0:         0.0
        point estimate:          -0.5754
        95% confidence interval: (-0.7319, -0.3613)

    Test summary:
        outcome with 95% confidence: reject h_0
        two-sided p-value:           <1e-05

    Details:
        number of observations:          53
        number of conditional variables: 0
        t-statistic:                     -5.02423
        degrees of freedom:              51
=#


