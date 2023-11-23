"""
chapter:
page 665  ex 10.33
data:usd  predict hangout time

"""


## 1. load package

include("../../utils.jl")


## 2. load data

desc=Lock5Table(665,"PASeniors","predict hangout tiem",["HWHours","SportsHours", "VideoGameHours", "ComputerHours", "TVHours", "WorkHours","HangHours"])
df=@pipe load_csv(desc.name,false)
data=select(df,desc.feature)


## 3. lin reg
model=lm(@formula(HangHours ~ HWHours+SportsHours+VideoGameHours+ComputerHours+TVHours+WorkHours), data)
#= 
HangHours ~ 1 + HWHours + SportsHours + VideoGameHours + ComputerHours + TVHours + WorkHours

Coefficients:
────────────────────────────────────────────────────────────────────────────────
                     Coef.  Std. Error      t  Pr(>|t|)     Lower 95%  Upper 95%
────────────────────────────────────────────────────────────────────────────────
(Intercept)      5.53226     1.27023     4.36    <1e-04   3.03331      8.03121
HWHours         -0.078448    0.0582335  -1.35    0.1789  -0.193011     0.0361155
SportsHours      0.333079    0.076148    4.37    <1e-04   0.183272     0.482886
VideoGameHours   0.112386    0.0781446   1.44    0.1513  -0.0413492    0.266121
ComputerHours    0.0728827   0.0372463   1.96    0.0512  -0.000392463  0.146158
TVHours          0.267292    0.0764241   3.50    0.0005   0.116942     0.417642
WorkHours        0.105353    0.0648498   1.62    0.1052  -0.0222264    0.232933
────────────────────────────────────────────────────────────────────────────────
=#