"""
https://jbytecode.github.io/LinRegOutliers/dev/
"""


include("utils.jl")

using GLMakie,CSV,DataFrames
using DataFramesMeta,StatsBase
using GLM,LinearAlgebra
import  LinRegOutliers:wls
using LinRegOutliers


data_str="FloridaLakes"
feature=["pH","AvgMercury"]

data=pair_data(data_str,feature)
#plot_pair_cor(data,true)
#pair_corletation(data)
#res=lm(@formula(AvgMercury~pH), data)

#w = ones(size(data,1))
#wls(select(data,1:1)|>Matrix,data[!,2]|>Array,w)


reg = createRegressionSetting(@formula(AvgMercury~pH), data)
extra=smr98(reg)
function f(x)
    input=[1,x]
    extra["betas"]'⋅input
end
xs=range(extrema(data[!,feature[1]])...,50)

#plot_pair_cor(data)
idx=extra["outliers"]
outliers_data=data[idx,:]


function plot_outliers(df)
    name_arr=names(df)
    fig=Figure()
    ax=Axis(fig[1,1],title="linreg-outliers-detection",xlabel="$(name_arr[1])",ylabel="$(name_arr[2])")
    scatter!(ax,outliers_data[:,1],outliers_data[:,2],markersize=18,color=(:red,0.3),strokewidth=2,strokecolor=:black,label="detection-outliers")
    scatter!(ax,data[:,1],data[:,2],color=(:green,0.3))
    lines!(ax, xs, f.(xs),label="fitting line",color=(:red,0.8),linewidth=2)
    axislegend()
    fig
    #save("acid-mercury-linreg-outliers-detection-2.png",fig)
end

plot_outliers(data)

