#=
Crows Never Forget a Face
locks5 stat page 473

乌鸦能记住人脸吗?
当生物学家为了研究乌鸦的行为, 需要抓住乌鸦然后为其戴上脚环标签,乌鸦似乎非常情愿这么做,
所以会对着生物学家大声鸣叫,似乎过很长时间这些乌鸦也能认出当初为其打标记的生物学家,没有打过标签的乌鸦似乎也对生物学家有反应
因此乌鸦可能还有相互交流人脸的能力.

测试乌鸦是否对戴着野人面具和普通面具叫声的比例

戴着 caveman mask  的人 为乌鸦打标记 
戴着  neutral mask 的人 作为对照

使用   FisherExactTest

=#

## 1. load package
include("../../utils.jl")


## 2. produce data 
df=(let
c2=[158,444-158];c3=[109,922-109]
typename=["scold","no scold","Total"]
df=freq_table(DataFrame("cavemanmask(caught crows)"=>c2,"neutralmask(control)"=>c3);typename=typename)
df end)
 """
┌──────────┬───────────────────────────┬──────────────────────┬───────┐
│     Type │ cavemanmask(caught crows) │ neutralmask(control) │ Total │
│   String │                     Int64 │                Int64 │ Int64 │
├──────────┼───────────────────────────┼──────────────────────┼───────┤
│    scold │                       158 │                  109 │   267 │
│ no scold │                       444 │                  922 │  1366 │
│    Total │                       602 │                 1031 │  1633 │
└──────────┴───────────────────────────┴──────────────────────┴───────┘
"""
a=df[1,2]  #  scold with caveman mask
c=df[3,2] # total  caveman mask

b=df[1,3] # scold with  neutral mask
d=df[3,3] # total  neutral mask
#a/c  scold with caveman mask  rate , scold with neutral mask rate
ht=FisherExactTest(a,b,c,d)

#= 
    Fisher's exact test
-------------------
Population details:
    parameter of interest:   Odds ratio
    value under h_0:         1.0
    point estimate:          3.00788
    95% confidence interval: (2.28, 3.979)

Test summary:
    outcome with 95% confidence: reject h_0
    two-sided p-value:           <1e-15

Details:
    contingency table:
        158  109
        444  922
=#
confint(ht;level=0.90)
