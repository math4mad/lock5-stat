#= 
 lock5stat page 557
 Boys: ADHD or Just Young? 
=#

include("../../utils.jl")

## 2. data
data=NamedArray([680 0.244;7982 0.258 ;9161 0.257; 8945 0.241],(["q1(Jan-Mar)","q2(Apr-Jun)","q3(Jul-Sep)","q4(Oct-Dec)"],["ADHD Diagnoses","Proportion of birth"]),("Birth Date","Stat"))
n=4
#= 
4×2 Named Matrix{Float64}
Birth Date ╲ Stat │      ADHD Diagnoses  Proportion of birth
──────────────────┼─────────────────────────────────────────
q1(Jan-Mar)       │               680.0                0.244
q2(Apr-Jun)       │              7982.0                0.258
q3(Jul-Sep)       │              9161.0                0.257
q4(Oct-Dec)       │              8945.0                0.241
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
    point estimate:          [0.0254035, 0.298192, 0.342237, 0.334168]
    95% confidence interval: [(0.02311, 0.02792), (0.2913, 0.3052), (0.335, 0.3495), (0.327, 0.3414)]

Test summary:
    outcome with 95% confidence: reject h_0
    one-sided p-value:           <1e-99

Details:
    Sample size:        26768
    statistic:          7319.219067543334
    degrees of freedom: 3
    residuals:          [-73.4922, 15.7693, 30.1817, 27.5412]
    std. residuals:     [-84.8614, 18.2088, 34.8508, 31.8019]
=#

## 4. resutls
"""
四个季度出生的儿童,确诊 ADHD 的比例不同
"""



