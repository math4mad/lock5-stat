
"""
两列数据相关性的bootstrap sampling 方法
参数为矩阵形式 
结果为 : bs(data)|>_.t1[2]   t1 [2],[3] 是两列相关性的采样数据, dump(res) 显示结果
"""

include("utils.jl")
using GLMakie,CSV,DataFrames,Random,StatsBase,PrettyTables,Pipe,TableTransforms,Bootstrap
using DataFramesMeta
desc=Lock5Table(289,"MustangPrice","corelation bootstrap sampling ",[:Miles,:Price])
data=@pipe load_data(desc.name)|>select(_,desc.feature)|>Matrix

n_boot = 1000   #repeat sampling times
"""
    bs(data)
    bootstraping 包装方法
"""
bs(data) = bootstrap(cor,data, BasicSampling(n_boot))

bs_data=@pipe bs(data)|>_.t1[3]|>round.(_,digits=2)|>DataFrame(x=_)|>@orderby(_,:x)|>groupby(_,:x)

function plot_dotplot(gd::GroupedDataFrame)
    xs=@pipe keys(gd).|>values(_)[1]
    ys=[nrow(g) for g in gd]
    fig=Figure(resolution=(1400,600))
    ax=Axis(fig[1,1],xlabel="Coorelation",ylabel="Count",title="Mustang Miles-Price cor")
    Box(fig[1,1];color = (:orange,0.1),strokewidth=0.2)

    for (idx, x) in enumerate(xs)
        for y in 1:ys[idx]
            scatter!(ax,x,y
            ;marker=:circle,markersize=10,color=(:black,0.8)
            ,strokewidth=0.1,strokecolor=:black)
        end
    end
    
   fig
end

#fig=plot_dotplot(bs_data)
#save("mustang-price-cor-bs.png",fig)
bci= confint(bs(data), BasicConfInt(0.95))




