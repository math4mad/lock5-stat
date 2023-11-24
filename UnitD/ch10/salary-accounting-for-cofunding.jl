#= 
 lock5stat page 685  discussiong  freqtable
=#

## 1. load package
include("../../utils.jl")

## 2. load  data 
desc=Lock5Table(684,"SalaryGender","Gender Discrimination among College Teachers?",["PhD","Gender","Salary"])
data=@pipe load_csv(desc.name)|>select(_,desc.feature)

ft=freqtable(data,:PhD,:Gender)

#= 
 2×2 Named Matrix{Int64}
PhD ╲ Gender │  0   1
─────────────┼───────
0            │ 35  26
1            │ 15  24

=#

