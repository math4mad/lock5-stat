# 1. load package
include("../../utils.jl")


## 2. load data

desc=Lock5Table(460,"PASeniors","ComputerTime",["ComputerHours"])


data=@pipe load_csv(desc.name)|>select(_,desc.feature)

n_boot = 1000;cil = 0.95;
bs1 = bootstrap(mean, data.ComputerHours, BasicSampling(n_boot))
bci1 = confint(bs1, BasicConfInt(cil))  
#  ((16.88821752265861, 15.01333081570997, 18.871714501510574),)



