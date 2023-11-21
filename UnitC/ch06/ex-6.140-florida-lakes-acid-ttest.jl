"""
page 468  pH ttest
data:FloridaLakes

"""


## 1 load package
include("../../utils.jl")


## 2. load data
desc=Lock5Table(468,"FloridaLakes","Are Florida Lakes Acidic or Alkaline?",["pH"])

μ₀=7.0

data=@pipe load_csv(desc.name)
    
res=OneSampleTTest(data.pH,μ₀) 


#= 
    One sample t-test
    -----------------
    Population details:
        parameter of interest:   Mean
        value under h_0:         7.0
        point estimate:          6.59057
        95% confidence interval: (6.235, 6.946)

    Test summary:
        outcome with 95% confidence: reject h_0
        two-sided p-value:           0.0247

    Details:
        number of observations:   53
        t-statistic:              -2.3134198913532305
        degrees of freedom:       52
        empirical standard error: 0.1769821223524862
=#

