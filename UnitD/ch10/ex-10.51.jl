"""
chapter:10
page 668  10.51 predict  text senting
data:PASeniors

"""


## 1 load package
include("../../utils.jl")
import GLM: coef, predict,confint

## 2. load data
desc = Lock5Table(668, "PASeniors", "predict text senting", ["HangHours","ComputerHours", "Occupants","TextsSent"])
data = @pipe load_csv(desc.name,false)|>select(_,desc.feature)

## 3. lin reg 
model = lm(@formula(TextsSent~ HangHours*ComputerHours*Occupants),data)
#= 
TextsSent ~ 1 + HangHours + ComputerHours + Occupants

Coefficients:
──────────────────────────────────────────────────────────────────────────
                   Coef.  Std. Error     t  Pr(>|t|)  Lower 95%  Upper 95%
──────────────────────────────────────────────────────────────────────────
(Intercept)    63.1015     15.7136    4.02    <1e-04  32.2172    93.9857
HangHours       1.03593     0.539478  1.92    0.0555  -0.024382   2.09625
ComputerHours   0.118062    0.329311  0.36    0.7201  -0.529181   0.765305
Occupants       0.312106    2.89671   0.11    0.9142  -5.38121    6.00542
──────────────────────────────────────────────────────────────────────────
=#

## 4. anova 
anova(model)
#= 
Analysis of Variance

Type 1 test / F test

TextsSent ~ 1 + HangHours + ComputerHours + Occupants

Table:
───────────────────────────────────────────────────────────────
               DOF      Exp.SS  Mean Square   F value  Pr(>|F|)
───────────────────────────────────────────────────────────────
(Intercept)      1  2665104.01   2665104.01  188.2576    <1e-35
HangHours        1    55799.43     55799.43    3.9416    0.0477
ComputerHours    1     1779.08      1779.08    0.1257    0.7231
Occupants        1      164.35       164.35    0.0116    0.9142
(Residuals)    434  6144003.14     14156.69              
───────────────────────────────────────────────────────────────
=#

