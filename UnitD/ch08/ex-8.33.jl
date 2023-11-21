#= 
LightatNight
lock5stat page 600
LD standard light/dark cycle, 
LL  bright light all the time,
DM  dim light when  normally  darkness.
或许小鼠增重是因为在不同光照条件下,食物摄入量不同
=#

## 1. load package
include("../../utils.jl")

## 2.load  data 

desc=Lock5Table(599,"LightatNight4Weeks","anova",["Light", "Consumption"])
df=@pipe load_csv(desc.name)|>select(_,desc.feature)

## anova test
anova_lm(@formula(Consumption~Light), df)

#= 
Analysis of Variance

Type 1 test / F test

Consumption ~ 1 + Light

Table:
───────────────────────────────────────────────────────────
             DOF    Exp.SS  Mean Square   F value  Pr(>|F|)
───────────────────────────────────────────────────────────
(Intercept)    1  502.63       502.63    619.2436    <1e-17
Light          2    0.7253       0.3626    0.4468    0.6449
(Residuals)   24   19.48         0.8117              
───────────────────────────────────────────────────────────
=#

## 5. results
"""
p-value=0.6449
因此可以推断在不同光照条件下, 各组小鼠之间食物摄入量没有差别
"""


