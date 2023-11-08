## 1. load package 
include("../../utils.jl")
using GLMakie, GLM
## 2. load data
desc = Lock5Table(205, "SleepStudy", "Sleep Quality and DAS Score", ["DASScore", "PoorSleepQuality"])
df = @pipe load_csv(desc.name) |> select(_, desc.feature)

## 3. linear regression
model = lm(@formula(PoorSleepQuality ~ DASScore), df)
xs = range(extrema(data[!, desc.feature[1]])..., 100)
yhat = @pipe predict(model, DataFrame(DASScore=xs)) |> round.(_, digits=4)

## 4. plot results

function plot_res()
    fig = Figure()
    ax = Axis(fig[1, 1]; title="Sleep Quality and DAS Score")
    ax.xlabel = "DASScore"
    ax.ylabel = "PoorSleepQuality"
    Box(fig[1,1];color = (:lightyellow,0.3),strokewidth=0.5)
    scatter!(ax, eachcol(df)..., markersize=10, color=(:green, 0.2), strokecolor=:black, strokewidth=1)
    lines!(xs, yhat, label="fit line", color=:blue, linewidth=2)
    axislegend(ax)
    fig
end
#fig=plot_res();save("./UnitA/CaseStudy/imgs/DASScore-PoorSleepQuality-linereg.png",fig)
