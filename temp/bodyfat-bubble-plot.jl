"""
page 185
data :BodyFat
"""

using GLMakie,CSV,DataFrames,GLMakie,LinearAlgebra
using GLM


str="BodyFat"
feature=["Height","Weight","Bodyfat"]
data=@pipe load_data(str)|>select(_,feature)

function plot_bubble()
    fig=Figure()
    ax=Axis(fig[1,1];title="Bubble size: BodyFat",xlabel="$(feature[1])",ylabel="$(feature[2])")
    Box(fig[1,1];color = (:orange,0.1),strokewidth=0.5)
    scatter!(ax,data[!,1],data[!,2],markersize=data[!,3].*2,color=(:blue,0.2),strokewidth=3,strokecolor=:black)
    fig
    #save("Bubble-size-BodyFat.png",fig)
end

plot_bubble()