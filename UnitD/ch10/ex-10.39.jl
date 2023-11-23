"""
chapter:
page 666  ex 10.39
data:usd  10.39 Predicting Calories Consumed

"""


## 1. load package

include("../../utils.jl")


## 2. load data

desc=Lock5Table(666,"NutritionStudy","Predicting Calories Consumed",["Fat","Cholesterol","Age","Calories"])
df=@pipe load_csv(desc.name,false)
data=select(df,desc.feature)


## 3. lin reg
model=lm(@formula(Calories ~ Fat+Cholesterol+Age), data)
#= 
Calories ~ 1 + Fat + Cholesterol + Age

Coefficients:
────────────────────────────────────────────────────────────────────────────
                  Coef.  Std. Error      t  Pr(>|t|)   Lower 95%   Upper 95%
────────────────────────────────────────────────────────────────────────────
(Intercept)  512.946      86.5106     5.93    <1e-08  342.726     683.166
Fat           16.2645      0.792483  20.52    <1e-59   14.7051     17.8238
Cholesterol    0.420827    0.201479   2.09    0.0375    0.024392    0.817262
Age           -1.42046     1.30401   -1.09    0.2769   -3.98626     1.14534
────────────────────────────────────────────────────────────────────────────
=#

## 4. anova 
anova(model)
#= 
Analysis of Variance

Type 1 test / F test

Calories ~ 1 + Fat + Cholesterol + Age

Table:
───────────────────────────────────────────────────────────────────
             DOF         Exp.SS    Mean Square    F value  Pr(>|F|)
───────────────────────────────────────────────────────────────────
(Intercept)    1  1016809845.38  1016809845.38  9230.2565    <1e-99
Fat            1   110475564.97   110475564.97  1002.8599    <1e-98
Cholesterol    1      475806.11      475806.11     4.3192    0.0385
Age            1      130714.01      130714.01     1.1866    0.2769
(Residuals)  311    34259921.39      110160.52               
───────────────────────────────────────────────────────────────────
 =#

 ## 5. predict
 x_test=DataFrame(Age=[35],Fat=[40],Cholesterol=[180])
 y_hat=predict(model,x_test;interval= :confidence,level=0.95)
 #= 
 1×3 DataFrame
 Row │ prediction  lower     upper    
     │ Float64?    Float64?  Float64? 
─────┼────────────────────────────────
   1 │    1189.56   1116.44   1262.67
 =#

 ## which variable is significant  variable?
 #= 
    Fat  p-value=<1e-59
 =#

 