"""
chapter:
page 633  Data-9.2 
data:Cereal
feature:["Name", "Company", "Serving", "Calories", "Fat", "Sodium", "Carbs", "Fiber", "Sugars", "Protein"]

"""


## 1 load package
include("../../utils.jl")


## 2. load data
desc = Lock5Table(633, "Cereal", "Breakfast Cereals", [])
df= @pipe load_csv(desc.name)
#@pt df
#= 
 hide sidebar to see full table in vscode
┌───────────────────────┬─────────┬─────────┬──────────┬─────────┬────────┬───────┬─────────┬─────────┬─────────┐
│                  Name │ Company │ Serving │ Calories │     Fat │ Sodium │ Carbs │   Fiber │  Sugars │ Protein │
│              String31 │ String1 │ Float64 │    Int64 │ Float64 │  Int64 │ Int64 │ Float64 │ Float64 │ Float64 │
├───────────────────────┼─────────┼─────────┼──────────┼─────────┼────────┼───────┼─────────┼─────────┼─────────┤
│            AppleJacks │       K │     1.0 │      117 │     0.6 │    143 │    27 │     0.5 │    15.0 │     1.0 │
│             Boo Berry │       G │     1.0 │      118 │     0.8 │    211 │    27 │     0.1 │    14.0 │     1.0 │
│          Cap'n Crunch │       Q │    0.75 │      144 │     2.1 │    269 │    31 │     1.1 │    16.0 │     1.3 │
│ Cinnamon Toast Crunch │       G │    0.75 │      169 │     4.4 │    408 │    32 │     1.7 │    13.3 │     2.7 │
│          Cocoa Blasts │       Q │     1.0 │      130 │     1.2 │    135 │    29 │     0.8 │    16.0 │     1.0 │
└───────────────────────┴─────────┴─────────┴──────────┴─────────┴────────┴───────┴─────────┴─────────┴─────────┘
=#





