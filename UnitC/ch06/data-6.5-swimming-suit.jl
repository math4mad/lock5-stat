

## 1. load package
include("../../utils.jl")
using UnicodePlots

## 2. data processing
    desc=Lock5Table(502,"Wetsuits","more fast with wetsuit?",["Wetsuit", "NoWetsuit", "Gender", "Type"])
    df= @pipe load_csv(desc.name,false)|>select(_,desc.feature[1:2])|>permutedims
    #@pt df 
#= 
┌─────────┬─────────┬─────────┬─────────┬─────────┬─────────┬─────────┬─────────┬─────────┬─────────┬─────────┬─────────┐
│      x1 │      x2 │      x3 │      x4 │      x5 │      x6 │      x7 │      x8 │      x9 │     x10 │     x11 │     x12 │
│ Float64 │ Float64 │ Float64 │ Float64 │ Float64 │ Float64 │ Float64 │ Float64 │ Float64 │ Float64 │ Float64 │ Float64 │
├─────────┼─────────┼─────────┼─────────┼─────────┼─────────┼─────────┼─────────┼─────────┼─────────┼─────────┼─────────┤
│    1.57 │    1.47 │    1.42 │    1.35 │    1.22 │    1.75 │    1.64 │    1.57 │    1.56 │    1.53 │    1.49 │    1.51 │
│    1.49 │    1.37 │    1.35 │    1.27 │    1.12 │    1.64 │    1.59 │    1.52 │     1.5 │    1.45 │    1.44 │    1.41 │
└─────────┴─────────┴─────────┴─────────┴─────────┴─────────┴─────────┴─────────┴─────────┴─────────┴─────────┴─────────┘
=#

   data = [df[1,:]|>Vector,df[2,:]|>Vector]
   cats=["wetsuits","no-wetsuits"]
   summary_df = DataFrame(Group=cats,
    n=size.(data, 1),
    Mean=mean.(data),
    Stddev=std.(data)
    )
    @pt summary_df    
#= 
    ┌─────────────┬───────┬─────────┬──────────┐
    │       Group │     n │    Mean │   Stddev │
    │      String │ Int64 │ Float64 │  Float64 │
    ├─────────────┼───────┼─────────┼──────────┤
    │    wetsuits │    12 │ 1.50667 │ 0.136271 │
    │ no-wetsuits │    12 │ 1.42917 │ 0.141065 │
    └─────────────┴───────┴─────────┴──────────┘
=#

## 4. box plot
UnicodePlots.boxplot(cats, data, title="different speed", xlabel="speed", ylabel="group")
#= 
   different speed              
                     ┌                                        ┐ 
                            ╷            ┌───┬──┐         ╷     
            wetsuits        ├────────────┤   │  ├─────────┤     
   group                    ╵            └───┴──┘         ╵     
                      ╷             ┌────┬──┐       ╷           
         no-wetsuits  ├─────────────┤    │  ├───────┤           
                      ╵             └────┴──┘       ╵           
                     └                                        ┘ 
                      1.1              1.45                1.8  
                                        speed      
=#




