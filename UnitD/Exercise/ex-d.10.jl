#= 
D.9 ANOVA for Regression to Predict Tip from Bill 
=#

## 1.load package
include("../../utils.jl")

## 2. load data 
include("restaurant-tips-data.jl")
data=select(df,:Bill,:Guests,:Tip)

## lin reg 
model = lm(@formula(Tip ~ Bill+Guests), data)

#= 
Tip ~ 1 + Bill + Guests

Coefficients:
──────────────────────────────────────────────────────────────────────────
                  Coef.  Std. Error      t  Pr(>|t|)  Lower 95%  Upper 95%
──────────────────────────────────────────────────────────────────────────
(Intercept)  -0.252354   0.20185     -1.25    0.2131  -0.651106   0.146399
Bill          0.183751   0.00781501  23.51    <1e-52   0.168313   0.199189
Guests       -0.0357095  0.101918    -0.35    0.7265  -0.237047   0.165628
──────────────────────────────────────────────────────────────────────────
=#
@info ftest(model.model)

#= 
┌ Info: 
│ F-test against the null model:
└ F-statistic: 396.74 on 157 observations and 2 degrees of freedom, p-value: <1e-60
=#

anova(model)
#= 
Analysis of Variance

Type 1 test / F test

Tip ~ 1 + Bill + Guests

Table:
─────────────────────────────────────────────────────────────
             DOF     Exp.SS  Mean Square    F value  Pr(>|F|)
─────────────────────────────────────────────────────────────
(Intercept)    1  2326.29      2326.29    2410.8417    <1e-95
Bill           1   765.53       765.53     793.3535    <1e-61
Guests         1     0.1185       0.1185     0.1228    0.7265
(Residuals)  154   148.60         0.9649               
─────────────────────────────────────────────────────────────

=#

