include("../utils.jl")
using GLMakie,CSV,DataFrames,Random,PrettyTables,Pipe
using Bootstrap,StatsBase,Distributions
#Random.seed!(3434343)

data=[16,22,9,31,6,42]

cil = 0.95;n_boot=1000

"""
    bs(data::Vector{Float64})
    bootstraping 包装方法
"""
bs(data::Vector) = bootstrap(mean,data, BasicSampling(n_boot))

#bs(data)

#= 
  Bootstrap Sampling
  Estimates:
     Var │ Estimate  Bias       StdError
         │ Float64   Float64    Float64
    ─────┼───────────────────────────────
       1 │     21.0  -0.186167   4.91966
  Sampling: BasicSampling
  Samples:  1000
  Data:     Vector{Int64}: { 6 }
=#

## manually method

"""
    manual_bootstrap(data::Vector,n_boot=1000;method=mean)::Float64

    bootstrap 实现方法
    获取数组索引, 利用离散均匀分布随机获取数据,重复 n_boot 次
    返回method 定义的统计量
"""
function manual_bootstrap(data::Vector,n_boot=1000;method=mean)
    
     dist=DiscreteUniform(1,length(data))
     arr=[data[rand(dist)] for _ in 1:n_boot]
     return arr,method(arr)
end

df=DataFrame(sample=[],stat=[])

for  i in 1:10
     local d=manual_bootstrap(data,6;method=mean)
     push!(df,[d...])
end

#@pt df

#= 
┌──────────────────────────┬─────────┐
│                   sample │    stat │
│                      Any │     Any │
├──────────────────────────┼─────────┤
│    [6, 16, 9, 6, 42, 31] │ 18.3333 │
│   [31, 16, 31, 9, 6, 31] │ 20.6667 │
│  [22, 22, 31, 22, 16, 9] │ 20.3333 │
│   [6, 9, 42, 16, 42, 16] │ 21.8333 │
│  [31, 22, 22, 16, 42, 9] │ 23.6667 │
│    [42, 31, 16, 6, 6, 6] │ 17.8333 │
│   [42, 16, 31, 31, 9, 6] │    22.5 │
│ [16, 16, 22, 42, 42, 16] │ 25.6667 │
│     [6, 6, 6, 31, 6, 22] │ 12.8333 │
│ [31, 16, 22, 22, 42, 42] │ 29.1667 │
└──────────────────────────┴─────────┘
=#


bs1=bs(data)
bci1 = confint(bs1, BasicConfInt(cil))