## 1.  load package
include("../../utils.jl")
using Bootstrap,StatsBase,GLM
##  2. load data
desc=Lock5Table(429,"MustangPrice","ex-5.53",["Miles","Price"])
data =@pipe load_csv(desc.name)|>select(_,desc.feature)

## 3. lm regression
model=lm(@formula(Price~Miles), data)

#= 
    Price ~ 1 + Miles

    Coefficients:
    ─────────────────────────────────────────────────────────────────────────
                    Coef.  Std. Error      t  Pr(>|t|)  Lower 95%  Upper 95%
    ─────────────────────────────────────────────────────────────────────────
    (Intercept)  30.4953     2.44147    12.49    <1e-11  25.4447    35.5459
    Miles        -0.218802   0.0312979  -6.99    <1e-06  -0.283546  -0.154057
    ─────────────────────────────────────────────────────────────────────────
=#

X_test=select(data,:Miles)
y_hat=predict(model, X_test)|>Vector

function plot_linreg()
    fig=Figure()
    ax=Axis(fig[1,1])
    scatter!(ax, eachcol(data)...,markersize=8,color=(:lightgreen,0.8),strokecolor = :black, strokewidth =0.5)
    lines!(X_test.Miles,y_hat;)
    fig
end
#fig=plot_linreg();save("./UnitC/ch05/ex-5.54-linreg.png",fig)

## 4 ust bootstrap sampling estimate stand error

slopes=Vector{Float64}(undef, 1000)

for i in 1:1000
    local idx=rand(1:25,100)
    local rand_data=data[idx,:]
    local model=lm(@formula(Price~Miles),rand_data)
    slopes[i]=coef(model)[2]
    
end

"slope_standerror"=>std(slopes)

