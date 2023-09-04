"""
FTA   CI
使用 OneSampleADTest  检验 检测  FTA 数据是否来自于正态分布
也可以使用
ExactOneSampleKSTest(x::AbstractVector{<:Real}, d::UnivariateDistribution)
ApproximateOneSampleKSTest(x::AbstractVector{<:Real}, d::UnivariateDistribution)

上述方法没有计算置信区间, 可以使用 OneSampleTTest 的方法, 任意指定一个均值, 从而获得置信区间

也可以使用 SignTest(x::AbstractVector{T<:Real}, median::Real = 0)
"""

include("$(pwd())/utils.jl")
include("data.jl")
using HypothesisTests,GLMakie,CSV,DataFrames,Distributions,Pipe
fta=data[!,:FTA]

#model1=@pipe mean_and_std(fta)|>OneSampleADTest(fta,Normal(_...))

"""
outcome with 95% confidence: fail to reject h_0
one-sided p-value:           0.8282
"""

ci090=@pipe OneSampleTTest(fta)|>confint(_;level=0.90)
#ci095=@pipe SignTest(fta)|>confint(_;level=0.95)  

