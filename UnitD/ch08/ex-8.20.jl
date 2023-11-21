#= 
  lock5stat page 596
  Laptop Computers and Sperm Count
=#

## 1. load package
include("../../utils.jl")

## data 
table = NamedArray([29 2.31 0.96;29 2.18 0.69;29 1.41 0.66], ( ["Leg together","Lap pad","Legs apart"], ["sample size", "mean","St.Dev"] ),("Condition","Stat"))
#= 
3×3 Named Matrix{Float64}
Condition ╲ Stat │ sample size         mean       St.Dev
─────────────────┼──────────────────────────────────────
Leg together     │        29.0         2.31         0.96
Lap pad          │        29.0         2.18         0.69
Legs apart       │        29.0         1.41         0.66
=#


