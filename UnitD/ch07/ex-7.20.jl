#= 
 lock5stat page 558
 Girls: ADHD or Just Young?
=#

## 1. load package
include("../../utils.jl")
## 2. data
n=4
data=NamedArray([1960 0.243;2358 0.258 ;2859 0.257; 2904 0.242],(["q1(Jan-Mar)","q2(Apr-Jun)","q3(Jul-Sep)","q4(Oct-Dec)"],["ADHD Diagnoses","Proportion of birth"]),("Birth Date","Stat"))

#= 
4×2 Named Matrix{Float64}
Birth Date ╲ Stat │      ADHD Diagnoses  Proportion of birth
──────────────────┼─────────────────────────────────────────
q1(Jan-Mar)       │              1960.0                0.243
q2(Apr-Jun)       │              2358.0                0.258
q3(Jul-Sep)       │              2859.0                0.257
q4(Oct-Dec)       │              2904.0                0.242
=#


## 3. total number of ADHD
sum(data[:,1])|>Int    #26768


## 4. chi test
observed=data[:,1].|>Int
expected=fill(1/n,n)
res=ChisqTest(observed,expected)
#= 
Pearson's Chi-square Test
-------------------------
Population details:
    parameter of interest:   Multinomial Probabilities
    value under h_0:         [0.25, 0.25, 0.25, 0.25]
    point estimate:          [0.194425, 0.233905, 0.283603, 0.288067]
    95% confidence interval: [(0.1848, 0.2045), (0.2235, 0.2446), (0.2725, 0.2949), (0.2769, 0.2995)]

Test summary:
    outcome with 95% confidence: reject h_0
    one-sided p-value:           <1e-50

Details:
    Sample size:        10081
    statistic:          238.9527824620577
    degrees of freedom: 3
    residuals:          [-11.1599, -3.23194, 6.74773, 7.6441]
    std. residuals:     [-12.8863, -3.73192, 7.7916, 8.82665]
=#

## 4. results 
"女孩的确诊比例也不同"



