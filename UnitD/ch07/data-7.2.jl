#= 
lock5stat page 548 
 Alameda County Jury Pools
=#


## 1. load package
include("../../utils.jl")

## 2.  load data
#res= [ "$(i*100)%" for i in [0.54 0.18 0.12 0.15 0.01]]
data = NamedArray([780 117 114 384 58;0.54 0.18 0.12 0.15 0.01], ( ["Number in jury pools", "Census percentage"], ["White","Black","Hispanic","Asian","Other"] ), ("Race", "Statistics"))

