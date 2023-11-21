## 1.  load package
include("../../utils.jl")
using Bootstrap,StatsBase
##  2. load data
desc=Lock5Table(428,"MustangPrice","ex-5.53",["Age","Miles","Price"])
data =@pipe load_csv(desc.name)

##  3. bootstrap sampling

### 3.1 define function 
n_boot = 1000;cil = 0.95;
bs=boot_sampling(data.Price)
 
#= 
 Bootstrap Sampling
  Estimates:
     Var │ Estimate  Bias       StdError
         │ Float64   Float64    Float64
    ─────┼───────────────────────────────
       1 │    15.98  -0.072784     2.117
  Sampling: BasicSampling
  Samples:  1000
  Data:     Vector{Float64}: { 25 }
=#

### 3.2  confidence  interval
bci1 = confint(bs, BasicConfInt(cil)) #((15.979999999999997, 11.169599999999996, 20.132699999999993),)

### 3.3 get bootstrap mean  std
 res =@pipe bs|>_.t1[1]|>mean_and_std
 dist=Normal(res...)
 quantile(dist,0.025),quantile(dist,0.975)
 
 
