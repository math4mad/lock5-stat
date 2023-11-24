## 1 load package
include("../../utils.jl")
import GLM: coef, predict,confint,ftest

## 2. load data
include("sleepstudy_data.jl")

df=@pipe select(data,["DASScore", "PoorSleepQuality"])


## linreg  
model = lm(@formula(PoorSleepQuality~DASScore),data)
#= 
PoorSleepQuality ~ 1 + DASScore

Coefficients:
─────────────────────────────────────────────────────────────────────────
                 Coef.  Std. Error      t  Pr(>|t|)  Lower 95%  Upper 95%
─────────────────────────────────────────────────────────────────────────
(Intercept)  4.64184    0.257352    18.04    <1e-46  4.135       5.14869
DASScore     0.0805943  0.00991184   8.13    <1e-13  0.0610734   0.100115
─────────────────────────────────────────────────────────────────────────
=#

#fig=plot_linreg_residuals(model,df)#;save("UnitD/CaseStudy/example-d.6-linreg-residuals.png",fig)

ftest(model.model)
#= 
F-test against the null model:
F-statistic: 66.12 on 253 observations and 1 degrees of freedom, p-value: <1e-13
=#

anova(model)

#= 
Analysis of Variance

Type 1 test / F test

PoorSleepQuality ~ 1 + DASScore

Table:
───────────────────────────────────────────────────────────
             DOF   Exp.SS  Mean Square    F value  Pr(>|F|)
───────────────────────────────────────────────────────────
(Intercept)    1  9904.70    9904.70    1462.0532    <1e-99
DASScore       1   447.90     447.90      66.1151    <1e-13
(Residuals)  251  1700.40       6.7745               
───────────────────────────────────────────────────────────
=#