# 1. load package
include("../../utils.jl")


## 2. load data

desc=Lock5Table(460,"ForestFires","",["Area"])

#= 
 ["X", "Y", "Month", "Day", "FFMC", "DMC", "DC", "ISI", "Temp", "RH", "Wind", "Rain", "Area"]
=#
data=@pipe load_csv(desc.name)|>select(_,desc.feature)

n_boot = 1000;cil = 0.95;
bs1 = bootstrap(mean, data.Area, BasicSampling(n_boot))
bci1 = confint(bs1, BasicConfInt(cil))  

# ((12.847292069632493, 6.8821987427466205, 17.49766441005802),)

