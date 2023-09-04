"""
lock5 statistics page 27
数据框里每列数据表述不同的属性, 每行数据就像是一个人在所自我介绍一样, 变现出了不同的特征和喜好

"""

include("utils.jl")
using HypothesisTests,GLMakie,CSV,DataFrames,ScientificTypes
using Statistics,DataFramesMeta,Pipe

  df= (let str="StudentSurvey2"
      df=load_data(str)
  end)

# 大学年级目录
year_cats=levels(df[!,:Year])

"""
    sat_mean_of(year)
    获取不同年级的 SAT 成绩均值
    ```julia
        sat_mean_of(year)=@pipe df|>filter(:Year => ==(year), _) |> select(_,[:SAT])|>Array|>mean|>round(_,digits=3)
    ```
"""
sat_mean_of(year)=@pipe df|>filter(:Year => ==(year), _) |> select(_,[:SAT])|>Array|>mean|>round(_,digits=3)
means_sat=[Symbol(year)=>sat_mean_of(year) for year in year_cats]
#=
:FirstYear => 1176.962
    :Junior => 1227.097
    :Senior => 1191.111
 :Sophomore => 1215.726
=#


"""
    sat_median_of(year)
    获取不同年级学生 SAT成绩的中位数
`sat_median_of(year)=@pipe df|>filter(:Year => ==(year), _) |> select(_,[:SAT])|>Array|>median|>round(_,digits=3)`
TBW
"""
sat_median_of(year)=@pipe df|>filter(:Year => ==(year), _) |> select(_,[:SAT])|>Array|>median|>round(_,digits=3)
median_sat=[Symbol(year)=>sat_median_of(year) for year in year_cats]

#= """
    :FirstYear => 1180.0
    :Junior => 1240.0
    :Senior => 1215.0
    :Sophomore => 1220.0
""" =#

