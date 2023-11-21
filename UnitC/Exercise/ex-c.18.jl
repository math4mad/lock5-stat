#= 
  lock5stat page 521
=#

## 1. load package
include("../../utils.jl")

## 2. data 
data = NamedArray([51 17.10  2.47  ; 106 16.39 5.05], ( ["Yes", "No"], ["n","Mean","Std.Dev"] ), ("Credit?", "Statistics"))

#= 
  2×3 Named Matrix{Float64}
Credit? ╲ Statistics │       n     Mean  Std.Dev
─────────────────────┼──────────────────────────
Yes                  │    51.0     17.1     2.47
No                   │   106.0    16.39     5.05
=#

