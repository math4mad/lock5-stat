"""
chapter:10
page 669  10.55 Predicting Body Mass Gain in Mice
data:LightatNight4Weeks

"""


## 1 load package
include("../../utils.jl")
import GLM: coef, predict,confint

## 2. load data
desc = Lock5Table(669, "LightatNight4Weeks", "Predicting Body Mass Gain in Mice", ["Corticosterone","DayPct","Consumption","BMGain"])
data = @pipe load_csv(desc.name,false)|>select(_,desc.feature)

## 3. lin reg 
model = lm(@formula(BMGain~Corticosterone+DayPct+Consumption),data)
#= 
BMGain ~ 1 + Corticosterone + DayPct + Consumption

Coefficients:
───────────────────────────────────────────────────────────────────────────────
                      Coef.  Std. Error      t  Pr(>|t|)   Lower 95%  Upper 95%
───────────────────────────────────────────────────────────────────────────────
(Intercept)     -2.05987     2.71205     -0.76    0.4553  -7.67018    3.55043
Corticosterone   0.00225546  0.00856171   0.26    0.7946  -0.0154558  0.0199667
DayPct           0.116688    0.0244515    4.77    <1e-04   0.0661063  0.16727
Consumption      0.840602    0.543688     1.55    0.1357  -0.284102   1.96531
───────────────────────────────────────────────────────────────────────────────
=#

## 4 anova

anova(model)

#= 
Analysis of Variance

Type 1 test / F test

BMGain ~ 1 + Corticosterone + DayPct + Consumption

Table:
─────────────────────────────────────────────────────────────
                DOF   Exp.SS  Mean Square   F value  Pr(>|F|)
─────────────────────────────────────────────────────────────
(Intercept)       1  1876.50    1876.50    383.6211    <1e-15
Corticosterone    1    12.56      12.56      2.5670    0.1228
DayPct            1   138.17     138.17     28.2461    <1e-04
Consumption       1    11.69      11.69      2.3905    0.1357
(Residuals)      23   112.51       4.8915              
─────────────────────────────────────────────────────────────
=#

