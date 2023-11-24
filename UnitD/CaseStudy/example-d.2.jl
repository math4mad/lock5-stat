#= 
lock5stat page 698
Are stress levels of college students affected by circadian preference?
=#

## 1 load package
include("../../utils.jl")
import GLM: coef, predict,confint,ftest

## 2. load data
include("sleepstudy_data.jl")

ft=freqtable(data,:Stress,:LarkOwl)

#= 
2×3 Named Matrix{Int64}
Stress ╲ LarkOwl │    Lark  Neither      Owl
─────────────────┼──────────────────────────
high             │      10       38        8
normal           │      31      125       41
=#


ChisqTest(ft)
#= 
Pearson's Chi-square Test
-------------------------
Population details:
    parameter of interest:   Multinomial Probabilities
    value under h_0:         [0.03587, 0.126185, 0.142605, 0.501664, 0.042869, 0.150807]
    point estimate:          [0.0395257, 0.12253, 0.150198, 0.494071, 0.0316206, 0.162055]
    95% confidence interval: [(0.0, 0.1037), (0.06324, 0.1867), (0.09091, 0.2144), (0.4348, 0.5583), (0.0, 0.0958), (0.1028, 0.2262)]

Test summary:
    outcome with 95% confidence: fail to reject h_0
    one-sided p-value:           0.5457

Details:
    Sample size:        253
    statistic:          1.2113994966081036
    degrees of freedom: 2
    residuals:          [0.307022, -0.163693, 0.319807, -0.17051, -0.864132, 0.460724]
    std. residuals:     [0.380092, -0.380092, 0.607651, -0.607651, -1.09057, 1.09057]
=#

## 4. results

#= 
   根据卡方检验结果, p-value=0.547 因为没有证据显示作息模式和压力水平有关联
=#



