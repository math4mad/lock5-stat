"""
page 159  mecuary-acid linreg
data:FloridaLakes

rmsd=3.966
"""


include("utils.jl")

using GLMakie,CSV,DataFrames
using DataFramesMeta,StatsBase
using GLM,LinearAlgebra


data_str="FloridaLakes"
feature=["pH","AvgMercury"]

data=pair_data(data_str,feature)
#plot_pair_cor(data,true)
#pair_corletation(data)

res=lm(@formula(AvgMercury~pH), data)

xs=range(extrema(data[!,feature[1]])...,50)

function f(x)
    input=[1,x]
    coef(res)'⋅input
end

function plot_raw_data(df::AbstractDataFrame)
    name_arr=names(df)
    fig=Figure()
    
        ax=Axis(fig[1,1],title="$(name_arr[1])-$(name_arr[2])-Cor",xlabel="$(name_arr[1])",ylabel="$(name_arr[2])")
        
        Box(fig[1, 1], color = (:orange,0.05))
        scatter!(ax,df[!,1],df[!,2],markersize=12,color=(:green,0.1),strokewidth=3,strokecolor=:black) 
    return fig,ax
end

fig,ax=plot_raw_data(data)
lines!(ax, xs, f.(xs),label="fitting line",color=(:red,0.8),linewidth=3)
axislegend()
fig


# predict  
f.([59.33,9.52,23.70]).|>d->round(d,digits=2) # [10.52,1.44,4.03]


Acid=data[!,:pH]
rms=@pipe Acid.|>f|>rmsd(_,Acid)|>round(_,digits=3)


function plot_residuals()
    fig,ax,plot=stem(residuals(res))
    ax.title="acid-mercury-linreg-model-residuals"
    save("acid-mercury-linreg-model-residuals.png",fig)
    fig
end
#plot_residuals()

save("acid-mercury-linreg-model.png",fig)

