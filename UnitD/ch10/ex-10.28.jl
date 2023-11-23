"""
chapter:
page 664  ex 10.28
data:usd  dass and bmi predict depression

["Group", "CESD1", "CESD21", "CESDDiff", "DASS1", "DASS21", "DASSDiff", "BMI1", "BMI21", "BMIDiff"]
"""


## 1. load package

include("../../utils.jl")


## 2. load data

desc=Lock5Table(664,"DietDepression","dass and bmi predict depression",["DASS1","BMI1","CESD1"])
df=@pipe load_csv(desc.name)
data=select(df,desc.feature)


## 3. lin reg
model=lm(@formula(CESD1 ~ DASS1+BMI1), data)

#= 
CESD1 ~ 1 + DASS1 + BMI1

Coefficients:
─────────────────────────────────────────────────────────────────────────
                 Coef.  Std. Error      t  Pr(>|t|)  Lower 95%  Upper 95%
─────────────────────────────────────────────────────────────────────────
(Intercept)  13.805      8.71118     1.58    0.1174  -3.56039   31.1705
DASS1         0.797566   0.0951414   8.38    <1e-11   0.607905   0.987227
BMI1         -0.400459   0.381877   -1.05    0.2978  -1.16172    0.360799
─────────────────────────────────────────────────────────────────────────
=#

## 4. anova
anova(model)

#= 
Analysis of Variance

Type 1 test / F test

CESD1 ~ 1 + DASS1 + BMI1

Table:
───────────────────────────────────────────────────────────
             DOF    Exp.SS  Mean Square   F value  Pr(>|F|)
───────────────────────────────────────────────────────────
(Intercept)    1  31416.33     31416.33  292.1597    <1e-26
DASS1          1   7478.16      7478.16   69.5440    <1e-11
BMI1           1    118.25       118.25    1.0997    0.2978
(Residuals)   72   7742.26       107.53              
───────────────────────────────────────────────────────────
=#