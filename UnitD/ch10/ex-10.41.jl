"""
chapter:
page 666  10.41 StudentSurvey
data:StudentSurvey

"""


## 1 load package
include("../../utils.jl")
import GLM: coef, predict,confint

## 2. load data
desc = Lock5Table(666, "StudentSurvey", "predict weight with gender and  height", ["Sex","Height","Weight"])

data = @pipe load_csv(desc.name,false)|>select(_,desc.feature)

model = lm(@formula(Weight ~ Sex+Height), data;contrasts = Dict(:Sex => DummyCoding()))

#= 
Weight ~ 1 + Sex + Height

Coefficients:
─────────────────────────────────────────────────────────────────────────
                 Coef.  Std. Error      t  Pr(>|t|)  Lower 95%  Upper 95%
─────────────────────────────────────────────────────────────────────────
(Intercept)  -49.3896    25.4057    -1.94    0.0527  -99.3573    0.578002
Sex: M        25.4704     3.13752    8.12    <1e-14   19.2996   31.6412
Height         2.85891    0.385516   7.42    <1e-12    2.10068   3.61714
─────────────────────────────────────────────────────────────────────────
=#

## 4. predict 
x_test=DataFrame(Sex="M",Height=67)
y_hat=predict(model,x_test;interval=:confidence,level=0.95)
#= 
1×3 DataFrame
 Row │ prediction  lower     upper    
     │ Float64?    Float64?  Float64? 
─────┼────────────────────────────────
   1 │    167.628    163.24   172.016

=#

## 5. R2 of model
r2(model)  #0.4815

