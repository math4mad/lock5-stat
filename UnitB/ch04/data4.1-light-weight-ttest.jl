"""
以小鼠作为动物实验, 检验夜晚光照对体重增加是否有影响. 
分为两组 1 组夜间光照, 2  夜晚没有光照.

分组情况如下:
First Group (9 rows): Condition = "Light"
 Row │ Condition  BMGain  
     │ String7    Float64 
  ⋮  │     ⋮         ⋮
            9 rows omitted
⋮
Last Group (8 rows): Condition = "Dark"
 Row │ Condition  BMGain  
     │ String7    Float64 
  ⋮  │     ⋮         ⋮
            8 rows omitted


两组数据一般情况下会有差异, 小鼠体重差异的来源有两个:
1 真的是因为光照造成体重在两组的差异,
2 是因为抽样时的差异. 

使用配对 t 检验来检验假设 
零假设为: 两组体重均数没有明显差异, 差异是因为抽样误差造成
备择假设: 两组体重均数有差异, 这个差异用抽样误差无法解释
""" 


## 1. load package
include("../../utils.jl")
using HypothesisTests,GLMakie,CSV,DataFrames




## 2. load data
desc=Lock5Table(302,"LightatNight"," data4.1 Does Light at Night Affect Weight Gain?",["Group","BMGain"])
df=@pipe load_csv(desc.name)
gdf=groupby(df,:Group)

## 3.  配对t检验方法
EqualVarianceTTest(gdf[1].BMGain,gdf[2].BMGain)

#=
    Two sample t-test (equal variance)
----------------------------------
Population details:
    parameter of interest:   Mean difference
    value under h_0:         0
    point estimate:          2.61825
    95% confidence interval: (0.1534, 5.083)

Test summary:
    outcome with 95% confidence: reject h_0
    two-sided p-value:           0.0387

Details:
    number of observations:   [10,8]
    t-statistic:              2.2518322542402562
    degrees of freedom:       16
    empirical standard error: 1.1627198229662852


"""

"""
结论: 双侧 p 值0.0387< 0.05 所以可以拒绝 h_0
可以推测夜间光照的小鼠体重增加要高于正常灯光控制的小鼠
"""
=#