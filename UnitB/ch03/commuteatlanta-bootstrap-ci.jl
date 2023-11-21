"""
bootstrap sampling  
dotplot 根据置信区间选择颜色
"""

include("../../utils.jl")
using GLMakie,CSV,DataFrames,Random,StatsBase,PrettyTables,Pipe,TableTransforms,Bootstrap
using Makie.Colors
desc=Lock5Table(270,"CommuteAtlanta","bootstrap sampling ",[:Distance,:Time])
data=@pipe load_csv(desc.name)|>select(_,desc.feature[2])
mean_and_std(data[:,1])  #(29.11, 20.71831066456885)

#1. dotplot
function plot_dotplot(gd::GroupedDataFrame, bci;title="CommuteAtlanta Time sampling")
    xs=@pipe keys(gd).|>values(_)[1]
    ys=[nrow(g) for g in gd]
    fig=Figure(resolution=(1200,600))
    ax=Axis(fig[1,1],xlabel="Time",ylabel="Count",title=title)
    Box(fig[1,1];color =(:orange,0.1),strokewidth=0.2)

    for (idx, x) in enumerate(xs)
        color=bci[1]<x<bci[2] ? :black : :red
        for y in 1:ys[idx]
            
            scatter!(ax,x,y
            ;marker=:circle,markersize=8,color=color
            ,strokewidth=0.1,strokecolor=:black)
        end
    end
    
   fig
end
#groupby(data,:Time)|>plot_dotplot|>fig->save("commuteatlanta-500-sampling.png",fig)


# 2 bootstrap method

"""
    samplen(data::Array,n::Int)
    从数组 data 中随机抽取一个样本, 样本容量为 n

"""
samplen(data::Array,n::Int)=@pipe data|>Vector(1:length(_))|>data[rand(_,n)]



## 2 basic bootstrap
n_boot = 1000   #repeat sampling times
"""
    bs(data)
    bootstraping 包装方法
"""
bs(data) = bootstrap(mean,data, BasicSampling(n_boot))

bs_data=data[:,1]|>bs
cil = 0.95;
bci= confint(bs_data, BasicConfInt(cil))[1][2:3] #置信区间
bs_gdf= @pipe bs_data|>_.t1[1]|>round.(_,digits=1)|>DataFrame(x=_)|>@orderby(_,:x)|>groupby(_,:x)

@pipe plot_dotplot(bs_gdf,bci;title="bootstrap-sampling-CI")#|>save("CommuteAtlanta-Time-bootstrap-CI.png",_)







