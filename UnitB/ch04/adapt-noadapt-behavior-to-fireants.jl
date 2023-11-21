"""
fire ant 分泌的毒液能够杀死蜥蜴,
科学家想知道蜥蜴对 fire ant 是否有适应性的行为

检测观察入侵地的蜥蜴和未入侵低蜥蜴身体接触到fire ant 的反应,
如果有适应性行为, 入侵地的蜥蜴身体抽搐更厉害以摆脱火蚂蚁

"Twitches"  度量了身体抽搐的程度

point estimate:          1.65
95% confidence interval: (0.7841, 2.516)
outcome with 95% confidence: reject h_0
two-sided p-value:           0.0003

统计显示入侵地蜥蜴遇到火蚂蚁比未入侵地抽搐程度高
"""


include("../../utils.jl")
using HypothesisTests,GLMakie,CSV,DataFrames,Distributions
using StatsBase,DataFramesMeta,Pipe


desc=Lock5Table(354,"FireAnts","蜥蜴对适应性的行为的差异性",["Habitat","Twitches"])
data=@pipe load_data(desc.name)|>select(_,desc.feature)|>groupby(_,desc.feature[1])

two_data=[data[1][!,desc.feature[2] ],data[2][!,desc.feature[2]]]
# 1 执行 f-test 检查方差差异
VarianceFTest(two_data...) # fail to reject h_0

# 2 执行两样本配对 t 检验  
EqualVarianceTTest(two_data...)

#= 
    Two sample t-test (equal variance)
    ----------------------------------
    Population details:
        parameter of interest:   Mean difference
        value under h_0:         0
        point estimate:          -20.15
        95% confidence interval: (-28.74, -11.56)

    Test summary:
        outcome with 95% confidence: reject h_0
        two-sided p-value:           <1e-04

    Details:
        number of observations:   [40,40]
        t-statistic:              -4.668602834291153
        degrees of freedom:       78
        empirical standard error: 4.316066436835685
=#

