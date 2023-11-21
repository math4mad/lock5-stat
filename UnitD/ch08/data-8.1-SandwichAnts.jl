## 1. load package
include("../../utils.jl")
 ## 3. load data
  desc=Lock5Table(580,"SandwichAnts","taste of ants ",["Butter", "Filling", "Bread", "Ants", "Order"])
  df=@pipe load_csv(desc.name,false);
  #@pt df

#= 
┌─────────┬───────────────┬────────────┬───────┬───────┐
│  Butter │       Filling │      Bread │  Ants │ Order │
│ String3 │      String15 │   String15 │ Int64 │ Int64 │
├─────────┼───────────────┼────────────┼───────┼───────┤
│      no │      Vegemite │        Rye │    18 │    10 │
│      no │ Peanut Butter │        Rye │    43 │    26 │
│      no │ Ham & Pickles │        Rye │    44 │    39 │
│      no │      Vegemite │  Wholemeal │    29 │    25 │
│      no │ Peanut Butter │  Wholemeal │    59 │    35 │
│      no │ Ham & Pickles │  Wholemeal │    34 │     1 │
│      no │      Vegemite │ Multigrain │    42 │    44 │
│      no │ Peanut Butter │ Multigrain │    22 │    36 │
│      no │ Ham & Pickles │ Multigrain │    36 │    32 │
│      no │      Vegemite │      White │    42 │    33 │
│    ⋮    │       ⋮       │     ⋮      │   ⋮   │   ⋮   │
└─────────┴───────────────┴────────────┴───────┴───────┘
  =#