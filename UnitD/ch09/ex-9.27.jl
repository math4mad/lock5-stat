"""
chapter:
page 630  9.27 Is the Honeybee Population Shrinking?
data:Honeybee

"""


## 1 load package
include("../../utils.jl")
import GLM: coef, predict

## 2. load data
desc = Lock5Table(630, "Honeybee", "Year-Bee-LinReg", ["Year","Colonies"])

df = @pipe load_csv(desc.name, false)


## 3. lin reg  
model = lm(@formula(Colonies ~ Year), df)

#= 
 Colonies ~ 1 + Year

Coefficients:
────────────────────────────────────────────────────────────────────────────
                  Coef.  Std. Error      t  Pr(>|t|)  Lower 95%    Upper 95%
────────────────────────────────────────────────────────────────────────────
(Intercept)  19291.5     9317.17      2.07    0.0549  -460.013   39043.0
Year            -8.3581     4.65043  -1.80    0.0912   -18.2166      1.50038
────────────────────────────────────────────────────────────────────────────
=#


xtest = range(extrema(df.Year)..., 100)
function f(x)
    input = [1, x]
    coef(model)' ⋅ input
end
yhat = f.(xtest)

#fig = plot_reg_data(df, desc, xtest, yhat);save("UnitD/ch09/imgs/ex-9.27-$(desc.question).png",fig)

r2(model)