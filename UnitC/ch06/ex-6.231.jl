#= 
 lock5stat page  496
=#

## 1. load package
include("../../utils.jl")

## 2. data

table = NamedArray([38 25.6 10.8 ; 40 18.3 9.0], ( ["Longhand","Laptop"], ["n", "x̅","s"] ), ("note-taking", "statistics"))
#= 
2×3 Named Matrix{Float64}
note-taking ╲ statistics │    n     x̅     s
─────────────────────────┼──────────────────
Longhand                 │ 38.0  25.6  10.8
Laptop                   │ 40.0  18.3   9.0
=#
Longhand=table[1,:]
Laptop =table[2,:]
nx,mx,vx=Longhand
ny,my,vy=Laptop
EqualVarianceTTest(Int(nx),Int(ny),mx,my,vx,vy)
#= 
 Two sample t-test (equal variance)
----------------------------------
Population details:
    parameter of interest:   Mean difference
    value under h_0:         0
    point estimate:          7.3
    95% confidence interval: (5.882, 8.718)

Test summary:
    outcome with 95% confidence: reject h_0
    two-sided p-value:           <1e-15

Details:
    number of observations:   [38,40]
    t-statistic:              10.254154786948206
    degrees of freedom:       76
    empirical standard error: 0.711906554140538
=#


