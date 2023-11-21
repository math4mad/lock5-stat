
#= 
   page 475 Public Libraries and Sex
   FisherExactTest(a::Integer, b::Integer, c::Integer, d::Integer)
   a/c == b/d ? 
=#

## 1. load package
include("../../utils.jl")

## 2. data 
table = NamedArray([726 697  1423 ; 505  824 1329; 1231 1521 2752], ( ["Females", "Males","Total"], ["Yes", "No","Total"] ), ("Sex", "Attitude"))
#= 
    3×3 Named Matrix{Int64}
    Sex ╲ Attitude │   Yes     No  Total
    ───────────────┼────────────────────
    Females        │   726    697   1423
    Males          │   505    824   1329
    Total          │  1231   1521   2752 
=#

## 3.  FisherExactTest

    a=table[1,1]
    c=table[1,3]
    b=table[2,1]
    d=table[2,3]
    FisherExactTest(a,b,c,d)

#= 
 Fisher's exact test
-------------------
Population details:
    parameter of interest:   Odds ratio
    value under h_0:         1.0
    point estimate:          1.34256
    95% confidence interval: (1.169, 1.542)

Test summary:
    outcome with 95% confidence: reject h_0
    two-sided p-value:           <1e-04

Details:
    contingency table:
         726   505
        1423  1329
=#

## 4. question 
### 4.1   diff of proportion
a/c-b/d # 0.13
### 4.2  
"95% confidence interval: (1.169, 1.542)"

### 4.3 
"比例有显著性差异, 女性去图书馆的比例比男性高"


