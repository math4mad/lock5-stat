## 1. load package
include("../../utils.jl")

## 2. load data

desc = Lock5Table(159, "RestaurantTips", "Bill-Tip-relation", ["Bill","Tip"])
data = @pipe load_csv(desc.name)|>select(_,desc.feature)

## 3. lin reg
model=lm(@formula(Tip~Bill), data)
#= 
Tip ~ 1 + Bill

Coefficients:
─────────────────────────────────────────────────────────────────────────
                 Coef.  Std. Error      t  Pr(>|t|)  Lower 95%  Upper 95%
─────────────────────────────────────────────────────────────────────────
(Intercept)  -0.292267  0.16616     -1.76    0.0806  -0.620498  0.0359633
Bill          0.182215  0.00645086  28.25    <1e-62   0.169472  0.194958
─────────────────────────────────────────────────────────────────────────
=#
"slope confidence interval"=>confint(model;level=0.90)[2,:]
# "slope confidence interval" => [0.17154021309887796, 0.19288925568745457]


