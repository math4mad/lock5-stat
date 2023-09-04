
"""
进行反复抽样试验, 
对于本例总体是已知的,所以参数可以计算,抽样是模拟从个体数量庞大,甚至是无限个体的总体中进行抽样实验的过程

反复从总体中有放回的抽取 2000次. 每次抽出的球员数为 30

这里的定义要注意 ,  2000次试验称为 2000 sampling
                  每次试验抽出的球员个数为 30,  这是 sample size 

"""

include("utils.jl")
using GLMakie,CSV,DataFrames,Random,StatsBase,PrettyTables,Pipe,TableTransforms

desc=Lock5Table(239,"BaseballSalaries2019","sampling distribution",[:Name,:Salary])
data=@pipe load_data(desc.name)|>select(_,desc.feature[2])
μ=data[:,1]|>mean  
"从总体抽取 30 个个体"
sample_mean=(i)->@pipe data|>Sample(30, replace=true)|>_[:,1]|>mean

"重复采样 2000 次"
sample2000=@pipe Vector(1:2000)|>sample_mean.(_)|>round.(_,digits=1)

gd=@pipe DataFrame(x=sample2000)|>@orderby(_,:x)|>groupby(_,:x)


function plot_dotplot(gd::GroupedDataFrame)
    xs=@pipe keys(gd).|>values(_)[1]
    ys=[nrow(g) for g in gd]
    fig=Figure(resolution=(1400,600))
    ax=Axis(fig[1,1],xlabel="Salary",ylabel="Count",title="MLB Player salary count")
    Box(fig[1,1];color = (:orange,0.1),strokewidth=0.2)

    for (idx, x) in enumerate(xs)
        for y in 1:ys[idx]
            scatter!(ax,x,y
            ;marker=:circle,markersize=5,color=(:black)
            ,strokewidth=0.1,strokecolor=:black)
        end
    end
    vlines!(ax,[μ],label="population  mean")
    
    axislegend(ax)
   fig
end

fig=plot_dotplot(gd);#save("baseball-salary-2000samples-mean-dotplot.png",fig)
