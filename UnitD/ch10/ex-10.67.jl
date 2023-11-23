"""
chapter:10
page 677  10.67 More on Height and Weight
data:StudentSurvey

"""


## 1 load package
include("../../utils.jl")
import GLM: coef, predict,confint

## 2. load data
desc = Lock5Table(677, "StudentSurvey", "Predicting Height with Weight", ["Height","Weight"])
data = @pipe load_csv(desc.name,true)|>select(_,desc.feature)

## 3. lin reg 
model = lm(@formula(Weight~Height),data)


## 4. plot residuals
plot_linreg_residuals(model, data)




