include("../../utils.jl")
import GLM:predict,coef


desc=Lock5Table(628,"LightatNight4Weeks","DayPct-BMGain-LinReg",["DayPct","BMGain"])
df=@pipe load_csv(desc.name)|>select(_,desc.feature)


model=lm(@formula(BMGain~DayPct), df)

#= 
BMGain ~ 1 + DayPct

Coefficients:
────────────────────────────────────────────────────────────────────────
                Coef.  Std. Error     t  Pr(>|t|)   Lower 95%  Upper 95%
────────────────────────────────────────────────────────────────────────
(Intercept)  1.1128      1.38211   0.81    0.4283  -1.73371     3.95932
DayPct       0.127268    0.023145  5.50    <1e-04   0.0796001   0.174936
────────────────────────────────────────────────────────────────────────
=#

#r2(model)     #0.5473962714337041
xtest=range(extrema(df.DayPct)...,100)
function f(x)
    input=[1,x]
    coef(model)'⋅input
end
yhat=f.(xtest)



fig=plot_reg_data(df,desc,xtest,yhat)#save("UnitD/ch09/imgs/ex-9.20-DayPct-BGMGain-LineReg.png",fig)
