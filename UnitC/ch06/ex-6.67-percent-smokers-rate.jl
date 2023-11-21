"""
page 447
data: "NutritionStudy"
question :"the proportion of smokers is different from 20%?
res:  95% confidence interval: (0.1006, 0.1794)
"""


## 1. load package
include("../../utils.jl")


## load data

desc=Lock5Table(447,"NutritionStudy","the proportion of smokers?",["Smoke"])

df=@pipe load_csv(desc.name)|>select(_,desc.feature)
smokers=filter(row -> row.Smoke =="Yes", df)
cats=levels(df[!,"Smoke"])|>length
x,n=size(smokers,1),size(df,1)


## 3. ttest
BinomialTest(x,n,0.2)

#= 
        Binomial test
    -------------
    Population details:
        parameter of interest:   Probability of success
        value under h_0:         0.2
        point estimate:          0.136508
        95% confidence interval: (0.1006, 0.1794)

    Test summary:
        outcome with 95% confidence: reject h_0
        two-sided p-value:           0.0043

    Details:
        number of observations: 315
        number of successes:    43
=#