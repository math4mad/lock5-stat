## 1. load package
include("../utils.jl")
  using GLMakie,CSV,DataFrames,Random,StatsBase,PrettyTables,Pipe

##  2. load data
  #= 
    feature :["Butter", "Filling", "Bread", "Ants", "Order"]
  =#
  desc=Lock5Table(281,"SandwichAnts","3.95 Ants on a Sandwich",["Butter", "Filling", "Bread", "Ants", "Order"])
  df=@pipe load_csv(desc.name)
  peanbutter_ants=filter(row -> row.Filling == "Peanut Butter", df)
  #= 
    8×5 DataFrame
    Row │ Butter   Filling        Bread       Ants   Order 
        │ String3  String15       String15    Int64  Int64 
    ─────┼──────────────────────────────────────────────────
    1 │ no       Peanut Butter  Rye            43     26
    2 │ no       Peanut Butter  Wholemeal      59     35
    3 │ no       Peanut Butter  Multigrain     22     36
    4 │ no       Peanut Butter  White          25     34
    5 │ no       Peanut Butter  Rye            36     31
    6 │ no       Peanut Butter  Wholemeal      47     38
    7 │ no       Peanut Butter  Multigrain     19     22
    8 │ no       Peanut Butter  White          21     16
  =#

## 3. Bootstrap sampling workflow
### 3.1  data
    data=peanbutter_ants.Ants
### 3.2 mean and std
    @info "mean_std"=>mean_and_std(data)
    # [ Info: "mean_std" => (34.0, 14.628738838327793)

### 3.3  define function 
    cil = 0.95;n_boot=5000
    """
    bs(data::Vector)
    bootstraping 包装方法
    """
    bs(data::Vector) = bootstrap(mean,data, BasicSampling(n_boot))
### 3.4  bootstrap samping
     bs1=bs(data)
     #= 
       Bootstrap Sampling
        Estimates:
            Var │ Estimate  Bias     StdError
                │ Float64   Float64  Float64
            ─────┼─────────────────────────────
            1 │     34.0  0.10995   4.81507
        Sampling: BasicSampling
        Samples:  5000
        Data:     Vector{Int64}: { 8 }
     =#

### 3.5 confidence
    bci1 = confint(bs1, BasicConfInt(cil))
    # ((34.0, 24.125, 42.75),)
