#= 
 Are Credit Cards used Equally Often between the Days of the Week? 
=#

## 1.load package
include("../../utils.jl")

## 2. load data 
include("restaurant-tips-data.jl")

data=select(df,:Day,:Credit)
transform!(data,:Credit=>ByRow(x->x=="n"  ? "cash" : "credit" )=>:Credit)
ft=freqtable(data,:Credit,:Day)


## 3. chi test
ChisqTest(ft)

#= 
Pearson's Chi-square Test
-------------------------
Population details:
    parameter of interest:   Multinomial Probabilities
    value under h_0:         [0.11181, 0.0537953, 0.0860075, 0.041381, 0.0559049, 0.0268976, 0.154814, 0.0744858, 0.266623, 0.128281]
    point estimate:          [0.140127, 0.0254777, 0.089172, 0.0382166, 0.0318471, 0.0509554, 0.152866, 0.0764331, 0.261146, 0.133758]
    95% confidence interval: [(0.07006, 0.216), (0.0, 0.1013), (0.01911, 0.165), (0.0, 0.114), (0.0, 0.1077), (0.0, 0.1268), (0.0828, 0.2287), (0.006369, 0.1523), (0.1911, 0.337), (0.06369, 0.2096)]

Test summary:
    outcome with 95% confidence: fail to reject h_0
    one-sided p-value:           0.0721

Details:
    Sample size:        157
    statistic:          8.592432496197128
    degrees of freedom: 4
    residuals:          [1.06112, -1.5298, 0.1352, -0.194915, -1.27491, 1.83801, -0.0620136, 0.0894036, -0.132903, 0.191603]
    std. residuals:     [2.03819, -2.03819, 0.25394, -0.25394, -2.33568, 2.33568, -0.123939, 0.123939, -0.29977, 0.29977]
=#

## 4. results
#= 
  每周不同天里现金/信用卡 付款比例没有差别
=#



