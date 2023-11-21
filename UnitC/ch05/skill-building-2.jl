"""
A 95% confidence interval for a proportion p if the sample has n=100 with p̂ =0.43, and the standard error is SE = 0.05
page 449
"""

using  HypothesisTests

Base.@kwdef struct  Params
   xbar:: Real
   SE:: Real
   n::  Int
   μ₀::  Real=0
end

# 5.36


OneSampleZTest(0.43,0.05,100,0.0)

