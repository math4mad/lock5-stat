## 1.  load package
include("../../utils.jl")
using Bootstrap,StatsBase,GLM
##  2. load data
desc=Lock5Table(429,"CommuteAtlanta","ex-5.55",["Distance","Time"])
data =@pipe load_csv(desc.name)|>select(_,desc.feature)

cor_arr=Vector{Float64}(undef, 1000)

for i in 1:1000
    cor_arr[i]=@pipe rand(1:500,300)|>data[_,:]|>eachcol(_)...|>cor
end
std(cor_arr)
