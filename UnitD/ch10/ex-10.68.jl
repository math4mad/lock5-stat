"""
chapter:10
page 678  Exercise and Pulse Rate
data:StudentSurvey

"""


## 1 load package
include("../../utils.jl")
import GLM: coef, predict,confint

## 2. load data
desc = Lock5Table(678, "StudentSurvey", "Predicting Pulse with Exercise", ["Exercise","Pulse"])
data = @pipe load_csv(desc.name,true)|>select(_,desc.feature)

## 3. lin reg 
model = lm(@formula(Pulse~Exercise),data)
#= 
Pulse ~ 1 + Exercise

Coefficients:
─────────────────────────────────────────────────────────────────────────
                 Coef.  Std. Error      t  Pr(>|t|)  Lower 95%  Upper 95%
─────────────────────────────────────────────────────────────────────────
(Intercept)  73.0247      1.25616   58.13    <1e-99   70.5534   75.496
Exercise     -0.345303    0.118997  -2.90    0.0040   -0.57941  -0.111195
─────────────────────────────────────────────────────────────────────────
=#

## 4. plot residuals
#fig=plot_linreg_residuals(model, data);save("UnitD/ch10/imgs/ex-10.68-linreg-residuals.png",fig)




