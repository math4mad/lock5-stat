#= 
LightatNight
lock5stat page 599
LD standard light/dark cycle, 
LL  bright light all the time,
DM  dim light when  normally  darkness.
=#

## 1. load package
include("../../utils.jl")

## 2.load  data 

desc=Lock5Table(599,"LightatNight4Weeks","anova",["Light", "BMGain"])
df=@pipe load_csv(desc.name)|>select(_,desc.feature)

anova_lm(@formula(BMGain~Light), df)

#= 
Analysis of Variance

Type 1 test / F test

BMGain ~ 1 + Light

Table:
──────────────────────────────────────────────────────────
             DOF   Exp.SS  Mean Square   F value  Pr(>|F|)
──────────────────────────────────────────────────────────
(Intercept)    1  1876.50    1876.50    278.2758    <1e-13
Light          2   113.08      56.54      8.3848    0.0017
(Residuals)   24   161.84       6.7433              
──────────────────────────────────────────────────────────
=#

