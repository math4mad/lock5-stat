"""
chapter:
page 650  9.75 Life Expectancy
data:SampCountries

"""


## 1 load package
include("../../utils.jl")
import GLM: coef, predict,confint

## 2. load data
desc = Lock5Table(650, "SampCountries", "Expenditure-LifeExpectancy-LinReg", ["Health", "LifeExpectancy"])

df = @pipe load_csv(desc.name)|>select(_,desc.feature)


## 3. lin reg
model = lm(@formula(LifeExpectancy~ Health), df)

#= 
LifeExpectancy ~ 1 + Health

Coefficients:
─────────────────────────────────────────────────────────────────────────
                 Coef.  Std. Error      t  Pr(>|t|)  Lower 95%  Upper 95%
─────────────────────────────────────────────────────────────────────────
(Intercept)  64.1748      2.15969   29.71    <1e-31  59.8325     68.5172
Health        0.811498    0.191857   4.23    0.0001   0.425745    1.19725
─────────────────────────────────────────────────────────────────────────
=#

x_test=DataFrame(Health=[3,10,50])

y_hat=predict(model,x_test)


ci=confint(model)

function plot_confidence(desc::Lock5Table)
    fig=Figure()
    ax=Axis(fig[1,1])
    ax.title=desc.question
    scatter!(ax,eachcol(df)...;marker='o',markersize=14,label="raw data")
    ablines!(ax,coef(model)...;linewidth=2,label="fit line")
    ablines!(ax, ci[:,1]...;linestyle=:dot,linewidth=2,label="lower bounds")
    ablines!(ax, ci[:,2]...;linestyle=:dashdot,linewidth=2,label="upper bounds")
    #scatter!(ax, x_test,y_hat;marker='o',markersize=14,color=:red,label="predict data")
    axislegend(ax;position=:rb)
    fig
end

fig=plot_confidence(desc)#;save("UnitD/ch09/imgs/ex-9.75-$(desc.question).png",fig)



