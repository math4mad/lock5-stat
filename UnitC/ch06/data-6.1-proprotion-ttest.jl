"""
Proportion ttest  使用BinomialTest 方法

"""

include("../../utils.jl")
using  HypothesisTests

RockPaperScissors= ProportionTTest(466,"RockPaperScissors",  
"RockPaperScissors的游戏第一次出  Rock 的概率是不是 1/3?"
,[66,119,1/3])

RockPaperScissors_res=BinomialTest(RockPaperScissors.params...)
#= 
    Binomial test
    -------------
    Population details:
        parameter of interest:   Probability of success
        value under h_0:         0.333333
        point estimate:          0.554622
        95% confidence interval: (0.4607, 0.6457)
        
    Test summary:
        outcome with 95% confidence: reject h_0
        two-sided p-value:           <1e-05

    Details:
        number of observations: 119
        number of successes:    66

    结论:  从数据推断玩剪刀石头布的游戏,第一次出石头有偏好
=#


#size matter

ESP100= ProportionTTest(467,"extrasensory perception (ESP)",  
"特异功能者能否感知纸牌的花色?"
,[29,100,0.25])
ESP100_res=BinomialTest(ESP100.params...)

#= 
    Binomial test
    -------------
    Population details:
        parameter of interest:   Probability of success
        value under h_0:         0.25
        point estimate:          0.29
        95% confidence interval: (0.2036, 0.3893)

    Test summary:
        outcome with 95% confidence: fail to reject h_0
        two-sided p-value:           0.4151

    Details:
        number of observations: 100
        number of successes:    29
=#

ESP1000= ProportionTTest(467,"extrasensory perception (ESP)",  
"特异功能者能否感知纸牌的花色?"
,[290,1000,0.25])
ESP1000_res=BinomialTest(ESP1000.params...)
#= 
    Binomial test
    -------------
    Population details:
        parameter of interest:   Probability of success
        value under h_0:         0.25
        point estimate:          0.29
        95% confidence interval: (0.262, 0.3192)

    Test summary:
        outcome with 95% confidence: reject h_0
        two-sided p-value:           0.0045

    Details:
        number of observations: 1000
        number of successes:    290
=#

