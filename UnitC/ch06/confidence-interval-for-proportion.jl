"""
page  458
"""

import Distributions:quantile,cquantile
using Distributions,StatsBase

"""
    get_zscore(level=0.95;double=true)
    根据标准正态分布的概率值获得对应 zscore
  ## params
  1. level= 置信水平
  2. double 是否双侧置信区间,默认双侧
"""
function get_zscore(level=0.95;double=true)
   r=double ?  2 : 1
   cquantile(Normal(), (1-level)/r)|>d->round(d;digits=3)
end


"""
    get_ci_for_proportion(obsveration::Int,n::Int,level=0.95)
    从实验成功比例获得对应置信区间 z分数
## params
   1. obsveration 成功观测值
   2. 样本容量
   3. level 置信水平

"""
function get_ci_for_proportion(obsveration::Int,n::Int,level=0.95)
    
    p=obsveration/n
    zscore=get_zscore(level)
    tail=zscore*sqrt(p*(1-p)/n)
    return (round(p-tail,digits=3),round(p+tail,digits=3))
end


"""
    get_ci_for_proportion(ratio::Real,n::Int,level::Real=0.95)
    从实验成功比例获得对应置信区间 z分数
    ## params
       1. ratio  proportion
       2. n  观测总数
       3. level 置信水平

"""
function get_ci_for_proportion(ratio::Real,n::Int,level::Real=0.95)
    
    local p=ratio
    zscore=get_zscore(level)
    tail=zscore*sqrt((p*(1-p))/n)
    return (round(p-tail,digits=3),round(p+tail,digits=3))
end

##  get_ci_for_proportion(52,100)     # (0.422, 0.618)

## Quebec Sovereignty
   # would like Quebec to separate from Canada
   get_ci_for_proportion(0.28,800)     # (0.249, 0.311)

   #Quebec is distinct from Canada
   get_ci_for_proportion(0.82,800)     # (0.793, 0.847)

   pdf(Normal(0.5),3.319)
