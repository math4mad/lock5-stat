"""
page 656  
以 Sugars 预测 麦片热量线性模型的 anova 分析
"""


include("$(pwd())/utils.jl")

using GLMakie,CSV,DataFrames,LinearAlgebra
using DataFramesMeta,Pipe,ColorSchemes
using AnovaGLM,GLM
#Calories,Fat,Sodium,Carbs,Fiber,Sugars,Protein

desc=Lock5Table(662,"Cereal","fiber-caloric-lm-anova",["Calories","Fiber"])
data=@pipe load_data(desc.name)|>select(_,desc.feature)
res=anova_lm(@formula( Calories~Fiber), data)

#= 
    ────────────────────────────────────────────────────────────
             DOF     Exp.SS  Mean Square   F value  Pr(>|F|)
    ────────────────────────────────────────────────────────────
    (Intercept)    1  537340.83    537340.83  541.7121    <1e-19
    Fiber          1    7376.11      7376.11    7.4361    0.0109
    (Residuals)   28   27774.06       991.93              
    ────────────────────────────────────────────────────────────    
=#
