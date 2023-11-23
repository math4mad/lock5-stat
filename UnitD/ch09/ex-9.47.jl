"""
chapter:
page 640  9.47 Fiber in Cereal
data:Cereal

"""


## 1 load package
include("../../utils.jl")
include("data-9.2.jl")

## 2. load data
data=select(df,["Fiber","Calories"])


## 3. lin reg
model=lm(@formula( Calories~Fiber), data)

##  4. anova
anova(model)

#= 
Analysis of Variance

Type 1 test / F test

Calories ~ 1 + Fiber

Table:
────────────────────────────────────────────────────────────
             DOF     Exp.SS  Mean Square   F value  Pr(>|F|)
────────────────────────────────────────────────────────────
(Intercept)    1  537340.83    537340.83  541.7121    <1e-19
Fiber          1    7376.11      7376.11    7.4361    0.0109
(Residuals)   28   27774.06       991.93              
────────────────────────────────────────────────────────────
=#

## 4. results
"""
p-value=0.0109<0.05  因此拒绝回归模型中 "Fiber" 的系数为 0的假设
可以回归模型成立
"""

