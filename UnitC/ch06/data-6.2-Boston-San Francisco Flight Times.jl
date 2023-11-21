# 1. load package
include("../../utils.jl")


## 2. load data

desc=Lock5Table(456,"Flight433","Boston/San Francisco Flight Times",["AirTime"])

data=@pipe load_csv(desc.name)

## 3.  bootstrap bci

  n_boot = 1000;cil = 0.95

  ## basic bootstrap
  bs1 = bootstrap(mean, data.AirTime, BasicSampling(n_boot))
  ## basic CI
  bci1 = confint(bs1, BasicConfInt(cil)) #((371.10714285714283, 364.85714285714283, 377.2508928571428),)

## 4. dotplot
  h=fit(Histogram,data.AirTime,nbins=20)
  #fig=plot_dotplot(h)#;save("UnitC/ch06/data-6.2-Boston-San Francisco Flight Times.png",fig)


  