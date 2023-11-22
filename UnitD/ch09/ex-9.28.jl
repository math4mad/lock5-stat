"""
chapter:
page 631  9.28 Homes for Sale
data:Honeybee

"""


## 1 load package
include("../../utils.jl")
import GLM: coef, predict

## 2. load data
desc = Lock5Table(630, "HomesForSaleCA", "Bedroom-Price-LinReg", ["Beds", "Price"])

df = @pipe load_csv(desc.name, false)|>select(_,desc.feature)


model = lm(@formula(Price~ Beds), df)
#= 
Price ~ 1 + Beds

Coefficients:
───────────────────────────────────────────────────────────────────────
                Coef.  Std. Error     t  Pr(>|t|)  Lower 95%  Upper 95%
───────────────────────────────────────────────────────────────────────
(Intercept)  269.762     233.618   1.15    0.2580  -208.782     748.306
Beds          84.7673     72.9106  1.16    0.2548   -64.5834    234.118
───────────────────────────────────────────────────────────────────────
=#


xtest = range(extrema(df.Beds)..., 100)
function f(x)
    input = [1, x]
    coef(model)' ⋅ input
end
yhat = f.(xtest)


fig = plot_reg_data(df, desc, xtest, yhat);save("UnitD/ch09/imgs/ex-9.28-$(desc.question).png",fig)



