include("utils.jl")
using GLMakie,CSV,DataFrames,Random,StatsBase,PrettyTables,Pipe,TableTransforms,Bootstrap
using Makie.Colors
desc=Lock5Table(270,"CommuteAtlanta","bootstrap sampling ",[:Distance,:Time])
data=@pipe load_data(desc.name)|>select(_,desc.feature[2])
mean_and_std(data[:,1])  #(29.11, 20.71831066456885)

#1. dotplot
function plot_dotplot(gd::GroupedDataFrame;title="CommuteAtlanta Time sampling")
    xs=@pipe keys(gd).|>values(_)[1]
    ys=[nrow(g) for g in gd]
    fig=Figure(resolution=(1200,600))
    ax=Axis(fig[1,1],xlabel="Time",ylabel="Count",title=title)
    Box(fig[1,1];color =(:orange,0.1),strokewidth=0.2)

    for (idx, x) in enumerate(xs)
        for y in 1:ys[idx]
            scatter!(ax,x,y
            ;marker=:circle,markersize=8,color=(:black)
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



## basic bootstrap
n_boot = 1000   #repeat sampling times
"""
    bs(data)
    bootstraping 包装方法
"""
bs(data) = bootstrap(mean,data, BasicSampling(n_boot))

gdf=@pipe  data[:,1]|>bs|>_.t1[1]|>round.(_,digits=1)|>DataFrame(x=_)|>@orderby(_,:x)|>groupby(_,:x)

@pipe plot_dotplot(gdf;title="bootstrap-sampling")#|>save("CommuteAtlanta-Time-bootstrap-sampling.png",_)







