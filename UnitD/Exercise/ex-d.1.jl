
## 1.load package
include("../../utils.jl")

## 2. load data 
include("restaurant-tips-data.jl")

data=select(df,:Server)
ft=freqtable(data,:Server)

#= 
  3-element Named Vector{Int64}
Server  │ 
────────┼───
A       │ 60
B       │ 65
C       │ 32
=#

## 3. CHi-sq test
n=3
expected=fill(1/n,n)

ChisqTest(ft,expected)

#= 
Pearson's Chi-square Test
-------------------------
Population details:
    parameter of interest:   Multinomial Probabilities
    value under h_0:         [0.333333, 0.333333, 0.333333]
    point estimate:          [0.382166, 0.414013, 0.203822]
    95% confidence interval: [(0.2994, 0.466), (0.3312, 0.4979), (0.121, 0.2877)]

Test summary:
    outcome with 95% confidence: reject h_0
    one-sided p-value:           0.0024

Details:
    Sample size:        157
    statistic:          12.089171974522316
    degrees of freedom: 2
    residuals:          [1.05978, 1.75095, -2.81073]
    std. residuals:     [1.29797, 2.14446, -3.44243]
=#

## 4. results
#= 
  三个服务商的顾客数量不同
=#



