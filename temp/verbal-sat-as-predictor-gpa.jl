

include("utils.jl")
using CSV,DataFrames,Distributions,GLMakie,LinearAlgebra
using GLM

df= (let str="StudentSurvey"
    df=load_data(str)
    
end)

data=select(df,[:VerbalSAT,:GPA])

res=lm(@formula(GPA~VerbalSAT), data)

xs=range(extrema(data[!,1])...,50)

function f(x)
    input=[1,x]
    coef(res)'⋅input
end

function plot_reg_data()
    fig=Figure()
    ax=Axis(fig[1,1],xlabel="Verbal-SAT",ylabel="GPA",title="GPA-linearreg")
    scatter!(ax,data[!,1],data[!,2];markersize=12,color=(:lightgreen,0.2),
    strokecolor = :black, strokewidth =2)
    lines!(ax, xs, f.(xs),label="fitting line")
    axislegend()
    save("./imgs/Verbal-SAT-GPA-linearreg.png",fig)
    fig
end

#plot_reg_data()
ftest(res.model)