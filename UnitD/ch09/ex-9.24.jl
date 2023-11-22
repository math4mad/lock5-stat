"""
chapter:
page 630  9.24 Alkalinity in Lakes as a Predictor of Mer- cury in Fish
data:FloridaLakes

"""


## 1 load package
include("../../utils.jl")
import GLM: coef, predict

## 2. load data
desc = Lock5Table(630, "FloridaLakes", "pH-Mecury-LinReg", ["Alkalinity","AvgMercury"])

df = @pipe load_csv(desc.name, false)|>select(_,desc.feature)


## 3. lin reg  
model = lm(@formula(AvgMercury ~ Alkalinity), df)
#= 
AvgMercury ~ 1 + Alkalinity

Coefficients:
──────────────────────────────────────────────────────────────────────────────
                  Coef.  Std. Error      t  Pr(>|t|)    Lower 95%    Upper 95%
──────────────────────────────────────────────────────────────────────────────
(Intercept)   0.72614    0.0535989   13.55    <1e-17   0.618536     0.833744
Alkalinity   -0.0053016  0.00100568  -5.27    <1e-05  -0.00732059  -0.00328262
──────────────────────────────────────────────────────────────────────────────
=#

xtest = range(extrema(df.Alkalinity)..., 100)
function f(x)
    input = [1, x]
    coef(model)' ⋅ input
end
yhat = f.(xtest)

#fig = plot_reg_data(df, desc, xtest, yhat);save("UnitD/ch09/imgs/ex-9.24-$(desc.question).png",fig)