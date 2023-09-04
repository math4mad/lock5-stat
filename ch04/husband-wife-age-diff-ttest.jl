"""
question: 配偶中丈夫的年龄是否比妻子大?
可以采用两样本配对 t检验, 或者 df 中添加 :AgeDiff字段, 执行单个样本的 ttest
h_0:  diff = 0
h_a:  diii ≠ 0

"""

include("$(pwd())/utils.jl")
using HypothesisTests,GLMakie,CSV,DataFrames,Distributions
using StatsBase,DataFramesMeta,Pipe

desc=Lock5Table(331,"MarriageAges","Are Husbands Older Than Wives??",["Husband","Wife"])
data=@pipe load_data(desc.name)|>transform(_,desc.feature => ByRow(-) => :AgeDiff)

res=OneSampleTTest(data[!,:AgeDiff])

#= 
    One sample t-test
    -----------------
    Population details:
        parameter of interest:   Mean
        value under h_0:         0
        point estimate:          2.82857
        95% confidence interval: (1.862, 3.795)

    Test summary:
        outcome with 95% confidence: reject h_0
        two-sided p-value:           <1e-07

    Details:
        number of observations:   105
        t-statistic:              5.802524207370071
        degrees of freedom:       104
        empirical standard error: 0.48747257701720936
=#


