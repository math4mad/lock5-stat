#= 
  每天的账单数量比例否一致?
=#

## 1.load package
include("../../utils.jl")

## 2. load data 
include("restaurant-tips-data.jl")

data=select(df,:Day)
ft=freqtable(data,:Day)


## 3. chi-sq test
n=5
expected=fill(1/n,n)

ChisqTest(ft,expected)

#= 
Pearson's Chi-square Test
-------------------------
Population details:
    parameter of interest:   Multinomial Probabilities
    value under h_0:         [0.2, 0.2, 0.2, 0.2, 0.2]
    point estimate:          [0.165605, 0.127389, 0.0828025, 0.229299, 0.394904]
    95% confidence interval: [(0.08917, 0.2489), (0.05096, 0.2106), (0.006369, 0.1661), (0.1529, 0.3125), (0.3185, 0.4782)]

Test summary:
    outcome with 95% confidence: reject h_0
    one-sided p-value:           <1e-08

Details:
    Sample size:        157
    statistic:          46.34394904458597
    degrees of freedom: 4
    residuals:          [-0.963671, -2.03442, -3.28362, 0.820905, 5.4608]
    std. residuals:     [-1.07742, -2.27455, -3.6712, 0.9178, 6.10536]
=#

## 4. results
#= 
  工作日里每天的账单比例不同
=#

