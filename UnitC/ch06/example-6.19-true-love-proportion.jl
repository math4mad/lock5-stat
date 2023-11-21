
#= 
   男性,女性中相信真爱存在的比例是否相同
    不同性别对真爱的认识假设检验
    locks5 stat page 469
    使用   FisherExactTest 
    FisherExactTest(a::Integer, b::Integer, c::Integer, d::Integer)
    null hypothesis: odds: (a/b)/(b/d)=1 
=#


## 1. load package
include("../../utils.jl")


## 2.  produce dataframe
df=(let
c2=[372,807,34];c3=[363,1005,44]
typename=["Agree","Disagree","Don't know","Total"]
df=freq_table(DataFrame(Male=c2,Female=c3);typename=typename)
df end)
@pt df
#= 
┌────────────┬───────┬────────┬───────┐
│       Type │  Male │ Female │ Total │
│     String │ Int64 │  Int64 │ Int64 │
├────────────┼───────┼────────┼───────┤
│      Agree │   372 │    363 │   735 │
│   Disagree │   807 │   1005 │  1812 │
│ Don't know │    34 │     44 │    78 │
│      Total │  1213 │   1412 │  2625 │
└────────────┴───────┴────────┴───────┘
=#


## 3.  FisherExactTest
a=df[1,2] # 男性相信真爱
b=df[1,3] # 女性相信真爱
c=df[4,2] # 男性总数
d=df[4,3] # 女性总数
#a/c  男性中相信真爱的比例, b/d 女性相信真爱的比例
FisherExactTest(a,b,c,d)

#= 
    Fisher's exact test
    -------------------
    Population details:
        parameter of interest:   Odds ratio
        value under h_0:         1.0
        point estimate:          1.19285
        95% confidence interval: (1.009, 1.41)

    Test summary:
        outcome with 95% confidence: reject h_0
        two-sided p-value:           0.0384

    Details:
        contingency table:
            372   363
            1213  1412
=#