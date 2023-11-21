"""
question: 配偶中丈夫的年龄是否比妻子大?
可以采用两样本配对 t检验, 或者 df 中添加 :AgeDiff字段, 执行单个样本的 ttest
h_0:  diff = 0
h_a:  diii ≠ 0

"""

include("../../utils.jl")
using HypothesisTests,GLMakie,CSV,DataFrames,Distributions
using StatsBase,DataFramesMeta,Pipe

desc=Lock5Table(342,"Smiles","Can a simple smile have an effect on punishment assigned following an infraction??",["Leniency","Group"])
gdf=@pipe load_data(desc.name)|>groupby(_,desc.feature[2])
#sample1=
#res=EqualVarianceTTest(gdf[1][!,1],gdf[2][!,1])

#= 
    Two sample t-test (equal variance)
    ----------------------------------
    Population details:
        parameter of interest:   Mean difference
        value under h_0:         0
        point estimate:          0.794118
        95% confidence interval: (0.01749, 1.571)

    Test summary:
        outcome with 95% confidence: reject h_0
        two-sided p-value:           0.0452

    Details:
        number of observations:   [34,34]
        t-statistic:              2.04153849287233
        degrees of freedom:       66
        empirical standard error: 0.38898000200894833
=#
