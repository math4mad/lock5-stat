#= 
 lock5stat page 561
 Benford’s Law
 when you random pick a number, it't  random?
=#

## 1 . load package
include("../../utils.jl")

## 2. data 
observed=1000*[0.301, 0.176, 0.125, 0.097, 0.079 ,0.067, 0.058 ,0.051 ,0.046].|>Int
n=9
expected=fill(1/n,n)

## 3. chi test
res=ChisqTest(observed,expected)
#= 
 Pearson's Chi-square Test
-------------------------
Population details:
    parameter of interest:   Multinomial Probabilities
    value under h_0:         [0.111111, 0.111111, 0.111111, 0.111111, 0.111111, 0.111111, 0.111111, 0.111111, 0.111111]
    point estimate:          [0.301, 0.176, 0.125, 0.097, 0.079, 0.067, 0.058, 0.051, 0.046]
    95% confidence interval: [(0.2624, 0.3426), (0.1451, 0.2118), (0.09883, 0.1569), (0.07404, 0.1261), (0.05843, 0.106), (0.04822, 0.09239), (0.04068, 0.08207), (0.03491, 0.07395), (0.03084, 0.06809)]

Test summary:
    outcome with 95% confidence: reject h_0
    one-sided p-value:           <1e-99

Details:
    Sample size:        1000
    statistic:          488.7979999999999
    degrees of freedom: 8
    residuals:          [18.0144, 6.1559, 1.31762, -1.3387, -3.04633, -4.18475, -5.03856, -5.70264, -6.17698]
    std. residuals:     [19.1072, 6.52932, 1.39754, -1.4199, -3.23112, -4.43859, -5.3442, -6.04856, -6.55168]
=#


