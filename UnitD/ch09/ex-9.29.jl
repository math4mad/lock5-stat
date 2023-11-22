"""
chapter:
page 631  9.29 Life Expectancy
data:SampCountries

"""


## 1 load package
include("../../utils.jl")
import GLM: coef, predict,confint

## 2. load data
desc = Lock5Table(631, "SampCountries", "Expenditure-LifeExpectancy-LinReg", ["Health", "LifeExpectancy"])

df = @pipe load_csv(desc.name, false)|>select(_,desc.feature)


## 3. lin reg
model = lm(@formula(LifeExpectancy~ Health), df)

#= 
LifeExpectancy ~ 1 + Health

Coefficients:
─────────────────────────────────────────────────────────────────────────
                 Coef.  Std. Error      t  Pr(>|t|)  Lower 95%  Upper 95%
─────────────────────────────────────────────────────────────────────────
(Intercept)  64.1748      2.15969   29.71    <1e-31  59.8325     68.5172
Health        0.811498    0.191857   4.23    0.0001   0.425745    1.19725
─────────────────────────────────────────────────────────────────────────
=#

xtest = range(extrema(df.Health)..., 100)
function f(x)
    input = [1, x]
    coef(model)' ⋅ input
end
yhat = f.(xtest)


#fig = plot_reg_data(df, desc, xtest, yhat);save("UnitD/ch09/imgs/ex-9.29-$(desc.question).png",fig)

## 5 slope  CI 
"slope ci"=>confint(model;level=0.95)[1]
#"slope ci" => 59.83245608275124

ftest(model.model)  #F-statistic: 17.89 on 50 observations and 1 degrees of freedom, p-value: 0.0001


