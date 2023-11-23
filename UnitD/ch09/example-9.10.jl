"""
chapter:
page 634  example-9.10
data:Cereal
feature:["Name", "Company", "Serving", "Calories", "Fat", "Sodium", "Carbs", "Fiber", "Sugars", "Protein"]

"""


## 1 load package
include("data-9.2.jl")
include("../../utils.jl")
import GLM: coef, predict,confint

## 2. load data
features=["Sugars","Calories"]
data=df
#= 
5×2 DataFrame
 Row │ Sugars   Calories 
     │ Float64  Int64    
─────┼───────────────────
   1 │    15.0       117
   2 │    14.0       118
   3 │    16.0       144
   4 │    13.3       169
   5 │    16.0       130
=#


## 4. lm 
lm(@formula( Calories~Sugars), data)
#= 
Calories ~ 1 + Sugars

Coefficients:
───────────────────────────────────────────────────────────────────────
                Coef.  Std. Error     t  Pr(>|t|)  Lower 95%  Upper 95%
───────────────────────────────────────────────────────────────────────
(Intercept)  88.9204    10.812     8.22    <1e-08   66.773    111.068
Sugars        4.31026    0.926928  4.65    <1e-04    2.41154    6.20899
───────────────────────────────────────────────────────────────────────
=#

## anova lm
model2=anova_lm(@formula( Calories~Sugars), data)

#= 
 Analysis of Variance

Type 1 test / F test

Calories ~ 1 + Sugars

Table:
────────────────────────────────────────────────────────────
             DOF     Exp.SS  Mean Square   F value  Pr(>|F|)
────────────────────────────────────────────────────────────
(Intercept)    1  537340.83    537340.83  758.5866    <1e-21
Sugars         1   15316.51     15316.51   21.6230    <1e-04
(Residuals)   28   19833.65       708.34              
────────────────────────────────────────────────────────────
=#

