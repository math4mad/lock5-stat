"""
chapter:
page 641  9.51 Mating Activity of Water Striders
data:WaterStriders
水蝇的交配行为

"""


## 1 load package
include("../../utils.jl")


## 2. load data
    desc=Lock5Table(641,"WaterStriders","Mating Activity of Water Striders",["FemalesHiding","MatingActivity"])
    data=@pipe load_csv(desc.name,false)|>select(_,desc.feature)

## 3. lin reg 
    model=lm(@formula(MatingActivity~FemalesHiding), data)
#= 
MatingActivity ~ 1 + FemalesHiding

Coefficients:
────────────────────────────────────────────────────────────────────────────
                   Coef.  Std. Error      t  Pr(>|t|)  Lower 95%   Upper 95%
────────────────────────────────────────────────────────────────────────────
(Intercept)     0.480138   0.0421258  11.40    <1e-05   0.382995   0.57728
FemalesHiding  -0.323215   0.126049   -2.56    0.0334  -0.613885  -0.0325444
────────────────────────────────────────────────────────────────────────────
=#

## 4. anova
    anova(model)
#= 
Analysis of Variance

Type 1 test / F test

MatingActivity ~ 1 + FemalesHiding

Table:
───────────────────────────────────────────────────────────
               DOF  Exp.SS  Mean Square   F value  Pr(>|F|)
───────────────────────────────────────────────────────────
(Intercept)      1  1.6810       1.6810  163.7748    <1e-05
FemalesHiding    1  0.0675       0.0675    6.5751    0.0334
(Residuals)      8  0.0821       0.0103              
───────────────────────────────────────────────────────────
=#