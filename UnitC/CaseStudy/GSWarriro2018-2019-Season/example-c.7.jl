## 1. load package
include("../../../utils.jl")
include("./data-c.1.jl")


## 2.  make data
df=@pipe select(data,["FT","OppFT"])
transform!(df,["FT","OppFT"]=>ByRow(-)=>:FTDiff)

## 3. plot FTADiff dot
function plot_res1()
    h=fit(Histogram,df.FTDiff)
    fig=plot_dotplot(h)
    #save("UnitC/CaseStudy/GSWarriro2018-2019-Season/example-c.7-dotplot.png",fig)
end 
#plot_res1()

## 4. ttest 
OneSampleTTest(df.FTDiff)
#= 
One sample t-test
-----------------
Population details:
    parameter of interest:   Mean
    value under h_0:         0
    point estimate:          -2.39024
    95% confidence interval: (-3.999, -0.7812)

Test summary:
    outcome with 95% confidence: reject h_0
    two-sided p-value:           0.0041

Details:
    number of observations:   82
    t-statistic:              -2.9557733696992177
    degrees of freedom:       81
    empirical standard error: 0.8086695437959974
=#

## 5. ttest resluts
"""
95% confidence interval: (-3.999, -0.7812)
95% 确信, 勇士队比对手罚球得分少(-3.999, -0.7812)

"""