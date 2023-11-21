
# 1. load package
include("../../utils.jl")


## load data

desc=Lock5Table(453,"CollegeScores4yr","College SAT Samples",["AvgSAT"])

data=@pipe load_csv(desc.name)|>select(_,desc.feature)
xs=range(extrema(data.AvgSAT)...,200)
dist=Normal(1135,130)
#= 
┌────────┐
│ AvgSAT │
│  Int64 │
├────────┤
│    929 │
│   1195 │
│   1322 │
│    935 │
│   1278 │
│   1083 │
│   1282 │
│   1231 │
│   1031 │
│   ⋮    │
└────────┘
=#
h=fit(Histogram,data.AvgSAT,nbins=50)
function plot_res()
    fig=Figure()
    ax=Axis(fig[1,1])
    plot_dotplot(h,ax)
    fig
end

#fig=plot_res()#;save("./UnitC/ch06/ex-6.85.png",fig)
#lines(xs,pdf.(dist,xs))