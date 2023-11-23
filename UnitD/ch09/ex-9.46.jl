"""
chapter:
page 640  9.46 Social Networks and Brain Structure
data:FacebookFriends

"""


## 1 load package
include("../../utils.jl")


## 2. load data
desc = Lock5Table(640, "FacebookFriends", "GMDensity-Friends-LinReg-anova", ["GMdensity", "FBfriends"])

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

anova(model)
#= 
Type 1 test / F test

FBfriends ~ 1 + GMdensity

Table:
─────────────────────────────────────────────────────────────
             DOF      Exp.SS  Mean Square   F value  Pr(>|F|)
─────────────────────────────────────────────────────────────
(Intercept)    1  5138022.40   5138022.40  187.0977    <1e-15
GMdensity      1   245400.47    245400.47    8.9361    0.0049
(Residuals)   38  1043545.13     27461.71              
─────────────────────────────────────────────────────────────
=#

