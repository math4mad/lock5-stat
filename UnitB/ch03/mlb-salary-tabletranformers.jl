"""
棒球联盟工资均值
lock5 page 239

当我们从数据表中抽取 n=30(样本容量)个球员的工资, 然后计算均值. 这时候会有一个问题, 如果反复多次抽样,会发现每次计算的均值几乎都不相同
这是因为n=30 并不是总体的全部,所以捕捉的总体信息是不同的,每次抽取的个体不同,所以均值也不同]
统计学家想知道不同次抽样之间的差异有多大?  

1. 但是样本均值会围绕着总体均数变化


2. using  TableTransforms  sampling method


3. 重复采样的样本可以计算出均值, 这些均值有自己的均值和标准差, 抽样试验所代表的分布标准差定义为样本标准误

"""

include("utils.jl")
using GLMakie,CSV,DataFrames,Random,StatsBase,PrettyTables,Pipe,TableTransforms

desc=Lock5Table(239,"BaseballSalaries2019","mean diff",[:Name,:Salary])


# 获取分组数据:  csv|>dataframe
data=@pipe load_data(desc.name)|>select(_,desc.feature[2])

"从总体抽取 30 个个体"
sample_mean=(i)->@pipe data|>Sample(30, replace=true)|>_[:,1]|>mean

"重复采样 2000 次"
sample2000=@pipe Vector(1:2000)|>sample_mean.(_)|>round.(_,digits=3)
ci(m,se)=(m-2*se,m+2*se)  #置信区间计算
@pipe (sample2000)|>mean_and_std|>ci(_...)




# """
#     plot_repeatsampling_means(trialtimes=2000,samplesize=30)
#     从总体中进行反复采样,执行 2000 次
#     每次采样的样本容量为:30
#     `means_arr=[mean_30() for i in 1:2000].|>d->round(d,digits=3)`
#  ## arguments
#    1.  trialtimes=2000
#    2.  samplesize=30
# """
# function plot_repeatsampling_means(trialtimes=2000,samplesize=30)
#     fig=Figure(resolution=(300,300))
#     ax=Axis(fig[1,1])
#     means_arr=[mean_30() for i in 1:trialtimes].|>d->round(d,digits=3)
#     hist!(ax,means_arr)
#     vlines!(ax,[μ],color=:red)
#     fig
#    #save("$(pwd())/imgs/baseball-salary-30samplesize-mean.png",fig)
# end

