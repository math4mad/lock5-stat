include("./init.jl")
using Bootstrap,UnicodePlots

desc=Lock5Table(386,"SkateboardPrices","Skateboard Prices?",["Price"])
data=@pipe load_csv(desc.name)

##  3. question

### 3.1 mean and std
  "mean_std"=>mean_and_std(data.Price)
  # "mean_std" => (67.58649999999999, 50.018024253894296)

### 3.2 bootstrap sampling
   n_boot=1000
   bs(data) = bootstrap(mean,data, BasicSampling(n_boot))
   bs1=bs(data.Price)
   #= 
     Bootstrap Sampling
  Estimates:
     Var │ Estimate  Bias      StdError
         │ Float64   Float64   Float64
    ─────┼──────────────────────────────
       1 │  67.5865  0.085111   11.1013
  Sampling: BasicSampling
  Samples:  1000
  Data:     Vector{Float64}: { 20 }
   =#


### 3.3  frequency

   histogram(bs1.t1[1])

   #= 
     
                  ┌                                        ┐ 
   [ 30.0,  40.0) ┤▎ 1                                       
   [ 40.0,  50.0) ┤███▊ 39                                   
   [ 50.0,  60.0) ┤██████████████████████▎ 225               
   [ 60.0,  70.0) ┤███████████████████████████████████  354  
   [ 70.0,  80.0) ┤█████████████████████████▎ 254            
   [ 80.0,  90.0) ┤██████████▎ 103                           
   [ 90.0, 100.0) ┤██▏ 21                                    
   [100.0, 110.0) ┤▍ 3                                       
                  └                                        ┘ 
                                   Frequency                 
   =#

### 3.4 confidence interval
   cil = 0.95;
   ## basic CI
   bci1 = confint(bs1, BasicConfInt(cil))
   # ((67.58649999999999, 44.37641249999997, 86.66351249999997),)

   