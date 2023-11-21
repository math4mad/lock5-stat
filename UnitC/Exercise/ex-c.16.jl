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
yes=data["Yes",:]|>sum
no=data["No",:]|>sum
total=yes+no 

## confint
confint95=@pipe BinomialTest(yes,total,1/3)|>confint(_;level=0.95)
#(0.2523582890385652, 0.40408078798145086) 

