#= 
D.31 Rain in San Diego
=#

## 1. load package
#= 
D.31 Rain in San Diego
圣地亚哥四季的降雨比例是否有所不同?
=#

include("../../utils.jl")


## 2. data 
table = NamedArray([5 0 6 11 ; 16 22 14 11;], ( ["Rain", "No Rain"], ["Spring", "Summer","Autumn","Winter"] ), ("condition", "season"))

#= 
    2×4 Named Matrix{Int64}
    condition ╲ season │ Spring  Summer  Autumn  Winter
    ───────────────────┼───────────────────────────────
    Rain               │      5       0       6      11
    No Rain            │     16      22      14      11
=#

## 3. chi indepdence  test
ChisqTest(table)

#= 
Pearson's Chi-square Test
-------------------------
Population details:
    parameter of interest:   Multinomial Probabilities
    value under h_0:         [0.0639446, 0.183114, 0.0669896, 0.191834, 0.0608997, 0.174394, 0.0669896, 0.191834]
    point estimate:          [0.0588235, 0.188235, 0.0, 0.258824, 0.0705882, 0.164706, 0.129412, 0.129412]
    95% confidence interval: [(0.0, 0.1675), (0.09412, 0.2969), (0.0, 0.1086), (0.1647, 0.3675), (0.0, 0.1792), (0.07059, 0.2734), (0.03529, 0.2381), (0.03529, 0.2381)]

Test summary:
    outcome with 95% confidence: reject h_0
    one-sided p-value:           0.0022

Details:
    Sample size:        85
    statistic:          14.576977255548684
    degrees of freedom: 3
    residuals:          [-0.186712, 0.110335, -2.38624, 1.41011, 0.361961, -0.213896, 2.22354, -1.31397]
    std. residuals:     [-0.249937, 0.249937, -3.21952, 3.21952, 0.480789, -0.480789, 3.00001, -3.00001]
=#

