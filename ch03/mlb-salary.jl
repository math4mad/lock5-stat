"""
棒球联盟工资均值
lock5 page 239

当我们从数据表中抽取 n=30(样本容量)个球员的工资, 然后计算均值. 这时候会有一个问题, 如果反复多次抽样,会发现每次计算的均值几乎都不相同
这是因为n=30 并不是总体的全部,所以捕捉的总体信息是不同的,每次抽取的个体不同,所以均值也不同]
统计学家想知道不同次抽样之间的差异有多大?  
"""

include("utils.jl")
using GLMakie,CSV,DataFrames,Random,StatsBase,PrettyTables,Pipe




# 获取分组数据:  csv|>dataframe
str="BaseballSalaries2019"
feature=[:Name,:Salary]
df=load_data(str)
data=select(df,feature)
range=Vector(1:size(data,1))
μ=data[!,:Salary]|>mean|>d->round(d,digits=3)
mean_30=()->data[rand(range,30),:Salary]|>mean|>d->round(d,digits=3)

means_arr=[mean_30() for i in 1:100]
residual=(means_arr.-μ).|>d->round(d,digits=3)

function plot_residual()
    fig=Figure(resolution=(800,300))
    ax=Axis(fig[1,1])
    stem!(ax,1:100,residual)
    fig
    #save("./imgs/baseball-salary-residual.png",fig)
end 

#plot_residual()


function plot_samples_means()
  fig=Figure(resolution=(300,300))
  ax=Axis(fig[1,1])
  means_arr=[mean_30() for i in 1:2000].|>d->round(d,digits=3)
   hist!(ax,means_arr)
   vlines!(ax,[μ],color=:red)
   fig
   #save("$(pwd())/imgs/baseball-salary-30samplesize-mean.png",fig)
end

#plot_samples_means()
#@pt describe(data)

function computing_stderror()
  do_sample(i)=sample(data[!,:Salary],30)
  samples1000=[do_sample(i) for i in 1:1000]
  @pipe  samples1000.|>mean|>std|>round(_,digits=3)
end