"""
page 401
question :可乐能影响人体钙的水平吗?
"""


include("$(pwd())/utils.jl")
using HypothesisTests,GLMakie,CSV,DataFrames
using Statistics,Pipe


data= """
Drink,Calcium
Diet cola,50
Diet cola,62
Diet cola,48
Diet cola,55
Diet cola,58
Diet cola,61
Diet cola,58
Diet cola,56
Water,48
Water,46
Water,54
Water,45
Water,53
Water,46
Water,53
Water,48
"""
feature=["Drink","Calcium"]
df = @pipe CSV.File(IOBuffer(data))|>DataFrame|>groupby(_,feature[1])

EqualVarianceTTest(df[1][!,feature[2]],df[2][!,feature[2]])

#= Two sample t-test (equal variance)
    ----------------------------------
    Population details:
        parameter of interest:   Mean difference
        value under h_0:         0
        point estimate:          6.875
        95% confidence interval: (2.228, 11.52)

    Test summary:
        outcome with 95% confidence: reject h_0
        two-sided p-value:           0.0068

    Details:
        number of observations:   [8,8]
        t-statistic:              3.1731607460550006
        degrees of freedom:       14
        empirical standard error: 2.166609431478463

=#