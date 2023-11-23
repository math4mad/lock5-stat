"""
lock5stat page 657
BodyFat

"""

## 1. load package
include("../../utils.jl")

## 2. load data
desc=Lock5Table(656,"BodyFat","[Weight,Height] predict BodyFat",["Weight","Height","Bodyfat"])
data=@pipe load_csv(desc.name)

## 3. linreg
model=lm(@formula(Bodyfat ~ Weight+Height), data)

#= 
Bodyfat ~ 1 + Weight + Height

Coefficients:
─────────────────────────────────────────────────────────────────────────
                Coef.  Std. Error      t  Pr(>|t|)  Lower 95%   Upper 95%
─────────────────────────────────────────────────────────────────────────
(Intercept)  71.4825   16.2009      4.41    <1e-04  39.3283    103.637
Weight        0.23156   0.0238201   9.72    <1e-15   0.184283    0.278836
Height       -1.33568   0.258908   -5.16    <1e-05  -1.84955    -0.821824
─────────────────────────────────────────────────────────────────────────
=#

## 4. results
#= 
  Weight,Height 的 p-value 等非常小, 因此有充分证据显示身高和体重对预测体脂都非常有用
=#


