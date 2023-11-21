## 1.  load package
#include("../../utils.jl")
using Bootstrap,StatsBase
##  2. load data
desc=Lock5Table(423,"CommuteAtlanta","example5.16",["Time"])
data =@pipe load_csv(desc.name)

##  3. bootstrap sampling

### 3.1 define function 
n_boot = 1000;cil = 0.95;
bs(data::AbstractDataFrame) = bootstrap(mean, data.Time, BasicSampling(n_boot))
 #bci1 = confint(bs1, BasicConfInt(cil))

### 3.2 get data bins 
 h=@pipe bs(data)|>_.t1[1]|>fit(Histogram,_,nbins=60)
 
### 3.3 plot
 fig=plot_dotplot(h) #;save("example-5-10-CommuteAtlanta-time-60bins.png",fig)