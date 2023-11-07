## 1. load package
include("utils.jl")
using HypothesisTests,GLMakie,CSV,DataFrames,ScientificTypes
using StatsBase,DataFramesMeta,Pipe

#= 
 feature ["Year", "Candidate", "Approval", "Margin", "Result"]
=#
## 2. data processing
    desc=Lock5Table(139,"ElectionMargin","Presidential Approval Ratings and Re-election",["Approval", "Margin"])
    data= @pipe load_csv(desc.name)|>select(_,desc.feature)
    #@pt data
    #= 
    ┌───────┬────────────┬──────────┬─────────┬─────────┐
    │  Year │  Candidate │ Approval │  Margin │  Result │
    │ Int64 │   String15 │    Int64 │ Float64 │ String7 │
    ├───────┼────────────┼──────────┼─────────┼─────────┤
    │  1940 │  Roosevelt │       62 │    10.0 │     Won │
    │  1948 │     Truman │       50 │     4.5 │     Won │
    │  1956 │ Eisenhower │       70 │    15.4 │     Won │
    │  1964 │    Johnson │       67 │    22.6 │     Won │
    │  1972 │      Nixon │       57 │    23.2 │     Won │
    │  1976 │       Ford │       48 │    -2.1 │    Lost │
    │  1980 │     Carter │       31 │    -9.7 │    Lost │
    │   ⋮   │     ⋮      │    ⋮     │    ⋮    │    ⋮    │
    └───────┴────────────┴──────────┴─────────┴─────────┘
    =#
## 3. plot  coorlations 

   function plot_scatter()
    fig=Figure()
    ax=Axis(fig[1,1],title="coorlation of Approval and  Margin",xlabel="Approval",ylabel="Margin")
    Box(fig[1,1];color = (:lightyellow,0.4),strokewidth=0.5)
    hlines!([0],linestyle=:dash,color=:red,linewidth=2)
    scatter!(ax,eachcol(data)...;markersize=12,color=(:lightgreen,0.2),strokecolor = :black, strokewidth =1)
    fig
   end

   fig=plot_scatter()
   #save("./ch02/imgs/data2.9.png",fig)


## 4. coorlation 
   #cor(eachcol(data)...)  # 0.86




    