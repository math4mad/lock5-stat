"""
question: 喝咖啡是否影响手指抽动?
可以采用两样本配对 t检验
h_0:  diff = 0
h_a:  diii ≠ 0


res    p-value:           0.0032
p-value<0.05因此拒绝 0 假设, 认为喝咖啡对手指抽动有影响
"""

## 1. load packge
    include("../utils.jl")
    using HypothesisTests,GLMakie,CSV,DataFrames,Distributions
    using StatsBase,DataFramesMeta,Pipe

## 2. load pcakge
    desc=Lock5Table(331,"CaffeineTaps","Finger Tapping and Caffeine?",["Taps","Group"])
    gdf=@pipe load_data(desc.name)|>groupby(_,desc.feature[2])


## 3. test
    res=EqualVarianceTTest(gdf[1][!,1],gdf[2][!,1])

#= 
    Two sample t-test (equal variance)
    ----------------------------------
    Population details:
        parameter of interest:   Mean difference
        value under h_0:         0
        point estimate:          3.5
        95% confidence interval: (1.334, 5.666)

    Test summary:
        outcome with 95% confidence: reject h_0
        two-sided p-value:           0.0032

    Details:
        number of observations:   [10,10]
        t-statistic:              3.394167965134989
        degrees of freedom:       18
        empirical standard error: 1.0311805532172011
=#