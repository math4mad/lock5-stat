## 1 load package
include("../utils.jl")
using HypothesisTests,GLMakie,CSV,DataFrames,Distributions
using StatsBase,DataFramesMeta,Pipe

## 2. load data

    desc=Lock5Table(390,"QuizPulse10","Quiz vs Lecture diff Pulse Rates",["Student", "Quiz", "Lecture"])
    data=@pipe load_data(desc.name)|>select(_,desc.feature[2:3])


## 3.  variance ttest 
    EqualVarianceTTest(eachcol(data)...)
    #= 
    outcome with 95% confidence: fail to reject h_0
    two-sided p-value:           0.6390
    =#
## 4.  ttest
    OneSampleTTest(eachcol(data)...)

    #= 
    One sample t-test
    -----------------
    Population details:
        parameter of interest:   Mean
        value under h_0:         0
        point estimate:          2.7
        95% confidence interval: (-4.406, 9.806)

    Test summary:
        outcome with 95% confidence: fail to reject h_0
        two-sided p-value:           0.4124

    Details:
        number of observations:   10
        t-statistic:              0.8595162341335423
        degrees of freedom:       9
        empirical standard error: 3.141301924008225
    =#

## 5.  diff ttest

       data2=transform(data, ["Quiz", "Lecture"] => ByRow(-) =>:diff)
       OneSampleTTest(data2.diff)
    #= 
      Population details:
    parameter of interest:   Mean
    value under h_0:         0
    point estimate:          2.7
    95% confidence interval: (-4.406, 9.806)

Test summary:
    outcome with 95% confidence: fail to reject h_0
    two-sided p-value:           0.4124
    =#

## 5. 两种检测方法结论
   #= 
    在两种不同压力条件下, 心跳速率没有差异
   =#
