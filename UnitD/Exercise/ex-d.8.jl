#= 
D.8 Tip by Number of Guests: Regression
=#

## 1.load package
include("../../utils.jl")

## 2. load data 
include("restaurant-tips-data.jl")
data=select(df,:Guests,:Tip)

## lin reg 
model = lm(@formula(Tip ~ Guests), data)

#= 
Tip ~ 1 + Guests

Coefficients:
──────────────────────────────────────────────────────────────────────
               Coef.  Std. Error     t  Pr(>|t|)  Lower 95%  Upper 95%
──────────────────────────────────────────────────────────────────────
(Intercept)  1.1068     0.412993  2.68    0.0082   0.29098     1.92262
Guests       1.30873    0.180163  7.26    <1e-10   0.952839    1.66462
──────────────────────────────────────────────────────────────────────
=#


fig=plot_linreg_residuals(model, data);save("UnitD/Exercise/ex-d.8-linreg-residuals.png",fig)

