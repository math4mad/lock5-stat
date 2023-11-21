## 1. load package
include("../../utils.jl")

## 2.  load data
desc=Lock5Table(546,"APMultipleChoice","multichoice-answer",[])
df=@pipe load_csv(desc.name)
ft=freqtable(df,:Answer)
#= 
5-element Named Vector{Int64}
Answer  │ 
────────┼───
A       │ 85
B       │ 90
C       │ 79
D       │ 78
E       │ 68
=#
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





