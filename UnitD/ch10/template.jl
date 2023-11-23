"""
chapter:
page 629  9.21 Social Networks and Brain Structure
data:FacebookFriends

"""


## 1 load package
include("../../utils.jl")
import GLM: coef, predict

## 2. load data
desc = Lock5Table(629, "FacebookFriends", "GMDensity-Friends-LinReg", ["GMdensity", "FBfriends"])

df = @pipe load_csv(desc.name, false)

## 3. lin reg  
model = lm(@formula(FBfriends ~ GMdensity), df)
#= 
 FBfriends ~ 1 + GMdensity

Coefficients:
────────────────────────────────────────────────────────────────────────
                Coef.  Std. Error      t  Pr(>|t|)  Lower 95%  Upper 95%
────────────────────────────────────────────────────────────────────────
(Intercept)  366.645      26.3467  13.92    <1e-15   313.309     419.981
GMdensity     82.4488     27.581    2.99    0.0049    26.6139    138.284
────────────────────────────────────────────────────────────────────────
=#

## 4. plot results
xtest = range(extrema(df.GMdensity)..., 100)
function f(x)
    input = [1, x]
    coef(model)' ⋅ input
end
yhat = f.(xtest)

fig = plot_reg_data(df, desc, xtest, yhat);#save("UnitD/ch09/imgs/ex-9.21-$(desc.question).png",fig)