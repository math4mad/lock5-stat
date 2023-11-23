"""
chapter:
page 666  10.40 Life Expectancy
data:SampCountries

"""


## 1 load package
include("../../utils.jl")
import GLM: coef, predict,confint

## 2. load data
desc = Lock5Table(666, "SampCountries", "Expenditure-LifeExpectancy-LinReg", ["Health", "Population","Internet","BirthRate","LifeExpectancy"])

data = @pipe load_csv(desc.name,false)|>select(_,desc.feature)


## 3. lin reg
model = lm(@formula(LifeExpectancy ~ Health+Population+Internet+BirthRate), data)

#= 
LifeExpectancy ~ 1 + Health + Population + Internet + BirthRate

Coefficients:
────────────────────────────────────────────────────────────────────────────────
                    Coef.  Std. Error      t  Pr(>|t|)    Lower 95%    Upper 95%
────────────────────────────────────────────────────────────────────────────────
(Intercept)  76.297        3.58059     21.31    <1e-24  69.0853      83.5086
Health        0.141656     0.109917     1.29    0.2041  -0.0797286    0.363041
Population   -0.000306154  0.00239312  -0.13    0.8988  -0.00512615   0.00451384
Internet      0.0711229    0.0316579    2.25    0.0296   0.00736058   0.134885
BirthRate    -0.444507     0.0851611   -5.22    <1e-05  -0.61603     -0.272983
────────────────────────────────────────────────────────────────────────────────
=#


## 4 anova 
anova(model)
#= 
Analysis of Variance

Type 1 test / F test

LifeExpectancy ~ 1 + Health + Population + Internet + BirthRate

Table:
────────────────────────────────────────────────────────────────
             DOF       Exp.SS  Mean Square     F value  Pr(>|F|)
────────────────────────────────────────────────────────────────
(Intercept)    1  262131.44    262131.44    24410.2764    <1e-62
Health         1     784.68       784.68       73.0711    <1e-10
Population     1       6.3393       6.3393      0.5903    0.4463
Internet       1    1323.15      1323.15      123.2148    <1e-13
BirthRate      1     292.56       292.56       27.2442    <1e-05
(Residuals)   45     483.24        10.74                  
────────────────────────────────────────────────────────────────
=#