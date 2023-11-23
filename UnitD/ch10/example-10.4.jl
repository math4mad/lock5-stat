"""
lock5stat page 657
BodyFat

多元回归的方法和多元微积分的分析方法相同, 固定一个变量, 分析另一个变量的变化情况

"""

## 1. load package
include("../../utils.jl")

## 2. load data
desc=Lock5Table(656,"BodyFat","[Weight,Height,Abdomen] predict BodyFat",["Weight","Height","Abdomen","Bodyfat"])
data=@pipe load_csv(desc.name,false)

## 3. linreg
model=lm(@formula(Bodyfat ~ Weight+Height+Abdomen), data)

#= 
Bodyfat ~ 1 + Weight + Height + Abdomen

Coefficients:
─────────────────────────────────────────────────────────────────────────────
                  Coef.  Std. Error      t  Pr(>|t|)   Lower 95%    Upper 95%
─────────────────────────────────────────────────────────────────────────────
(Intercept)  -56.1329    18.1372     -3.09    0.0026  -92.1349    -20.1309
Weight        -0.175598   0.0471979  -3.72    0.0003   -0.269285   -0.0819113
Height         0.101848   0.244352    0.42    0.6777   -0.383187    0.586883
Abdomen        1.07469    0.115819    9.28    <1e-14    0.844791    1.30459
─────────────────────────────────────────────────────────────────────────────
=#


## 4. results 
#= 
  在三个预测变量的模型中, Weight, Abdomen 的 pvalue 都非常小, 但是 Height 的 p-value 比较大, 接受系数为 0的假设
  三个变量的模型中, Weight, Abdomen 已经提供了充分的证据来拟合数据
=#