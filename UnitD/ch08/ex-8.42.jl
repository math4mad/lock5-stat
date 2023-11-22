#= 
lock5stat page 602 
different enviorment affect fish gill beat rate

=#

## 1. load package
include("../../utils.jl")

## 2. load data 
desc=Lock5Table(602,"FishGills3","different enviorment affect fish gill beat rate?", ["Calcium", "GillRate"])
data=@pipe load_csv(desc.name)
cats=levels(data.Calcium)

## 3.anova test

anova_lm(@formula(GillRate~Calcium), data)

#= 
Analysis of Variance

Type 1 test / F test

GillRate ~ 1 + Calcium

Table:
─────────────────────────────────────────────────────────────
             DOF     Exp.SS  Mean Square    F value  Pr(>|F|)
─────────────────────────────────────────────────────────────
(Intercept)    1  343484.44    343484.44  1567.4897    <1e-56
Calcium        2    2037.22      1018.61     4.6484    0.0121
(Residuals)   87   19064.33       219.13               
─────────────────────────────────────────────────────────────
=#

## 4. results
"""
p-value=0.0121
根据 pvalue 推断,在不同的环境下, 鱼的腮活动的频率显著不同 
"""


