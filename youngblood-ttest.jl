"""
年轻生物的血浆是对衰老的大脑是否有帮助?
lock5 stat page 107
dataset:YoungBlood
将一组相当于人类 70 岁的小鼠随机分为两组, 分别输入年轻小鼠的血浆和年老小鼠的血浆,
之后用在 90min 的窗口内测量小鼠的跑步时间

所以这是两样本的配对 t 检验

实验流程

1. 输入观测数据
2.t检验
3. 分析结果
    value under h_0:         0
    point estimate:          -22.0724
    95% confidence interval: (-37.1, -7.044)
    h_0不在 95%置信区间内
4. 结论:
     two-sided p-value:0.0055<0.05
   因此根据实验推断输入年轻鼠血浆让老龄鼠跑步时坚持的时间更长
"""


include("utils.jl")
using HypothesisTests,GLMakie,CSV,DataFrames,ScientificTypes
using Statistics,DataFramesMeta,Pipe

  df= (let str="YoungBlood"
      df=load_data(str)
  end)

  ages=levels(df[!,:Plasma])
  gdf=groupby(df,:Plasma)  #g1 输入老龄鼠血浆, g2组输入年轻鼠血浆

  
  EqualVarianceTTest(gdf[1][!,:Runtime ],gdf[2][!,:Runtime])

"""
    Two sample t-test (equal variance)
    ----------------------------------
    Population details:
        parameter of interest:   Mean difference
        value under h_0:         0
        point estimate:          -22.0724
        95% confidence interval: (-37.1, -7.044)

    Test summary:
        outcome with 95% confidence: reject h_0
        two-sided p-value:           0.0055

    Details:
        number of observations:   [13,17]
        t-statistic:              -3.008616265538657
        degrees of freedom:       28
        empirical standard error: 7.3363952867194415
"""