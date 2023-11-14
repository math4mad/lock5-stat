

## 1. load  package
    include("../utils.jl")
    using HypothesisTests,GLMakie,CSV,DataFrames
    using Statistics,DataFramesMeta,Pipe
## 2. load data
    desc=Lock5Table(352,"HumanTears25","Do Tears Subconsciously Affect Sadness Ratings?",["SexDiff","SadDiff"])
    df=@pipe load_csv(desc.name)

## 3. test

    OneSampleTTest(df.SadDiff,0)
    
#= 
    One sample t-test
    -----------------
    Population details:
        parameter of interest:   Mean
        value under h_0:         0
        point estimate:          18.48
        95% confidence interval: (-14.41, 51.37)

    Test summary:
        outcome with 95% confidence: fail to reject h_0
        two-sided p-value:           0.2576

    Details:
        number of observations:   25
        t-statistic:              1.1595602410518095
        degrees of freedom:       24
        empirical standard error: 15.937076268876925
=#



