"""
果蝇对交配对象的选择是否影响到后代的存活力?

"""


"""
locks5 page369
"""

include("$(pwd())/utils.jl")
using HypothesisTests,GLMakie,CSV,DataFrames,Distributions
using StatsBase,DataFramesMeta,Pipe


desc=Lock5Table(369,"MateChoice","果蝇对交配对象的选择是否影响到后代的存活力?",["Choice","NoChoice","Difference"])
data=@pipe load_data(desc.name)


#qa
a,c,b,d=6067,10000,5967,10000
m1=FisherExactTest(a,b,c,d)  
#=
 95% confidence interval: (0.9715, 1.064)
 fail to reject h_0,p-value:0.4785
=#

# 检测两组差值是否属于均值为0的正态分布数据
#OneSampleTTest(data[!,3])   #p-value=0.41,fail to reject h_0



