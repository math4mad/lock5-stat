#= 
  lock5stat page 521
  2×3 Named Matrix{Int64}
    Attidude ╲ Group │  A   B   C
    ─────────────────┼───────────
    Yes              │ 21  15  15
    No               │ 39  50  17
=#

## 1. load package
include("../../utils.jl")

## 2. data 
data = NamedArray([21 15 15 ; 39 50 17], ( ["Yes", "No"], ["A","B","C"] ), ("Attidude", "Group"))

b_card=data["Yes","B"]
b_cash= data["No","B"]
b_total=b_card+b_cash

c_cash=data["Yes","C"]
c_card= data["No","C"]
c_total=c_card+c_cash

## 3. Fisher exact ttest
FisherExactTest(b_card,c_card,b_total,c_total)
#= 
  Fisher's exact test
-------------------
Population details:
    parameter of interest:   Odds ratio
    value under h_0:         1.0
    point estimate:          0.437373
    95% confidence interval: (0.1777, 1.063)

Test summary:
    outcome with 95% confidence: fail to reject h_0
    two-sided p-value:           0.0699

Details:
    contingency table:
        15  17
        65  32
=#

## 5. results
"""
B,C 两个商家使用现金付款的比例没有区别
"""


