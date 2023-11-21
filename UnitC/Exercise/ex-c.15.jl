
#= 
  lock5stat page 521
=#

## 1. load package
include("../../utils.jl")

## 2. data 
data = NamedArray([21 15 15 ; 39 50 17], ( ["Yes", "No"], ["A","B","C"] ), ("Attidude", "Group"))
b_yes=data["Yes","B"]
b_no= data["No","B"]
b_total=b_yes+b_no

## 3. ttest
BinomialTest(b_yes,b_total,1/3)

## 4. results
"""
h_0:         0.333333
point estimate:          0.230769
95% confidence interval: (0.1353, 0.3519)
fail to reject h_0
"""

