#= 
lockstat page 698
10.83  example-d-1  Are You a Lark or an Owl?
feature : ["Gender", "ClassYear", "LarkOwl", "NumEarlyClass", "EarlyClass", "GPA", "ClassesMissed", "CognitionZscore", "PoorSleepQuality", "DepressionScore", "AnxietyScore", "StressScore", "DepressionStatus", "AnxietyStatus", "Stress", "DASScore", "Happiness", "AlcoholUse", "Drinks", "WeekdayBed", "WeekdayRise", "WeekdaySleep", "WeekendBed", "WeekendRise", "WeekendSleep", "AverageSleep", "AllNighter"]

以前的研究发现  expected=[0.1,0.7,0.2]  Lark,Neither,Owl 的比例
27年以后,随着生活方式的变化, 这个比例是否发生变化?
这个比例可以作为 生活方式的 indicator  ,如果比例没有发生变化, 极有可能生活方法也没有改变
所以使用卡方检验根据观测数据检验这个比例有重要的意义

=#

## 1 load package
include("../../utils.jl")
import GLM: coef, predict,confint,ftest

## 2. load data
include("sleepstudy_data.jl")
ft=freqtable(data,:LarkOwl)
#= 
3-element Named Vector{Int64}
LarkOwl  │ 
─────────┼────
Lark     │  41
Neither  │ 163
Owl      │  49
=#


## 3. Chi-square  test
obs=values(ft)
expected=[0.1,0.7,0.2]
res=ChisqTest(obs,expected)
@info res

#= 
 Pearson's Chi-square Test
-------------------------
Population details:
    parameter of interest:   Multinomial Probabilities
    value under h_0:         [0.1, 0.7, 0.2]
    point estimate:          [0.162055, 0.644269, 0.193676]
    95% confidence interval: [(0.1067, 0.2245), (0.5889, 0.7067), (0.1383, 0.2561)]

Test summary:
    outcome with 95% confidence: reject h_0
    one-sided p-value:           0.0043

Details:
    Sample size:        253
    statistic:          10.9158667419537
    degrees of freedom: 2
    residuals:          [3.12133, -1.05952, -0.224929]
    std. residuals:     [3.29017, -1.93441, -0.251478]
=#


## 4.  results
"""
根据检验结果 p-value =0.0043 远小于 0.05 因此有充分理由相信
现在的人群的作息方式比例和 27 年以前有很大的不同
"""



