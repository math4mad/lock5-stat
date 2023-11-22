## 1. load package
include("../../utils.jl")

## 2. load data

desc = Lock5Table(620, "RestaurantTips", "Bill-PctTip-linreg", ["Bill","PctTip"])
data = @pipe load_csv(desc.name)|>select(_,desc.feature)

## 3. lin reg
model=lm(@formula(PctTip~Bill), data)
#= 
PctTip ~ 1 + Bill

Coefficients:
───────────────────────────────────────────────────────────────────────────
                  Coef.  Std. Error      t  Pr(>|t|)   Lower 95%  Upper 95%
───────────────────────────────────────────────────────────────────────────
(Intercept)  15.5096       0.739558  20.97    <1e-46  14.0487      16.9706
Bill          0.0488124    0.028712   1.70    0.0911  -0.0079048    0.10553
───────────────────────────────────────────────────────────────────────────


=#

