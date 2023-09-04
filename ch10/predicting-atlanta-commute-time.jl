
include("utils.jl")
using HypothesisTests,CSV,DataFrames,Distributions,GLMakie,StatsBase,Pipe
using GLM,AnovaGLM

desc=Lock5Table(700,"CommuteAtlanta","Predicting Atlanta Commute Time",["Distance","Time"])

data=@pipe load_data(desc.name)


nullmodel = lm(@formula(Time ~ 1), data)
model=lm(@formula(Time ~Distance), data)

#= 
    Time ~ 1 + Distance

    Coefficients:
    ───────────────────────────────────────────────────────────────────────
                Coef.  Std. Error      t  Pr(>|t|)  Lower 95%  Upper 95%
    ───────────────────────────────────────────────────────────────────────
    (Intercept)  7.12034   0.906589    7.85    <1e-13    5.33913    8.90155
    Distance     1.21115   0.0397699  30.45    <1e-99    1.13301    1.28929
    ───────────────────────────────────────────────────────────────────────
=#

#predict(model,DataFrame(Distance=[20]))
function plot_res(model)
    res=residuals(model)|>zscore
    fig=Figure(resolution=(700,300))
    ax1=Axis(fig[1,1],xlabel="distance",ylabel="time")
    ax2=Axis(fig[1,2])
    scatter!(ax1,data[!,:Distance],data[!,:Time])
    stem!(ax2,res)
    hlines!(ax2,[0],linestyle=:dot,linewidth=4,color=:red)
    fig
    #save("./imgs/atlanta-commute-time.png",fig)
end

#plot_res(model)

ftest(nullmodel.model,model.model)
#= 
  F-test: 2 models fitted on 500 observations
    ───────────────────────────────────────────────────────────────────────────
        DOF  ΔDOF          SSR          ΔSSR      R²     ΔR²        F*   p(>F)
    ───────────────────────────────────────────────────────────────────────────
    [1]    2        214194.9500                0.0000                          
    [2]    3     1   74832.1263  -139362.8237  0.6506  0.6506  927.4451  <1e-99
    ───────────────────────────────────────────────────────────────────────────
=#