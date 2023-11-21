"""
page 351  AreFemaleorMaleHomingPigeonsFaster?

str=HomingPigeons
feature=["Sex","Speed"]  #(H for hens and C for cocks)

1. 执行 f-test 检查方差差异  结果两样本方差无差异
    outcome with 95% confidence: fail to reject h_0
    two-sided p-value:           0.2792
2. 配对 t 检验
    outcome with 95% confidence: fail to reject h_0
    two-sided p-value:           0.9635
   
结论 :  雌雄鸽子的归巢能够力无差异
"""


## 1. load package
include("../../utils.jl")
using HypothesisTests,GLMakie,CSV,DataFrames
using Statistics,DataFramesMeta,Pipe

## 2. load data
desc=Lock5Table(351,"HomingPigeons","AreFemaleorMaleHomingPigeonsFaster?",["Sex","Speed"])
data=@pipe load_csv(desc.name)|>select(_,desc.feature)|>groupby(_,desc.feature[1])
cats=@pipe keys(data).|>values(_).|>_[1]


## 3. test

### 3.1 执行 f-test 检查方差差异
VarianceFTest(data[1][!,desc.feature[2] ],data[2][!,desc.feature[2]]) # fail to reject h_0

### 3.2 执行两样本配对 t 检验  
EqualVarianceTTest(data[1][!,desc.feature[2] ],data[2][!,desc.feature[2]]) 
#= Two sample t-test (equal variance)
----------------------------------
Population details:
    parameter of interest:   Mean difference
    value under h_0:         0
    point estimate:          0.567741
    95% confidence interval: (-23.74, 24.88)

Test summary:
    outcome with 95% confidence: fail to reject h_0
    two-sided p-value:           0.9635

Details:
    number of observations:   [649,763]
    t-statistic:              0.045814611091223166
    degrees of freedom:       1410
    empirical standard error: 12.392140019769986
 =#
