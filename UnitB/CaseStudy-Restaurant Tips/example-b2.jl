include("./data.jl")
using Bootstrap,StatsBase,Pipe
## tip inteval
    n_boot = 1000;cil = 0.95;
    bs1 = bootstrap(mean, data.Tip, BasicSampling(n_boot))
    bci1 = confint(bs1, BasicConfInt(cil))

## PctTip >15%?
   OneSampleTTest(data.PctTip,15)
#= 
  95% confidence interval: (15.93, 17.31)
  outcome with 95% confidence: reject h_0
=#

## 
## PctTip >20%?
OneSampleTTest(data.PctTip,20)


##  waitress diff
gdf=@pipe select(data,:Server,:PctTip)|>groupby(_,:Server)
data1=rand(gdf[1].PctTip,30)
data2=rand(gdf[2].PctTip,30)
OneSampleTTest(data1,data2)
#= 
  95% confidence interval: (0.7806, 7.553)
  outcome with 95% confidence: reject h_0
  有差异
=#


## Tip>30 por
bci  # ((3.849299363057325, 3.4320191082802545, 4.20995382165605),) 没有超过 30 美元的

