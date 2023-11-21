"""
 根据 BodyTemp50 的数据检验体温均数是否等于98.6 ℉

 检验结果 pvalue=0.0029<0.05
 置信区间95% confidence interval: (98.04, 98.48) 也不包括 μ₀
 因此拒绝 0 假设,  体温均数不等于98.6 ℉
"""


## 1. load package
include("../../utils.jl")

## 2. load data
desc=Lock5Table(410,"BodyTemp50","example5.8",[])
df=@pipe load_csv(desc.name)
data=df[!,1]


## 3. statistic describe
"mean_std"=>mean_and_std(data) # "mean_std" => (98.26, 0.7653197277702208)

## 4. random sampling 
#samples=rand(data,1000)
means=[mean(rand(data,30)) for _ in 1:1000]
mean_and_std(means) #(98.25862000000001, 0.1425159864941691)

## 4. ttest
# μ₀=98.6
# res=OneSampleTTest(data,μ₀)

#= 
  point estimate:          98.26
    95% confidence interval: (98.04, 98.48)

Test summary:
    outcome with 95% confidence: reject h_0
    two-sided p-value:           0.0029
=#