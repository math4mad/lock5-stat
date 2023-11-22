"""
question :
page :lock5 stat page 
dataset:
describe:
将一组相当于人类 70 岁的小鼠随机分为两组, 分别输入年轻小鼠的血浆和年老小鼠的血浆,
之后用在 90min 的窗口内测量小鼠的跑步时间

实验流程

1. 输入观测数据
2.t检验
3. 分析结果
   
4. 结论:

"""


include("../../utils.jl")


  df= (let str="YoungBlood"
      df=load_data(str)
  end)



ages=levels(df[!,:Plasma])
gdf=groupby(df,:Plasma)  #g1 输入老龄鼠血浆, g2组输入年轻鼠血浆
EqualVarianceTTest(gdf[1][!,:Runtime ],gdf[2][!,:Runtime])
