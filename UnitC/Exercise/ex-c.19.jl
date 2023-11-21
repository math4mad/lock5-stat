#= 
  lock5stat page 521
=#

## 1. load package
include("../../utils.jl")

## 2. data 
data = NamedArray([51 29.4  14.5  ; 106 19.5 9.4], ( ["Yes", "No"], ["n","Mean","Std.Dev"] ), ("Credit?", "Statistics"))

