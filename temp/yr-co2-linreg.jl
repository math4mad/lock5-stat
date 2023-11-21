"""
page 169  year-co2-linreg
data:CarbonDioxide

rmsd=3.966
"""


include("utils.jl")

using GLMakie,CSV,DataFrames
using DataFramesMeta,StatsBase
using GLM,LinearAlgebra


data_str="CarbonDioxide"
feature=["Year","C02"]

data=pair_data(data_str,feature)
#plot_pair_cor(data,true)
#pair_corletation(data)

res=lm(@formula(C02~Year), data)

xs=range(extrema(data[!,feature[1]])...,50)

function f(x)
    input=[1,x]
    coef(res)'⋅input
end

function plot_raw_data(df::AbstractDataFrame)
    name_arr=names(df)
    fig=Figure()
    
        ax=Axis(fig[1,1],title="$(name_arr[1])-$(name_arr[2])-COR",xlabel="$(name_arr[1])",ylabel="$(name_arr[2])")
        
        Box(fig[1, 1], color = (:orange,0.05))
        scatter!(ax,df[!,1],df[!,2],markersize=12,color=(:green,0.1),strokewidth=3,strokecolor=:black) 
    return fig,ax
end

fig,ax=plot_raw_data(data)
lines!(ax, xs, f.(xs),label="fitting line",color=(:red,0.8),linewidth=3)
axislegend()
fig

save("year-co2-linreg-model.png",fig)

