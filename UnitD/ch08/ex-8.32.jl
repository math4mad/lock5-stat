#= 
LightatNight
lock5stat page 600
LD standard light/dark cycle, 
LL  bright light all the time,
DM  dim light when  normally  darkness.
或许小鼠增重是因为在光照条件下活动减少, 因此有必要检测在不同光照条件下
小鼠的活动量是否有差别
=#

## 1. load package
include("../../utils.jl")

## 2.load  data 

desc=Lock5Table(599,"LightatNight4Weeks","anova",["Light", "Activity"])
df=@pipe load_csv(desc.name)|>select(_,desc.feature)

anova_lm(@formula(Activity~Light), df)

#= 
  Analysis of Variance

Type 1 test / F test

Activity ~ 1 + Light

Table:
───────────────────────────────────────────────────────────────
             DOF        Exp.SS   Mean Square  F value  Pr(>|F|)
───────────────────────────────────────────────────────────────
(Intercept)    1  182785296.33  182785296.33  36.9517    <1e-05
Light          2     935954.00     467977.00   0.0946    0.9101
(Residuals)   24  118718446.66    4946601.94             
───────────────────────────────────────────────────────────────
=#


## results
"""
 p-value=0.9101
 p值非常大, 因此可以推断在不同光照条件下, 小鼠的活动在各组没有显著性差异
"""


