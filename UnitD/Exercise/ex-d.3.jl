#= 
 三个服务商的信用卡付款比例是否一样
=#

## 1.load package
include("../../utils.jl")

## 2. load data 
include("restaurant-tips-data.jl")

data=select(df,:Server,:Credit)
transform!(data,:Credit=>ByRow(x->x=="n"  ? "cash" : "credit" )=>:Credit)
ft=freqtable(data,:Credit,:Server)
#= 
2×3 Named Matrix{Int64}
Credit ╲ Server │  A   B   C
────────────────┼───────────
cash            │ 39  50  17
credit          │ 21  15  15
=#

## 3. chi test

ChisqTest(ft)

#= 
  Pearson's Chi-square Test
-------------------------
Population details:
    parameter of interest:   Multinomial Probabilities
    value under h_0:         [0.258023, 0.124143, 0.279525, 0.134488, 0.137612, 0.0662096]
    point estimate:          [0.248408, 0.133758, 0.318471, 0.0955414, 0.10828, 0.0955414]
    95% confidence interval: [(0.172, 0.328), (0.05732, 0.2134), (0.242, 0.3981), (0.01911, 0.1751), (0.03185, 0.1879), (0.01911, 0.1751)]

Test summary:
    outcome with 95% confidence: fail to reject h_0
    one-sided p-value:           0.0545

Details:
    Sample size:        157
    statistic:          5.817590230939981
    degrees of freedom: 2
    residuals:          [-0.237176, 0.34193, 0.923021, -1.3307, -0.990742, 1.42833]
    std. residuals:     [-0.529418, 0.529418, 2.11559, -2.11559, -1.94814, 1.94814]
=#

## 4. results
#= 
  三个服务商的现金/信用卡付款账单比例没有差异
=#




