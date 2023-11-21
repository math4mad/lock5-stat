"""
The null hypothesis is 𝜌 = 0, which means that NFL_Malevolence and ZPenYds are really unrelated.
方法参见  [correlation-test](/HypothesisTests.jl/doc/multivariate/#Correlation-and-partial-correlation-test)
"""

include("../../utils.jl")
using HypothesisTests,GLMakie,CSV,DataFrames,Distributions
using StatsBase,DataFramesMeta,Pipe


desc=Lock5Table(307,"MalevolentUniformsNFL","Do Teams with Malevolent Uniforms Get More Penalties?",["NFL_Malevolence","ZPenYds"])
data=@pipe load_data(desc.name)|>select(_,desc.feature)

make_cor_ttest=(data)->CorrelationTest(eachcol(data)...)
#=  
    outcome with 95% confidence: reject h_0
    two-sided p-value:           0.0224
    两个变量存在相关性
    95% confidence interval: (0.06755, 0.6919)
=#

function plot_dist(data::AbstractDataFrame)
 row,col=size(data)
 core=cor(eachcol(data)...)
 λ=row-1
 d=TDist(λ)
 xs=range(-4,4,100)
 fig,ax,pl=lines(xs,pdf.(d,xs))
 vlines!(ax,[2.42715])
 fig
end
#plot_dist(data)

d=TDist(28)
cquantile(d,0.0224/2)
#invlogcdf(d,0.0224)