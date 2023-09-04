"""
lock5 stat page 56

数据中随着时间(以年为单位)进展, 汽车数量与寿命成正相关. 

潜在的变量就是时间, 随着时间变化,经济变化, 汽车保有量增加, 医疗条件改善, 寿命增加
所以时间可以解释两个变量的相关性
"""


include("utils.jl")
using HypothesisTests,GLMakie,CSV,DataFrames,ScientificTypes
using Statistics

df= (let str="LifeExpectancyVehicles"
    df=load_data(str)
end)

function plot_df()
    fig=Figure()
    ax=Axis(fig[1,1],xlabel="Vehicles(millions) ",ylabel="LifeExpectancy")
    scatter!(ax,df[!,:Vehicles ],df[!,:LifeExpectancy],marker=:circle,markersize=16,color=(:lightgreen,0.1),strokewidth=2,strokecolor=:black)
    fig
    #save("./imgs/life-expectancy-vehicles.png",fig)
end

plot_df()
