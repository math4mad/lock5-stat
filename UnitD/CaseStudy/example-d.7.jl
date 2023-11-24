## 1 load package
include("../../utils.jl")
import GLM: coef, predict,confint,ftest

## 2. load data
include("sleepstudy_data.jl")

df=@pipe select(data,["DASScore", "PoorSleepQuality"])


## linreg  
model = lm(@formula(PoorSleepQuality~DASScore),data)

x_test=DataFrame(DASScore=[40])
y_hat=predict(model,x_test;interval=:confidence,level=0.95)

#= 
1×3 DataFrame
 Row │ prediction  lower     upper    
     │ Float64?    Float64?  Float64? 
─────┼────────────────────────────────
   1 │    7.86562   7.35996   8.37127
=#

