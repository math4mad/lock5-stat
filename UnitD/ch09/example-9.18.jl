## 1. load package
include("../../utils.jl")

## 2. load data

desc = Lock5Table(647, "InkjetPrinters", "InkjetPrinters", ["PPM", "Price"])
data = @pipe load_csv(desc.name)|>select(_,desc.feature)

## 3. line reg  

model=lm(@formula(Price~PPM), data)
#= 
Price ~ 1 + PPM

Coefficients:
────────────────────────────────────────────────────────────────────────
                Coef.  Std. Error      t  Pr(>|t|)  Lower 95%  Upper 95%
────────────────────────────────────────────────────────────────────────
(Intercept)  -94.2218     56.3981  -1.67    0.1121   -212.71     24.2663
PPM           90.8781     19.4876   4.66    0.0002     49.936   131.82
────────────────────────────────────────────────────────────────────────
=#
ci=confint(model)
x_test=DataFrame(PPM=[3.0])

#y_hat=predict(model,x_test;inverval=:prediction,level=0.95)
#ci_yhat=(y_hat-ci[1],y_hat+ci[2])


function plot_confidence()
    fig=Figure()
    ax=Axis(fig[1,1])
    scatter!(ax,eachcol(data)...;marker='o',markersize=14)
    ablines!(ax,coef(model)...)

   
    fig
end

plot_confidence()




