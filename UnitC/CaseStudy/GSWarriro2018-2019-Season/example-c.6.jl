#= 
 lock5stat page 519
=#

## 1. load package
include("../../../utils.jl")
include("./data-c.1.jl")


## 2.  make data
feature=["FT","OppFT","FTA","OppFTA"]
df=@pipe select(data,feature)

a,c=sum(df.FT),sum(df.FTA)
b,d=sum(df.OppFT),sum(df.OppFTA)


##  fisher ecact  ttest
FisherExactTest(a,b,c,d)
#= 
  Fisher's exact test
-------------------
Population details:
    parameter of interest:   Odds ratio
    value under h_0:         1.0
    point estimate:          1.03665
    95% confidence interval: (0.9387, 1.145)

Test summary:
    outcome with 95% confidence: fail to reject h_0
    two-sided p-value:           0.4870

Details:
    contingency table:
        1339  1535
        1672  1987
=#

