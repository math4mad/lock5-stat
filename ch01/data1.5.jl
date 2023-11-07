include("../utils.jl")
using Random, DataFrames,Pipe,CSV,PrettyTables,GLMakie,TableTransforms
Random.seed!(343434)

desc=Lock5Table(56,"LifeExpectancyVehicles","Cofounding-Variables",["Year","LifeExpectancy","Vehicles"])

df=@pipe CSV.File("./data/$(desc.name).csv")|>DataFrame

@pt first(df,20)

#= 
┌───────┬────────────────┬──────────┐
│  Year │ LifeExpectancy │ Vehicles │
│ Int64 │        Float64 │  Float64 │
├───────┼────────────────┼──────────┤
│  1970 │           70.8 │    108.4 │
│  1971 │           71.1 │    113.0 │
│  1972 │           71.2 │    118.8 │
│  1973 │           71.4 │    125.7 │
│  1974 │           72.0 │    129.9 │
│  1975 │           72.6 │    132.9 │
│  1976 │           72.9 │    138.5 │
│  1977 │           73.3 │    142.1 │
│  1978 │           73.5 │    148.4 │
│  1979 │           73.9 │    151.9 │
│  1980 │           73.7 │    155.8 │
│  1981 │           74.1 │    158.3 │
│  1982 │           74.5 │    159.6 │
│  1983 │           74.6 │    163.7 │
│  1984 │           74.7 │    166.2 │
│  1985 │           74.7 │    171.7 │
│   ⋮   │       ⋮        │    ⋮     │
└───────┴────────────────┴──────────┘
=#
table=eachcol(df)
data=table|>Scale(2,3, low=0, high=1)

function  plot_res()
    fig=Figure()
    ax=Axis(fig[1,1])
    Box(fig[1,1];color = (:orange,0.1),strokewidth=0.5)
    lines!(ax,data.Year,data.LifeExpectancy;label="$(desc.feature[2])",linewidth=3)
    lines!(ax,data.Year,data.Vehicles;label="$(desc.feature[3])",linewidth=3)
    axislegend(ax)
    fig
end

#fig=plot_res();
#save("./ch01/data1.5-1.png",fig)

function  plot_res2()
    fig=Figure()
    ax=Axis(fig[1,1];xlabel = "LifeExpectancy", ylabel = "Vehicles")
    Box(fig[1,1];color = (:orange,0.1),strokewidth=0.5)
    scatter!(ax,df.LifeExpectancy,df.Vehicles;markersize=12,color=(:lightgreen,0.2),strokecolor = :black, strokewidth =2)
    
    fig
end

fig=plot_res2()
save("./ch01/imgs/data1.5-2.png",fig)






