"""
page 479
question :What is the average rental price of a one-bedroom apartment in Manhattan?


"""


include("utils.jl")
using HypothesisTests,GLMakie,CSV,DataFrames
using Statistics,Pipe,Bootstrap,Random

Random.seed!(343434)

data="""
Rent
3800
1650
1850
2132
2850
2600
3295
2350
2900
2158
2150
5400
2649
3695
2450
2195
1995
2495
2990
3850
"""


df = @pipe CSV.File(IOBuffer(data))|>DataFrame|>_[:,1]

bs(data) = bootstrap(mean,data, BasicSampling(2000))
cli=0.95
round2(data)=round(data,digits=2)

"""
    stat_res(bs::BootstrapSample)
    bootstraping 方法统计结果: bias,stderror,bci,偏差,标准误,置信区间

"""
stat_res(bs::BootstrapSample)=[:bias=>bias(bs)[1]|>round2,:stderror=>stderror(bs)[1]|>round2,
         :bci=>confint(bs, BasicConfInt(cli))]


@pipe  bs(df)|>stat_res

#= 
 3-element Vector{Pair{Symbol, Any}}:
 :bias => -6.76
 :stderror => 195.48
 :bci => ((2772.7, 2360.1312499999995, 3135.3112499999997),)
=#