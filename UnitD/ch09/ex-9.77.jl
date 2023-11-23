"""
chapter:
page 650  9.77 Predicting Average HwyMPG Based on CityMPG
data:Cars2020

[Plot the confidence interval for a model fit](https://discourse.julialang.org/t/plot-the-confidence-interval-for-a-model-fit/37767)

"""


## 1 load package
include("../../utils.jl")


## 2. load data
desc = Lock5Table(650, "Cars2020", "CityMPG-HwyMPG-LinReg", ["CityMPG", "HwyMPG"])

df = @pipe load_csv(desc.name, false)|>select(_,desc.feature)

## 3. lin reg
model = lm(@formula(HwyMPG~ CityMPG), df)
#= 
HwyMPG ~ 1 + CityMPG

Coefficients:
───────────────────────────────────────────────────────────────────────
               Coef.  Std. Error      t  Pr(>|t|)  Lower 95%  Upper 95%
───────────────────────────────────────────────────────────────────────
(Intercept)  6.69294    1.47722    4.53    <1e-04    3.76483    9.62105
CityMPG      1.68657    0.088917  18.97    <1e-35    1.51032    1.86282
───────────────────────────────────────────────────────────────────────
=#


## 4 predict value 
x_test=DataFrame(CityMPG=[20])
predict(model,x_test;interval = :confidence, level = 0.95)
#= 
1×3 DataFrame
 Row │ prediction  lower     upper    
     │ Float64?    Float64?  Float64? 
─────┼────────────────────────────────
   1 │    40.4243   39.4855   41.3631

=#


##  5. plot reg 
plot_linreg(df,model)