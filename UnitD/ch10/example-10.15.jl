"""
lock5stat page 682
data: BodyFat

"""

## 1. load package
include("../../utils.jl")

## 2. load data
desc=Lock5Table(682,"BodyFat","[Weight,Abdomen,Wrist] predict BodyFat",["Age","Weight","Abdomen","Wrist","Bodyfat"])
data=@pipe load_csv(desc.name)|>select(_,desc.feature)

## 3. linreg
model_no_age=lm(@formula(Bodyfat ~ Weight+Abdomen+Wrist), data)

#= 
Bodyfat ~ 1 + Weight + Abdomen + Wrist

Coefficients:
────────────────────────────────────────────────────────────────────────────
                  Coef.  Std. Error      t  Pr(>|t|)   Lower 95%   Upper 95%
────────────────────────────────────────────────────────────────────────────
(Intercept)  -28.7531     9.49382    -3.03    0.0032  -47.5982    -9.90805
Weight        -0.123597   0.0342512  -3.61    0.0005   -0.191585  -0.0556089
Abdomen        1.04495    0.087201   11.98    <1e-20    0.871853   1.21804
Wrist         -1.46586    0.627219   -2.34    0.0215   -2.71088   -0.220836
────────────────────────────────────────────────────────────────────────────
=#

model_with_age=lm(@formula(Bodyfat ~ Age+Weight+Abdomen+Wrist), data)
#= 
Bodyfat ~ 1 + Age + Weight + Abdomen + Wrist

Coefficients:
──────────────────────────────────────────────────────────────────────────────
                   Coef.  Std. Error      t  Pr(>|t|)    Lower 95%   Upper 95%
──────────────────────────────────────────────────────────────────────────────
(Intercept)  -21.0611     10.5281     -2.00    0.0483  -41.9621     -0.16007
Age            0.0785373   0.048152    1.63    0.1062   -0.0170565   0.174131
Weight        -0.0760825   0.0447421  -1.70    0.0923   -0.164907    0.0127418
Abdomen        0.950692    0.103991    9.14    <1e-13    0.744244    1.15714
Wrist         -2.06898     0.723503   -2.86    0.0052   -3.50532    -0.63265
──────────────────────────────────────────────────────────────────────────────
=#

("model-no-age-r2"=>r2(model_no_age),"model-with-age-r2"=>r2(model_with_age))


## nest model
#nestlm=nestedmodels(LinearModel, @formula(Bodyfat ~ Age*Weight*Abdomen*Wrist),data; dropcollinear = false)

ftest(model_no_age.model,model_with_age.model)

#= 
F-test: 2 models fitted on 100 observations
───────────────────────────────────────────────────────────────────
     DOF  ΔDOF        SSR      ΔSSR      R²     ΔR²      F*   p(>F)
───────────────────────────────────────────────────────────────────
[1]    5        1604.7380            0.7471                        
[2]    6     1  1561.0252  -43.7129  0.7540  0.0069  2.6603  0.1062
───────────────────────────────────────────────────────────────────
=#

