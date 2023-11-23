"""
chapter:
page 659  Example 10.6
data:InkjetPrinters  one variables -> two variables

"""


## 1. load package

include("../../utils.jl")


## 2. load data

desc=Lock5Table(655,"InkjetPrinters","mutliple regression ",["PPM","CostBW","Price"])
df=@pipe load_csv(desc.name)
data=select(df,desc.feature)


## 3. lin reg
model1=lm(@formula(Price ~ PPM), data)
model2=lm(@formula(Price ~ PPM+CostBW), data)

## 4 anvoa table  
anova(model1)
#= 
Analysis of Variance

Type 1 test / F test

Price ~ 1 + PPM

Table:
────────────────────────────────────────────────────────────
             DOF     Exp.SS  Mean Square   F value  Pr(>|F|)
────────────────────────────────────────────────────────────
(Intercept)    1  522291.20    522291.20  152.3781    <1e-09
PPM            1   74540.01     74540.01   21.7470    0.0002
(Residuals)   18   61696.79      3427.60              
────────────────────────────────────────────────────────────
=#

anova(model2)

#= 
Analysis of Variance

Type 1 test / F test

Price ~ 1 + PPM + CostBW

Table:
────────────────────────────────────────────────────────────
             DOF     Exp.SS  Mean Square   F value  Pr(>|F|)
────────────────────────────────────────────────────────────
(Intercept)    1  522291.20    522291.20  187.2117    <1e-09
PPM            1   74540.01     74540.01   26.7184    <1e-04
CostBW         1   14269.48     14269.48    5.1148    0.0371
(Residuals)   17   47427.31      2789.84              
────────────────────────────────────────────────────────────
=#

## 5 results
#= 
  sse  61696.79  =>47427.31 
=#