"""
chapter:
page 630  9.23 Using pH in Lakes as a Predictor of Mercury in Fish
data:FloridaLakes

"""


## 1 load package
include("../../utils.jl")
import GLM: coef, predict

## 2. load data
desc = Lock5Table(630, "FloridaLakes", "pH-Mecury-LinReg", ["pH","AvgMercury"])

df = @pipe load_csv(desc.name, false)|>select(_,desc.feature)

## 3. lin reg  
model = lm(@formula(AvgMercury ~ pH), df)

#= 
  AvgMercury ~ 1 + pH

Coefficients:
──────────────────────────────────────────────────────────────────────────
                 Coef.  Std. Error      t  Pr(>|t|)  Lower 95%   Upper 95%
──────────────────────────────────────────────────────────────────────────
(Intercept)   1.53092    0.203493    7.52    <1e-09   1.12239    1.93945
pH           -0.152301   0.0303133  -5.02    <1e-05  -0.213157  -0.0914444
──────────────────────────────────────────────────────────────────────────
=#

xtest = range(extrema(df.pH)..., 100)
function f(x)
    input = [1, x]
    coef(model)' ⋅ input
end
yhat = f.(xtest)

#fig = plot_reg_data(df, desc, xtest, yhat);save("UnitD/ch09/imgs/ex-9.23-$(desc.question).png",fig)

