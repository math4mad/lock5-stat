# 1. load package
include("../../utils.jl")


## 2. load data

desc=Lock5Table(460,"StudentSurvey","TVTime",["TV"])
data=@pipe load_csv(desc.name)|>select(_,desc.feature)

## 3 bootstrap confidence interval  0.99
n_boot = 1000;cil = 0.99;
bs1 = bootstrap(mean, data.TV, BasicSampling(n_boot))
bci1 = confint(bs1, BasicConfInt(cil))
# ((6.615384615384615, 5.827630769230769, 7.3786461538461525),)








