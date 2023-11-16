
## 1 load package
include("../utils.jl")
using HypothesisTests,GLMakie,CSV,DataFrames,Distributions
using StatsBase,DataFramesMeta,Pipe

## 2. load data

desc=Lock5Table(389,"SleepCaffeine","Effect of Sleep and Caffeine on Memory?",["Group","Words"])
gdf=@pipe load_data(desc.name)|>groupby(_,:Group)


##  bootstrap sampling
data=[sample(gdf[i].Words,1000) for i in 1:2]


## 3.  variance ftest 
### 3.1 执行 f-test 检查方差差异
VarianceFTest(data...) # fail to reject h_0
#= 
    Test summary:
    outcome with 95% confidence: reject h_0
    two-sided p-value:           0.0071
    两组数据方差有差异
=#

### 3. 2 
    res=UnequalVarianceTTest(data...)

    #= 
      Two sample t-test (unequal variance)
------------------------------------
Population details:
    parameter of interest:   Mean difference
    value under h_0:         0
    point estimate:          2.749
    95% confidence interval: (2.457, 3.041)

Test summary:
    outcome with 95% confidence: reject h_0
    two-sided p-value:           <1e-69

Details:
    number of observations:   [1000,1000]
    t-statistic:              18.441652181387905
    degrees of freedom:       1986.611505006566
    empirical standard error: 0.14906473525047867

    reject h₀ 因此 睡眠与咖啡因相比能记住更多单词
=#


