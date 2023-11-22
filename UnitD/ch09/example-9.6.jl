## 1. load package
include("../../utils.jl")

## 2. load data

desc = Lock5Table(159, "RestaurantTips", "Bill-Tip-relation", ["Bill","PctTip"])
data = @pipe load_csv(desc.name)|>select(_,desc.feature)

## 3.  correlation test

model=CorrelationTest(eachcol(data)...)

#= 
  Test for nonzero correlation
----------------------------
Population details:
    parameter of interest:   Correlation
    value under h_0:         0.0
    point estimate:          0.135298
    95% confidence interval: (-0.0218, 0.2859)

Test summary:
    outcome with 95% confidence: fail to reject h_0
    two-sided p-value:           0.0911

Details:
    number of observations:          157
    number of conditional variables: 0
    t-statistic:                     1.70007
    degrees of freedom:              155
=#

confint(model)    #(-0.02180261909592736, 0.28587718690889646)
