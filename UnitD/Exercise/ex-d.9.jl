#= 
D.9 ANOVA for Regression to Predict Tip from Bill 
=#

## 1.load package
include("../../utils.jl")

## 2. load data 
include("restaurant-tips-data.jl")
data=select(df,:Bill,:Tip)

## lin reg 
model = lm(@formula(Tip ~ Bill), data)
anova(model)

#= 
Analysis of Variance

Type 1 test / F test

Tip ~ 1 + Bill

Table:
───────────────────────────────────────────────────────────
             DOF   Exp.SS  Mean Square    F value  Pr(>|F|)
───────────────────────────────────────────────────────────
(Intercept)    1  2326.29    2326.29    2424.5637    <1e-95
Bill           1   765.53     765.53     797.8692    <1e-62
(Residuals)  155   148.72       0.9595               
───────────────────────────────────────────────────────────
=#