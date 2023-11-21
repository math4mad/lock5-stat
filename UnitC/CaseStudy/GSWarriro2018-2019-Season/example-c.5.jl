#= 
 lock5stat page 518
 分析球队某项得分和对手的差别, 目标显而易见,对于体育比赛,社会关注的问题是球队是否遇到不公平的判罚
 如果罚球有显著性差异, 并不能作为因果分析的结论.
 可以作为因果分析的前置条件, 需要更多的证据
=#

## 1. load package
include("../../../utils.jl")
include("./data-c.1.jl")


## 2.  make data
df=@pipe select(data,["FTA","OppFTA"])
transform!(df,["FTA","OppFTA"]=>ByRow(-)=>:FTADiff)

## 3. plot FTADiff dot
function plot_res1()
    h=fit(Histogram,df.FTADiff)
    fig=plot_dotplot(h)
    #save("UnitC/CaseStudy/GSWarriro2018-2019-Season/example-c.5-dotplot.png",fig)
end 
#plot_res1()

## 4. ttest 
   OneSampleTTest(df.FTADiff)
#= 
 One sample t-test
-----------------
Population details:
    parameter of interest:   Mean
    value under h_0:         0
    point estimate:          -3.84146
    95% confidence interval: (-5.769, -1.914)

Test summary:
    outcome with 95% confidence: reject h_0
    two-sided p-value:           0.0002

Details:
    number of observations:   82
    t-statistic:              -3.9661522937831846
    degrees of freedom:       81
    empirical standard error: 0.9685617520677449
=#


## 5. ttest resutls

"""
point estimate:          -3.84146
95% confidence interval: (-5.769, -1.914)
outcome with 95% confidence: reject h_0
    two-sided p-value:           0.0002

有充分证据显示勇士队罚球数比对手少
"""


