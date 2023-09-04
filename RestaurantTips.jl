"""
page 159  饭店老板想知道顾客给小费的模式是什么(顾客的行为)
data:RestaurantTips

pair_corletation(data)=>0.92 小费和账单大小有很强的相关性

lin-reg 
Tip ~ 1 + Bill

Coefficients:
─────────────────────────────────────────────────────────────────────────
                 Coef.  Std. Error      t  Pr(>|t|)  Lower 95%  Upper 95%
─────────────────────────────────────────────────────────────────────────
(Intercept)  -0.292267  0.16616     -1.76    0.0806  -0.620498  0.0359633
Bill          0.182215  0.00645086  28.25    <1e-62   0.169472  0.194958
─────────────────────────────────────────────────────────────────────────

rmsd=3.966
"""


include("utils.jl")

using GLMakie,CSV,DataFrames
using DataFramesMeta,StatsBase
using GLM,LinearAlgebra


data_str="RestaurantTips"
feature=["Bill","Tip"]

data=pair_data(data_str,feature)
#plot_pair_cor(data,true)
#pair_corletation(data)

res=lm(@formula(Tip~Bill), data)

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


Tips=data[!,:Tip]
rms=@pipe Tips.|>f|>rmsd(_,Tips)|>round(_,digits=3)


function plot_residuals()
    fig,ax,plot=stem(residuals(res))
    ax.title="bill-tip-linreg-model-residuals"
    #save("bill-tip-linreg-residuals.png",fig)
    fig
end
#plot_residuals()

