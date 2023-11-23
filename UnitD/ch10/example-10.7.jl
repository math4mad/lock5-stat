"""
chapter:
page 660  Example 10.7
data:InkjetPrinters  one variables -> two variables

"""


## 1. load package

include("../../utils.jl")


## 2. load data

desc=Lock5Table(660,"InkjetPrinters","mutliple regression ",["PhotoTime","CostColor","Price"])
df=@pipe load_csv(desc.name)
data=select(df,desc.feature)


## 3. lin reg
model=lm(@formula(Price ~ PhotoTime+CostColor), data)

#= 
Price ~ 1 + PhotoTime + CostColor

Coefficients:
───────────────────────────────────────────────────────────────────────────
                 Coef.  Std. Error      t  Pr(>|t|)   Lower 95%   Upper 95%
───────────────────────────────────────────────────────────────────────────
(Intercept)  371.892     66.892      5.56    <1e-04  230.762     513.022
PhotoTime      0.10379    0.366344   0.28    0.7804   -0.669129    0.876708
CostColor    -18.7323     5.28209   -3.55    0.0025  -29.8765     -7.58803
───────────────────────────────────────────────────────────────────────────
=#

## 4. anova lm 

anova(model)

#= 
Analysis of Variance

Type 1 test / F test

Price ~ 1 + PhotoTime + CostColor

Table:
────────────────────────────────────────────────────────────
             DOF     Exp.SS  Mean Square   F value  Pr(>|F|)
────────────────────────────────────────────────────────────
(Intercept)    1  522291.20    522291.20  113.4491    <1e-08
PhotoTime      1      72.83        72.83    0.0158    0.9014
CostColor      1   57900.24     57900.24   12.5768    0.0025
(Residuals)   17   78263.72      4603.75              
────────────────────────────────────────────────────────────
=#


## 5 r2 of model
r2(model)  #0.425
