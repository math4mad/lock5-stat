include("../../utils.jl")


## 1. load data
desc=Lock5Table(641,"StudentSurvey","verbal-gpa-linreg-anova",["VerbalSAT","GPA"])
data=@pipe load_csv(desc.name,false)|>select(_,desc.feature)
#plot_pair_cor(data)

## 2. linreg model
model=lm(@formula(GPA~VerbalSAT), data)

## 3. anova
anova(model)

#= 
Analysis of Variance

Type 1 test / F test

GPA ~ 1 + VerbalSAT

Table:
──────────────────────────────────────────────────────────────
             DOF     Exp.SS  Mean Square     F value  Pr(>|F|)
──────────────────────────────────────────────────────────────
(Intercept)    1  3440.55      3440.55    24700.8636    <1e-99
VerbalSAT      1     6.8029       6.8029     48.8402    <1e-10
(Residuals)  343    47.78         0.1393                
──────────────────────────────────────────────────────────────
=#

