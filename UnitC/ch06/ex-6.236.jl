#= 
 lock5stat page  498
=#

## 1. load package
include("../../utils.jl")

## 2. data

table = NamedArray([30 8.12 7.68;37 5.50 6.44], ( ["2010","2019"], ["sample size", "mean","St.Dev"] ),("Year","Statistics"))

y2010=table[1,:]
y2019 =table[2,:]
nx,mx,vx=y2010
ny,my,vy=y2019
EqualVarianceTTest(Int(nx),Int(ny),mx,my,vx,vy)

#= 
Two sample t-test (equal variance)
----------------------------------
Population details:
    parameter of interest:   Mean difference
    value under h_0:         0
    point estimate:          2.62
    95% confidence interval: (1.322, 3.918)

Test summary:
    outcome with 95% confidence: reject h_0
    two-sided p-value:           0.0001

Details:
    number of observations:   [30,37]
    t-statistic:              4.032612105495247
    degrees of freedom:       65
    empirical standard error: 0.6497029546753881
=#


