"""
 根据 BodyTemp50 的数据检验体温均数是否等于98.6 ℉

 检验结果 pvalue=0.0029<0.05
 置信区间95% confidence interval: (98.04, 98.48) 也不包括 μ₀
 因此拒绝 0 假设,  体温均数不等于98.6 ℉
"""


include("utils.jl")
using .Utils
using HypothesisTests,GLMakie,CSV,DataFrames

df= (let str="BodyTemp50"
    df=load_data(str)
end)

data=df[!,1]
μ₀=98.6
res=OneSampleTTest(data,μ₀)

"""
One sample t-test
-----------------
Population details:
    parameter of interest:   Mean
    value under h_0:         98.6
    point estimate:          98.26
    95% confidence interval: (98.04, 98.48)

Test summary:
    outcome with 95% confidence: reject h_0
    two-sided p-value:           0.0029

Details:
    number of observations:   50
    t-statistic:              -3.1413838802232075
    degrees of freedom:       49
    empirical standard error: 0.10823255385643313
"""