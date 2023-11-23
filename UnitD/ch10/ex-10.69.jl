"""
chapter:10
page 678  10.69 Grams of Fat and Number of Calories
data:NutritionStudy

"""


## 1 load package
include("../../utils.jl")
import GLM: coef, predict,confint

## 2. load data
desc = Lock5Table(678, "NutritionStudy", "Predicting Calories with Fat", ["Fat","Calories"])
data = @pipe load_csv(desc.name,true)|>select(_,desc.feature)

## 3. lin reg 
model = lm(@formula(Calories~Fat),data)
#= 
Calories ~ 1 + Fat

Coefficients:
────────────────────────────────────────────────────────────────────────
                Coef.  Std. Error      t  Pr(>|t|)  Lower 95%  Upper 95%
────────────────────────────────────────────────────────────────────────
(Intercept)  445.976    46.831      9.52    <1e-18   353.832    538.119
Fat           17.5337    0.556765  31.49    <1e-98    16.4382    18.6292
────────────────────────────────────────────────────────────────────────
=#

## 4. plot residuals
#fig=plot_linreg_residuals(model, data);save("UnitD/ch10/imgs/ex-10.69-linreg-residuals.png",fig)

deviance(model)


