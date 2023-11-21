#= 
  lock5stat page 597
  Incentives to Exercise
=#

## 1. load package
include("../../utils.jl")

## data 
table = NamedArray([70 30.0 32.0;70 35.0 29.9;70 36.0 29.4;71 45.0 30.1;281 36.5 30.6865], ( ["Prais","Lottery","Get Money","Lose Money","Overall"], ["sample size", "mean","St.Dev"] ),("Condition","Stat"))
#= 
5×3 Named Matrix{Float64}
Condition ╲ Stat │ sample size         mean       St.Dev
─────────────────┼──────────────────────────────────────
Prais            │        70.0         30.0         32.0
Lottery          │        70.0         35.0         29.9
Get Money        │        70.0         36.0         29.4
Lose Money       │        71.0         45.0         30.1
Overall          │       281.0         36.5      30.6865
=#

