

include("$(pwd())/utils.jl")

using GLMakie,CSV,DataFrames,GLM,LinearAlgebra
using DataFramesMeta,Pipe,ColorSchemes


desc=Lock5Table(648,"StudentSurvey","verbal-gpa-linreg",["VerbalSAT","GPA"])

data=@pipe load_data(desc.name)|>select(_,desc.feature)
#plot_pair_cor(data)


res=lm(@formula(GPA~VerbalSAT), data)
xs=range(extrema(data[!,desc.feature[1]])...,50)
function f(x)
    input=[1,x]
    coef(res)'⋅input
end

function plot_reg_data(data,desc)
    fig=Figure()
    ax=Axis(fig[1,1],xlabel=desc.feature[1],ylabel=desc.feature[2],title=desc.question)
    scatter!(ax,data[!,desc.feature[1]],data[!,desc.feature[2]];markersize=12,color=(:lightgreen,0.2),
    strokecolor = :black, strokewidth =2)
    lines!(ax, xs, f.(xs),label="fitting line",linewidth=3,color=:red)
    axislegend()
    #save("$(desc.question).png",fig)
    fig
end
#plot_reg_data(data,desc)