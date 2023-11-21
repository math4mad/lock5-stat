## 1. load package
include("../../utils.jl")
include("data-7.1.jl")


## 2. frequency
probs=prop(ft)
#= 
  5-element Named Vector{Float64}
Answer  │ 
────────┼───────
A       │ 0.2125
B       │  0.225
C       │ 0.1975
D       │  0.195
E       │   0.17
=#

## 3.  optimtial  proportion
equal_prop=@pipe Categorical(fill(1/5,5))|>params|>_[1]


