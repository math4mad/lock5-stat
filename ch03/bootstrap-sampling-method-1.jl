"""
using Bootstrap.jl 软件包 

"""


include("$(pwd())/utils.jl")
using GLMakie,CSV,DataFrames,Random,PrettyTables,Pipe
using Bootstrap,StatsBase
Random.seed!(3434343)


# 获取分组数据:  csv|>dataframe
str="BaseballSalaries2019"
feature=[:Name,:Salary]

data=@pipe load_data(str)|>select(_,feature[2])|>Array


"""
    samplen(data::Array,n::Int)
    从数组 data 中随机抽取一个样本, 样本容量为 n

"""
samplen(data::Array,n::Int)=@pipe data|>Vector(1:length(_))|>data[rand(_,n)]

n_boot = 1000   #repeat sampling times


## basic bootstrap
cil = 0.95
"""
    bs(data)
    bootstraping 包装方法
"""
bs(data) = bootstrap(std,data, BasicSampling(n_boot))
round2(data)=round(data,digits=2)

"""
    stat_res(bs::BootstrapSample)
    bootstraping 方法统计结果: bias,stderror,bci,偏差,标准误,置信区间

"""
stat_res(bs::BootstrapSample)=[:bias=>bias(bs)[1]|>round2,:stderror=>stderror(bs)[1]|>round2,
         :bci=>confint(bs, BasicConfInt(cil))]

res1=@pipe samplen(data,30)|>bs(_)|>stat_res


