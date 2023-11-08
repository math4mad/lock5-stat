include("../utils.jl")
using StatsBase,GLMakie
## 2. load data
#= 
 ["ID", "Age", "Smoke", "Quetelet", "Vitamin", "Calories", "Fat", "Fiber", "Alcohol", "Cholesterol", "BetaDiet", "RetinolDiet", "BetaPlasma", "RetinolPlasma", "Sex", "VitaminUse", "PriorSmoke"]
=#
desc = Lock5Table(227, "NutritionStudy", "FatandFiberandCalories", ["Calories", "Fat", "Fiber"])
df = @pipe load_csv(desc.name)|>select(_,desc.feature)
@pt first(df,5)
#= 
┌──────────┬─────────┬─────────┐
│ Calories │     Fat │   Fiber │
│  Float64 │ Float64 │ Float64 │
├──────────┼─────────┼─────────┤
│   1298.8 │    57.0 │     6.3 │
│   1032.5 │    50.1 │    15.8 │
│   2372.3 │    83.6 │    19.1 │
│   2449.5 │    97.5 │    26.5 │
│   1952.1 │    82.6 │    16.2 │
└──────────┴─────────┴─────────┘
=#

## 3. "Calories", "Fat" cor
    df1=select(df,[:Fat,:Calories])
    df2=select(df,[:Fiber,:Calories])
    plot_pair_cor(df1,true)
    plot_pair_cor(df2,true)
    @info "Calories-Fat-Cor"=>pair_corletation(df1)
    # [ Info: "Calories-Fat-Cor" => 0.87
    @info "Calories-Fiber-Cor"=>pair_corletation(df2)
    # [ Info: "Calories-Fiber-Cor" => 0.47



