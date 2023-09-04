

include("$(pwd())/utils.jl")

using GLMakie,CSV
using DataFramesMeta,DataFrames
using AnovaGLM,GLM

desc=Lock5Table(662,"FacebookFriends","socialnetworks-brain-structure-anova",["GMdensity","FBfriends"])

data=@pipe load_data(desc.name)|>select(_,desc.feature)
#plot_pair_cor(data)
anova_lm(@formula(FBfriends~GMdensity), data)

#= 
    ─────────────────────────────────────────────────────────────
                DOF      Exp.SS  Mean Square   F value  Pr(>|F|)
    ─────────────────────────────────────────────────────────────
    (Intercept)    1  5138022.40   5138022.40  187.0977    <1e-15
    GMdensity      1   245400.47    245400.47    8.9361    0.0049
    (Residuals)   38  1043545.13     27461.71              
    ─────────────────────────────────────────────────────────────
=#