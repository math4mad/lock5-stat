"""
fire ant 分泌的毒液能够杀死蜥蜴,
科学家想知道蜥蜴对 fire ant 是否有适应性的行为

检测观察入侵地的蜥蜴和未入侵低蜥蜴遇到 fire ant 时逃跑数量是否有差异

outcome with 95% confidence: reject h_0
two-sided p-value:           <1e-04
95% confidence interval: (-28.74, -11.56)

入侵地逃跑蜥蜴均数明显比未入侵地低
"""


include("$(pwd())/utils.jl")
using HypothesisTests,GLMakie,CSV,DataFrames,Distributions
using StatsBase,DataFramesMeta,Pipe
using AlgebraOfGraphics


desc=Lock5Table(354,"FireAnts","蜥蜴对 fireant 是否有适应性的行为",["Habitat","Flee"])
#data=@pipe load_data(desc.name)|>select(_,desc.feature)|>groupby(_,desc.feature[1])

#two_data=[data[1][!,desc.feature[2] ],data[2][!,desc.feature[2]]]
# 1 执行 f-test 检查方差差异
# (two_data...) # fail to reject h_0

# 2 执行两样本配对 t 检验  
# EqualVarianceTTest(two_data...)

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

function plot_frequency()
    set_aog_theme!()
    axis = (width = 225, height = 225)
    lizard_frequency = @pipe load_data(desc.name)|>data(_) * frequency() * mapping(:Habitat,color =Symbol("Habitat"))
    fg=draw(lizard_frequency; axis)
    #save("lizards-group.png", fg, px_per_unit = 3)
end

plot_frequency()