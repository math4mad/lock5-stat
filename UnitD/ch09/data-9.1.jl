
## 1. load package
include("../../utils.jl")

## 2. load data
desc=Lock5Table(617,"InkjetPrinters","predict laserjet printer price",[:PPM,:Price])
data= @pipe load_csv(desc.name)|>select(_,desc.feature)
#@pt first(data,10)
#= 
┌─────────┬───────┐
│     PPM │ Price │
│ Float64 │ Int64 │
├─────────┼───────┤
│     3.9 │   300 │
│     2.9 │   199 │
│     2.7 │    79 │
│     2.9 │   129 │
│     2.4 │    70 │
│     4.1 │   348 │
│    ⋮    │   ⋮   │
└─────────┴───────┘
=#

