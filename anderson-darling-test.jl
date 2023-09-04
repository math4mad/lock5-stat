"""
anderson-darling-test 检验数据是否来自于某个分布
"""

include("utils.jl")
using HypothesisTests,GLMakie,CSV,DataFrames,Distributions

df= (let str="BodyTemp50"
    df=load_data(str)
end)


data=df[!,1]
μ,σ=mean(data),var(data)

OneSampleADTest(data,Normal(μ,σ))

"""
Test summary:
    outcome with 95% confidence: fail to reject h_0
    one-sided p-value:           0.4583

Details:
    number of observations:   50
    sample mean:              98.26
    sample SD:                0.7653197277702208
    A² statistic:             0.8313313872142676
"""