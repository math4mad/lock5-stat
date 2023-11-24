#= 
  ref : [Chi-Square Test of Independence in R (With Examples)](https://www.statology.org/chi-square-test-of-independence-in-r/)
  解释

  Chi-Square Test of Independence  检测两个分类变量是否有关联
  3×5 Named Matrix{Int64}
condition ╲ city │    LA     SF     SD     SJ  Total
─────────────────┼──────────────────────────────────
Rain             │     4      6     22      3     35
No Rain          │    21     17     63     20    121
Total            │    25     23     85     23    156

这里的的 contigency table 是天气晴雨的分类变量和不同城市的两组分类变量
因此使用卡方独立性检验来测试两个分类变量是否有关联

检验假设为:
h₀: 晴雨天气与城市是独立的变量
hₐ: 晴雨天气与城市相关

=#

## 1. load package
include("../../utils.jl")


## 2. data 
table = NamedArray([4 6 22 3 35 ; 21 17 63 20 121;25 23 85 23 156], ( ["Rain", "No Rain","Total"], ["LA", "SF","SD","SJ","Total"] ), ("condition", "city"))

#= 
3×5 Named Matrix{Int64}
condition ╲ city │    LA     SF     SD     SJ  Total
─────────────────┼──────────────────────────────────
Rain             │     4      6     22      3     35
No Rain          │    21     17     63     20    121
Total            │    25     23     85     23    156
=#

ChisqTest(table[1:end-1,1:end-1])

#= 
Pearson's Chi-square Test
-------------------------
Population details:
    parameter of interest:   Multinomial Probabilities
    value under h_0:         [0.035955, 0.124301, 0.0330786, 0.114357, 0.122247, 0.422625, 0.0330786, 0.114357]
    point estimate:          [0.025641, 0.134615, 0.0384615, 0.108974, 0.141026, 0.403846, 0.0192308, 0.128205]
    95% confidence interval: [(0.0, 0.1089), (0.0641, 0.2179), (0.0, 0.1217), (0.03846, 0.1922), (0.07051, 0.2243), (0.3333, 0.4871), (0.0, 0.1025), (0.05769, 0.2115)]

Test summary:
    outcome with 95% confidence: fail to reject h_0
    one-sided p-value:           0.4722

Details:
    Sample size:        156
    statistic:          2.517355396057086
    degrees of freedom: 3
    residuals:          [-0.679372, 0.365383, 0.369667, -0.198816, 0.670827, -0.360788, -0.950976, 0.511459]
    std. residuals:     [-0.84179, 0.84179, 0.454587, -0.454587, 1.12905, -1.12905, -1.16943, 1.16943]
=#


## 4.results  
#= 
天气晴雨与城市没有关系
=#
