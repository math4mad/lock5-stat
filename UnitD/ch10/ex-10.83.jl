#= 
lockstat page 689
10.83 Predicting Opening Weekend Income of Hollywood Movies
feature ["Movie", "LeadStudio", "RottenTomatoes", "AudienceScore", "Genre", "TheatersOpenWeek", "OpeningWeekend", "BOAvgOpenWeekend", "Budget", "DomesticGross", "WorldGross", "ForeignGross", "Profitability", "OpenProfit", "Year"]
=#

## 1 load package
include("../../utils.jl")
import GLM: coef, predict,confint

## 2. load data
desc = Lock5Table(689, "HollywoodMovies", "Predicting Movie Openends Income", ["RottenTomatoes","AudienceScore","TheatersOpenWeek","Budget","Year","OpeningWeekend"])
data = @pipe load_csv(desc.name)|>select(_,desc.feature)

## 3. lin reg 
model1 = lm(@formula(OpeningWeekend~RottenTomatoes+AudienceScore+TheatersOpenWeek+Budget+Year),data)
ftest(model1.model)
#= 
┌ Info: 
│ StatsModels.TableRegressionModel{LinearModel{GLM.LmResp{Vector{Float64}}, GLM.DensePredChol{Float64, CholeskyPivoted{Float64, Matrix{Float64}, Vector{Int64}}}}, Matrix{Float64}}
│ 
│ OpeningWeekend ~ 1 + RottenTomatoes + AudienceScore + TheatersOpenWeek + Budget + Year
│ 
│ Coefficients:
│ ──────────────────────────────────────────────────────────────────────────────────────────────
│                           Coef.     Std. Error      t  Pr(>|t|)       Lower 95%      Upper 95%
│ ──────────────────────────────────────────────────────────────────────────────────────────────
│ (Intercept)       -216.974       645.804        -0.34    0.7370  -1484.19        1050.24
│ RottenTomatoes       0.137569      0.0330122     4.17    <1e-04      0.0727916      0.202346
│ AudienceScore        0.218443      0.0498527     4.38    <1e-04      0.12062        0.316265
│ TheatersOpenWeek     0.00821571    0.000604855  13.58    <1e-38      0.00702884     0.00940257
│ Budget               0.262258      0.0141661    18.51    <1e-65      0.234461       0.290055
│ Year                 0.0914318     0.320521      0.29    0.7755     -0.537502       0.720365
└ ──────────────────────────────────────────────────────────────────────────────────────────────
┌ Info: 
│ F-test against the null model:
└ F-statistic: 311.69 on 1056 observations and 5 degrees of freedom, p-value: <1e-99
=#


## 4 eliminate  Year feature
model2= lm(@formula(OpeningWeekend~RottenTomatoes+AudienceScore+TheatersOpenWeek+Budget),data)
#= 
OpeningWeekend ~ 1 + RottenTomatoes + AudienceScore + TheatersOpenWeek + Budget

Coefficients:
─────────────────────────────────────────────────────────────────────────────────────────
                         Coef.   Std. Error       t  Pr(>|t|)     Lower 95%     Upper 95%
─────────────────────────────────────────────────────────────────────────────────────────
(Intercept)       -32.754       2.79853      -11.70    <1e-29  -38.2454      -27.2627
RottenTomatoes      0.138771    0.0327279      4.24    <1e-04    0.0745516     0.20299
AudienceScore       0.217008    0.0495768      4.38    <1e-04    0.119728      0.314289
TheatersOpenWeek    0.00823269  0.000601654   13.68    <1e-38    0.00705211    0.00941327
Budget              0.262086    0.014147      18.53    <1e-65    0.234326      0.289845
─────────────────────────────────────────────────────────────────────────────────────────
=#
ftest(model2.model)
#= 
F-test against the null model:
F-statistic: 389.93 on 1056 observations and 4 degrees of freedom, p-value: <1e-99
=#

