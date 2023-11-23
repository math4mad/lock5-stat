"""
chapter:
page 663  Ex 10.23-27
data:ForestFires

"""


## 1. load package

include("../../utils.jl")


## 2. load data

desc=Lock5Table(663,"ForestFires","predict fire burn  area",["Wind","Temp","RH","Rain","Area"])
df=@pipe load_csv(desc.name)
data=select(df,desc.feature)

## 3. lin reg
model=lm(@formula(Area ~Wind+Temp+RH+Rain), data)
#= 
Area ~ 1 + Wind + Temp + RH + Rain

Coefficients:
──────────────────────────────────────────────────────────────────────────
                 Coef.  Std. Error      t  Pr(>|t|)   Lower 95%  Upper 95%
──────────────────────────────────────────────────────────────────────────
(Intercept)  -6.43849    20.1588    -0.32    0.7496  -46.0426    33.1656
Wind          1.27871     1.61244    0.79    0.4281   -1.8891     4.44652
Temp          1.0096      0.589477   1.71    0.0874   -0.148491   2.16769
RH           -0.109754    0.20497   -0.54    0.5926   -0.51244    0.292933
Rain         -2.83022     9.63713   -0.29    0.7691  -21.7634    16.103
──────────────────────────────────────────────────────────────────────────
=#

## 4 anova 
anova(model)

#= 
Analysis of Variance

Type 1 test / F test

Area ~ 1 + Wind + Temp + RH + Rain

Table:
────────────────────────────────────────────────────────────
             DOF      Exp.SS  Mean Square  F value  Pr(>|F|)
────────────────────────────────────────────────────────────
(Intercept)    1    85332.36     85332.36  21.1426    <1e-05
Wind           1      317.22       317.22   0.0786    0.7793
Temp           1    22329.59     22329.59   5.5326    0.0190
RH             1     1417.66      1417.66   0.3512    0.5537
Rain           1      348.10       348.10   0.0862    0.7691
(Residuals)  512  2066452.06      4036.04             
────────────────────────────────────────────────────────────
=#

