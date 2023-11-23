"""
chapter:10
page 666  10.50 predict  memory score
data:PASeniors

"""


## 1 load package
include("../../utils.jl")
import GLM: coef, predict,confint

## 2. load data
desc = Lock5Table(668, "PASeniors", "predict memory score", ["ReactionTime","Sleep1", "Sleep2","MemoryScore"])
data = @pipe load_csv(desc.name,false)|>select(_,desc.feature)

## 3. lin reg 
model = lm(@formula(MemoryScore~ ReactionTime+Sleep1+Sleep2),data)

#= 
MemoryScore ~ 1 + ReactionTime + Sleep1 + Sleep2

Coefficients:
───────────────────────────────────────────────────────────────────────────
                  Coef.  Std. Error      t  Pr(>|t|)   Lower 95%  Upper 95%
───────────────────────────────────────────────────────────────────────────
(Intercept)   39.3831      3.83923   10.26    <1e-21  31.8361     46.93
ReactionTime   9.38032     3.86668    2.43    0.0157   1.77944    16.9812
Sleep1         0.790956    0.432533   1.83    0.0682  -0.0592905   1.6412
Sleep2        -0.416834    0.291817  -1.43    0.1539  -0.990471    0.156802
───────────────────────────────────────────────────────────────────────────
=#

