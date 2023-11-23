## 1. load package
include("../../utils.jl")

## 2. load data

desc = Lock5Table(649, "HomesForSaleCA", "Size-Price-LinReg", ["Size", "Price"])
data = @pipe load_csv(desc.name)|>select(_,desc.feature)

## 3. line reg  

model=lm(@formula(Price~Size), data)
#= 
Price ~ 1 + Size

Coefficients:
──────────────────────────────────────────────────────────────────────────────
                  Coef.   Std. Error      t  Pr(>|t|)    Lower 95%   Upper 95%
──────────────────────────────────────────────────────────────────────────────
(Intercept)  -56.8167    154.681      -0.37    0.7161  -373.666     260.033
Size           0.339192    0.0855801   3.96    0.0005     0.163889    0.514495
──────────────────────────────────────────────────────────────────────────────
=#

## 4 results
"""
p-value=0.0005 因此拒绝Size在线性回归模型中系数为 0的假设
"""

