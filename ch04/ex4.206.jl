"""
两列系数相关性检验
h₀:  两列数据相关性为 0
hₐ:  两列相关性不为 0
"""


## 1 load package
    include("../utils.jl")
    using HypothesisTests,GLMakie,CSV,DataFrames,Distributions
    using StatsBase,DataFramesMeta,Pipe

## 2. load data

    desc=Lock5Table(389,"Hurricanes2018","Hurricane Rate",["Year","Hurricanes"])
    data=@pipe load_data(desc.name)

## 3.  coorelation ttest

     CorrelationTest(eachcol(data)...)

        #= 
        Test for nonzero correlation
        ----------------------------
        Population details:
            parameter of interest:   Correlation
            value under h_0:         0.0
            point estimate:          0.320855
            95% confidence interval: (0.1377, 0.4828)

        Test summary:
            outcome with 95% confidence: reject h_0
            two-sided p-value:           0.0008

        Details:
            number of observations:          105
            number of conditional variables: 0
            t-statistic:                     3.4381
            degrees of freedom:              103
        =#

    ## 4. 结论
       #= 
        outcome with 95% confidence: reject h_0
            two-sided p-value:           0.0008

        p-value 远小于 0.05 因此可以得出结论, 拒绝 0假设, 两列数据存在相关性, 
        95% confidence interval: (0.1377, 0.4828) 因此,随着时间增加, 飓风发生增加
       =#