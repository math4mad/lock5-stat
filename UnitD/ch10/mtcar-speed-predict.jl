
include("utils.jl")
using HypothesisTests,CSV,DataFrames,Distributions,GLMakie,StatsBase
using GLM,AnovaGLM,Pipe

desc=Lock5Table(685,"MTCars","predict  speed ",["mpg", "disp", "hp", "drat"])

data=@pipe load_data(desc.name)|>select(_,desc.feature)

fitmodel=lm(@formula(mpg ~ disp + hp + drat), data)

#hist(residuals(fitmodel))
#= 
    mpg ~ 1 + disp + hp + drat

    Coefficients:
    ────────────────────────────────────────────────────────────────────────────────
                    Coef.   Std. Error      t  Pr(>|t|)    Lower 95%    Upper 95%
    ────────────────────────────────────────────────────────────────────────────────
    (Intercept)   4.55706     0.659958      6.91    <1e-06   3.2052       5.90892
    disp         -0.00244946  0.000970781  -2.52    0.0176  -0.00443801  -0.0004609
    hp           -0.00320178  0.0013824    -2.32    0.0281  -0.00603351  -0.00037006
    drat          0.253718    0.154076      1.65    0.1108  -0.0618922    0.569328
    ────────────────────────────────────────────────────────────────────────────────
=#


@pipe fitmodel|>("R²"=>r2(_),"stderror"=>stderror(_))  #0.79

anova(fitmodel)