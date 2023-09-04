"""
page 656  
以 Sugars 预测 麦片热量线性模型的 anova 分析
"""


include("utils.jl")

using GLMakie,CSV,DataFrames,LinearAlgebra
using DataFramesMeta,Pipe,ColorSchemes
using AnovaGLM,GLM


desc=Lock5Table(656,"Cereal","sugar-caloric-lm-anova",["Calories","Sugars","Fat","Sodium","Carbs","Fiber","Protein"])

data=@pipe load_data(desc.name)|>select(_,desc.feature)

a1=anova_lm(@formula( Calories~Sugars), data)

#= 
  Analysis of Variance

    Type 1 test / F test

    Calories ~ 1 + Sugars

    Table:
    ────────────────────────────────────────────────────────────
                DOF     Exp.SS  Mean Square   F value  Pr(>|F|)
    ────────────────────────────────────────────────────────────
    (Intercept)    1  537340.83    537340.83  758.5866    <1e-21
    Sugars         1   15316.51     15316.51   21.6230    <1e-04
    (Residuals)   28   19833.65       708.34              
    ────────────────────────────────────────────────────────────
=#

a2=anova_lm(@formula( Calories~Fat+Sodium+Carbs+Fiber+Sugars+Protein), data)

#= 
    Type 1 test / F test

    Calories ~ 1 + Fat + Sodium + Carbs + Fiber + Sugars + Protein

    Table:
    ────────────────────────────────────────────────────────────────
                DOF       Exp.SS  Mean Square     F value  Pr(>|F|)
    ────────────────────────────────────────────────────────────────
    (Intercept)    1  537340.83    537340.83    92649.9379    <1e-42
    Fat            1   16268.89     16268.89     2805.1314    <1e-24
    Sodium         1       4.1098       4.1098      0.7086    0.4086
    Carbs          1   17809.71     17809.71     3070.8042    <1e-25
    Fiber          1     271.85       271.85       46.8732    <1e-06
    Sugars         1      64.47        64.47       11.1157    0.0029
    Protein        1     597.75       597.75      103.0654    <1e-09
    (Residuals)   23     133.39         5.7997                
    ────────────────────────────────────────────────────────────────
=#

lms3 = nestedmodels(LinearModel, @formula(Calories~Fat+Sodium+Carbs+Fiber+Sugars+Protein), data; dropcollinear = false)
anova(lms3)

#= 
    Model 1: Calories ~ 0
    Model 2: Calories ~ 1
    Model 3: Calories ~ 1 + Fat
    Model 4: Calories ~ 1 + Fat + Sodium
    Model 5: Calories ~ 1 + Fat + Sodium + Carbs
    Model 6: Calories ~ 1 + Fat + Sodium + Carbs + Fiber
    Model 7: Calories ~ 1 + Fat + Sodium + Carbs + Fiber + Sugars
    Model 8: Calories ~ 1 + Fat + Sodium + Carbs + Fiber + Sugars + Protein

    Table:
    ─────────────────────────────────────────────────────────────────────────────────────
    DOF  ΔDOF  Res.DOF       R²      ΔR²     Res.SS       Exp.SS     F value  Pr(>|F|)
    ─────────────────────────────────────────────────────────────────────────────────────
    1    1             23   0                572491                                
    2    2     1       23  <1e-15   <1e-15    35150.17  537340.83    92649.9379    <1e-51
    3    3     1       23   0.4628   0.4628   18881.28   16268.89     2805.1314    <1e-28
    4    4     1       23   0.4630   0.0001   18877.17       4.1098      0.7086    0.4073
    5    5     1       23   0.9696   0.5067    1067.46   17809.71     3070.8042    <1e-27
    6    6     1       23   0.9774   0.0077     795.61     271.85       46.8732    <1e-06
    7    7     1       23   0.9792   0.0018     731.14      64.47       11.1157    0.0028
    8    8     1       23   0.9962   0.0170     133.39     597.75      103.0654    <1e-09
    ─────────────────────────────────────────────────────────────────────────────────────
=#
