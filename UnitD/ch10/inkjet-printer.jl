"""
喷墨打印机的价格的线性模型


"""

include("utils.jl")
using HypothesisTests,CSV,DataFrames,Distributions,GLMakie,StatsBase
using GLM,Pipe

desc=Lock5Table(678,"InkjetPrinters","mutliple regression ",["PPM","CostBW","Price"])

data=@pipe load_data(desc.name)|>select(_,desc.feature)

fitmodel=lm(@formula(Price ~ PPM+CostBW), data)
#round.(coef(res), digits=3)

function f(p,c)
    input=[1,p,c]
    coef(res)'⋅input
end



@pipe residuals(fitmodel)|>zscore|>stem   #plot all  data  residuals
#save("./ch10/imgs/inkjet-printer-multiple-reg.png",fig)

#= 
   Price ~ 1 + PPM + CostBW
    Coefficients:
    ────────────────────────────────────────────────────────────────────────
                    Coef.  Std. Error      t  Pr(>|t|)  Lower 95%  Upper 95%
    ────────────────────────────────────────────────────────────────────────
    (Intercept)   89.205     95.7443    0.93    0.3645  -112.798   291.208
    PPM           58.0993    22.7854    2.55    0.0207    10.0263  106.172
    CostBW       -21.125      9.34077  -2.26    0.0371   -40.8323   -1.41771
    ────────────────────────────────────────────────────────────────────────

    两个参数进行了 t检验, h₀: coef=0, hₐ: coef ≠0  
    结论:
    PPM, CostBW 的 pvalue 在 95% 置信区间下都小于 0.05. 所以系数不为 0
    所以两个参数都参与回归模型的建立
=#

