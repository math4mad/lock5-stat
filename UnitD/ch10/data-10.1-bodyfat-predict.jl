
"""
body fat predict with several predict variables
"""


include("../../utils.jl")


desc=Lock5Table(656,"BodyFat","cause direct measure bodyfat not aviable, so try to predict bodyfat with other params",["Age","Weight","Height","Neck","Chest","Abdomen","Ankle","Biceps","Wrist","Bodyfat"])

data=@pipe load_csv(desc.name)

full_lm=lm(@formula(Bodyfat ~ Age+Weight+Height+Neck+Chest+Abdomen+Ankle+Biceps+Wrist), data)

model1=anova(full_lm)

model2=lm(@formula(Bodyfat ~Height+Abdomen+Wrist), data)


#fig,ax,plt=@pipe residuals(res2)|>zscore|>stem
#save("./ch10/imgs/bodyfat-multiple-reg.png",fig)

#= 
  Analysis of Variance

Type 1 test / F test

Bodyfat ~ 1 + Age + Weight + Height + Neck + Chest + Abdomen + Ankle + Biceps + Wrist

Table:
──────────────────────────────────────────────────────────────
             DOF      Exp.SS  Mean Square    F value  Pr(>|F|)
──────────────────────────────────────────────────────────────
(Intercept)    1  34599.72     34599.72    2023.0771    <1e-62
Age            1    415.27       415.27      24.2814    <1e-05
Weight         1   2471.22      2471.22     144.4943    <1e-19
Height         1    574.39       574.39      33.5851    <1e-07
Neck           1     96.85        96.85       5.6631    0.0194
Chest          1     47.71        47.71       2.7895    0.0984
Abdomen        1   1069.94      1069.94      62.5603    <1e-11
Ankle          1      0.4698       0.4698     0.0275    0.8687
Biceps         1      5.8672       5.8672     0.3431    0.5595
Wrist          1    125.65       125.65       7.3466    0.0080
(Residuals)   90   1539.23        17.10                 
──────────────────────────────────────────────────────────────



Analysis of Variance

Type 1 test / F test

Bodyfat ~ 1 + Age + Weight + Height + Neck + Abdomen + Wrist

Table:
────────────────────────────────────────────────────────────
             DOF    Exp.SS  Mean Square    F value  Pr(>|F|)
────────────────────────────────────────────────────────────
(Intercept)    1  34599.72     34599.72  2062.3598    <1e-64
Age            1    415.27       415.27    24.7529    <1e-05
Weight         1   2471.22      2471.22   147.3000    <1e-20
Height         1    574.39       574.39    34.2373    <1e-07
Neck           1     96.85        96.85     5.7730    0.0183
Abdomen        1   1112.19      1112.19    66.2932    <1e-11
Wrist          1    116.43       116.43     6.9400    0.0099
(Residuals)   93   1560.24        16.78               
────────────────────────────────────────────────────────────
=#

model3 = nestedmodels(LinearModel, @formula(Bodyfat ~ Age+Weight+Height+Neck+Chest+Abdomen+Ankle+Biceps+Wrist), data; dropcollinear = false)
anova(model3)

#= 
    Analysis of Variance

    Type 1 test / F test

    Model 1: Bodyfat ~ 0
    Model 2: Bodyfat ~ 1
    Model 3: Bodyfat ~ 1 + Age
    Model 4: Bodyfat ~ 1 + Age + Weight
    Model 5: Bodyfat ~ 1 + Age + Weight + Height
    Model 6: Bodyfat ~ 1 + Age + Weight + Height + Neck
    Model 7: Bodyfat ~ 1 + Age + Weight + Height + Neck + Chest
    Model 8: Bodyfat ~ 1 + Age + Weight + Height + Neck + Chest + Abdomen
    Model 9: Bodyfat ~ 1 + Age + Weight + Height + Neck + Chest + Abdomen + Ankle
    Model 10: Bodyfat ~ 1 + Age + Weight + Height + Neck + Chest + Abdomen + Ankle + Biceps
    Model 11: Bodyfat ~ 1 + Age + Weight + Height + Neck + Chest + Abdomen + Ankle + Biceps + Wrist

    Table:
    ──────────────────────────────────────────────────────────────────────────────────
        DOF  ΔDOF  Res.DOF      R²      ΔR²    Res.SS      Exp.SS    F value  Pr(>|F|)
    ──────────────────────────────────────────────────────────────────────────────────
    1     1             90  0                40946.31                           
    2     2     1       90  0        0        6346.59  34599.72    2023.0771    <1e-66
    3     3     1       90  0.0654   0.0654   5931.32    415.27      24.2814    <1e-05
    4     4     1       90  0.4548   0.3894   3460.10   2471.22     144.4943    <1e-20
    5     5     1       90  0.5453   0.0905   2885.71    574.39      33.5851    <1e-07
    6     6     1       90  0.5606   0.0153   2788.86     96.85       5.6631    0.0193
    7     7     1       90  0.5681   0.0075   2741.15     47.71       2.7895    0.0982
    8     8     1       90  0.7367   0.1686   1671.21   1069.94      62.5603    <1e-11
    9     9     1       90  0.7367  <1e-04    1670.74      0.4698     0.0275    0.8687
    10   10     1       90  0.7377   0.0009   1664.87      5.8672     0.3431    0.5595
    11   11     1       90  0.7575   0.0198   1539.23    125.65       7.3466    0.0080
    ──────────────────────────────────────────────────────────────────────────────────

=#