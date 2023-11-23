## describe  six variables

## 1. load package
include("../../utils.jl")
import GLM:coef
## 2. load data

#= 
  ["Group", "CESD1", "CESD21", "CESDDiff", "DASS1", "DASS21", "DASSDiff", "BMI1", "BMI21", "BMIDiff"]
=#
desc=Lock5Table(642,"DietDepression","Predicting One Depression Score from Another?",["CESDDiff","DASSDiff"])
data=@pipe load_csv(desc.name,false)|>select(_,desc.feature)


##  3. lin reg 
model=lm(@formula(DASSDiff~CESDDiff), data)
println(model)

## 4. plot lin reg 
#fig=plot_linreg(data,model)


