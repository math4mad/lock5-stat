
## 1. load package
    include("./data.jl")
    using GLM,GLMakie,StatsBase
##  2. load data
data=select(data,[:Bill,:Tip])

## linear regression

model=lm(@formula(Tip ~ Bill), data)

#= 
 StatsModels.TableRegressionModel{LinearModel{GLM.LmResp{Vector{Float64}}, GLM.DensePredChol{Float64, LinearAlgebra.CholeskyPivoted{Float64, Matrix{Float64}, Vector{Int64}}}}, Matrix{Float64}}

Tip ~ 1 + Bill

Coefficients:
─────────────────────────────────────────────────────────────────────────
                 Coef.  Std. Error      t  Pr(>|t|)  Lower 95%  Upper 95%
─────────────────────────────────────────────────────────────────────────
(Intercept)  -0.292267  0.16616     -1.76    0.0806  -0.620498  0.0359633
Bill          0.182215  0.00645086  28.25    <1e-62   0.169472  0.194958
─────────────────────────────────────────────────────────────────────────
=#


xs=range(extrema(data.Bill)...,100)
test_X=DataFrame(Bill=xs)
test_y=predict(model, test_X)

function plot_res()
    fig=Figure()
    ax=Axis(fig[1,1])
    Box(fig[1,1];color = (:orange,0.1),strokewidth=0.5)
    scatter!(eachcol(data)...;label="raw data",markersize=10,color=(:lightgreen,0.2),strokecolor = :black, strokewidth =1)
    lines!(xs,test_y;label="fit line")
    axislegend(ax)
    fig
end

fig=plot_res();save("restaurant-bill-tip-lin-reg.png",fig)