
## 1. load package
include("./data.jl")
using GLM,GLMakie,StatsBase
##  2. load data
data=select(data,[:Bill,:PctTip])

## linear regression

model=lm(@formula(PctTip ~ Bill), data)




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

fig=plot_res();save("restaurant-bill-pacttip-lin-reg.png",fig)