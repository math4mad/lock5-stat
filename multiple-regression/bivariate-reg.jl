"""
Multiple Regression and Beyond page 
"""

include("utils.jl")
using HypothesisTests,CSV,DataFrames,Distributions,GLMakie,StatsBase,Pipe,StatFiles
using GLM,AnovaGLM,

desc=Lock5Table(678,"NELS","bivariate home work hour and  math achievement",["bys79",""])

#df = CSV.File("./multiple-regression/homework-ach.txt") |> DataFrame

data= DataFrame(load("./multiple-regression/homework&ach.sav"))

nullmodel = lm(@formula(mathach ~ 1), data);
model=lm(@formula(mathach~mathhome), data)

#= 
  mathach ~ 1 + mathhome

    Coefficients:
    ────────────────────────────────────────────────────────────────────────
                    Coef.  Std. Error      t  Pr(>|t|)  Lower 95%  Upper 95%
    ────────────────────────────────────────────────────────────────────────
    (Intercept)  47.0316     1.69404   27.76    <1e-47  43.6698     50.3934
    mathhome      1.99018    0.595225   3.34    0.0012   0.808979    3.17139
    ────────────────────────────────────────────────────────────────────────
=#

ftest(nullmodel.model,model.model)

#= 
  F-test: 2 models fitted on 100 observations
    ───────────────────────────────────────────────────────────────────────
        DOF  ΔDOF         SSR        ΔSSR      R²     ΔR²       F*   p(>F)
    ───────────────────────────────────────────────────────────────────────
    [1]    2        12610.1900              0.0000                         
    [2]    3     1  11318.9586  -1291.2314  0.1024  0.1024  11.1795  0.0012
    ───────────────────────────────────────────────────────────────────────
=#


anova(model)

#= 
    Analysis of Variance

    Type 1 test / F test

    mathach ~ 1 + mathhome

    Table:
    ─────────────────────────────────────────────────────────────
                DOF     Exp.SS  Mean Square    F value  Pr(>|F|)
    ─────────────────────────────────────────────────────────────
    (Intercept)    1  264298.81    264298.81  2288.3098    <1e-69
    mathhome       1    1291.23      1291.23    11.1795    0.0012
    (Residuals)   98   11318.96       115.50               
    ─────────────────────────────────────────────────────────────
=#