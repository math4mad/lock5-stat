## 1. load package
include("../../utils.jl")

## 2. load data
desc=Lock5Table(640,"InkjetPrinters","predict laserjet printer price",[:CostColor,:Price])
data= @pipe load_csv(desc.name)|>select(_,desc.feature)


## 3. linreg  model
model = lm(@formula(Price ~ CostColor), data);

## 4. anova 
anova(model)

#= 
Analysis of Variance

Type 1 test / F test

Price ~ 1 + CostColor

Table:
────────────────────────────────────────────────────────────
             DOF     Exp.SS  Mean Square   F value  Pr(>|F|)
────────────────────────────────────────────────────────────
(Intercept)    1  522291.20    522291.20  119.5581    <1e-08
CostColor      1   57603.55     57603.55   13.1861    0.0019
(Residuals)   18   78633.25      4368.51              
────────────────────────────────────────────────────────────
=#