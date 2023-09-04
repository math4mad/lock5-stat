
"""
主客场罚球数是否有差异?
比较主客场罚球均值  

统计数据显示 勇士在主场场均罚球数比对手还少
( 
 "homeCI" => (-6.269202455498786, -0.9015292518182871), 
 "awayCI" => (-6.979056630997716, -1.2160653202217961), 
 "bothCI" => (-5.768597486146794, -1.9143293431214987)
 )

 统计数据显示 无论在主场还是客场, 勇士队的罚球均比对手低
"""

include("$(pwd())/utils.jl")
include("data.jl")
using HypothesisTests,GLMakie,CSV,DataFrames,Distributions,Pipe

str="GSWarriors2019"
feature=["FTA","OppFTA","Location"]

#data=@pipe load_data(str)|> select(_,feature)|>transform(_, feature => ByRow(-) => :FTADiff)

"""
    free_shooting_diff_of(location::String)
    在主客场比赛时与对手罚球数的差异
## params
   location::String  in ["Home","Away"]

"""

free_shooting_diff_of(location::String)=@pipe load_data(str)|> select(_,feature)|>filter(row->row.Location == location ,_)|>transform(_, feature[1:2] => ByRow(-) => :FTADiff)

#hist(df[!,:FTADiff])
data1=free_shooting_diff_of("Home")
data2=free_shooting_diff_of("Away")
data3=vcat(data1,data2) #主客场合计罚球差异
computing_ci(data::AbstractDataFrame)=@pipe data[!,:FTADiff]|>OneSampleTTest(_,0.0)|>confint
res= ("homeCI"=>computing_ci(data1),"awayCI"=>computing_ci(data2),"bothCI"=>computing_ci(data3))