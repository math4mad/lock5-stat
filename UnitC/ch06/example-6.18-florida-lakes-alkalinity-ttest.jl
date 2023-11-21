"""
page 487  Alkalinity ttest
data:FloridaLakes

"""


## 1. load package
include("../../utils.jl")



## 2. load data 
desc=Lock5Table(487,"FloridaLakes","the average alkalinity of all Florida lakes is greater than 35 mg/L?",["Alkalinity"])
data=@pipe load_csv(desc.name)

## 3. ttest
    μ₀=35.0
    res=OneSampleTTest(data.Alkalinity,μ₀) 

#= 
        One sample t-test
    -----------------
    Population details:
        parameter of interest:   Mean
        value under h_0:         35.0
        point estimate:          37.5302
        95% confidence interval: (27.0, 48.06)

    Test summary:
        outcome with 95% confidence: fail to reject h_0
        two-sided p-value:           0.6317

    Details:
        number of observations:   53
        t-statistic:              0.48215579018696153
        degrees of freedom:       52
        empirical standard error: 5.247657978480706
=#

