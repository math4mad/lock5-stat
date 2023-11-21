"""
使用 CorrelationTest(x, y) 检验两个变量的相关性
"""

include("$(pwd())/utils.jl")
using HypothesisTests,GLMakie,CSV,DataFrames,Distributions
using  Pipe,AnovaGLM,GLM

desc=Lock5Table(662,"InkjetPrinters","costcolro and  price  anova?",["Price","CostColor"])

data=@pipe load_data(desc.name)|>select(_,desc.feature)
anova_lm(@formula(Price~CostColor), data)


#= 
    Price ~ 1 + CostColor
    ────────────────────────────────────────────────────────────
                DOF     Exp.SS  Mean Square   F value  Pr(>|F|)
    ────────────────────────────────────────────────────────────
    (Intercept)    1  522291.20    522291.20  119.5581    <1e-08
    CostColor      1   57603.55     57603.55   13.1861    0.0019
    (Residuals)   18   78633.25      4368.51              
    ────────────────────────────────────────────────────────────

=#