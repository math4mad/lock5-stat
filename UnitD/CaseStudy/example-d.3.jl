#= 
lock5stat page 699
Are Cognitive Skills and Alcohol Use Related?
=#

## 1 load package
include("../../utils.jl")
import GLM: coef, predict,confint,ftest

## 2. load data
include("sleepstudy_data.jl")

gdf=@pipe select(data,[:CognitionZscore,:AlcoholUse])|>groupby(_,:AlcoholUse)
cats=cats= @pipe keys(gdf).|>values(_)[1]
group_data=[df.CognitionZscore for df in gdf]
summary_table=summary_df(cats,group_data)
#= 
┌──────────┬───────┬───────────┬──────────┐
│    Group │     n │      Mean │   Stddev │
│ String15 │ Int64 │   Float64 │  Float64 │
├──────────┼───────┼───────────┼──────────┤
│ Moderate │   120 │   -0.0785 │ 0.671372 │
│    Light │    83 │  0.130241 │ 0.748152 │
│  Abstain │    34 │ 0.0688235 │  0.71574 │
│    Heavy │    16 │  -0.23375 │ 0.646868 │
└──────────┴───────┴───────────┴──────────┘ 
=#

## 3 boxblot 
UnicodePlots.boxplot(cats, group_data, title="cogintion score with alchol use", xlabel="CognitionZscore", ylabel="AlcoholUse")

#= 
cogintion score with alchol use      
                       ┌                                        ┐ 
                           ╷          ┌────┬───┐          ╷       
              Moderate     ├──────────┤    │   ├──────────┤       
                           ╵          └────┴───┘          ╵       
                              ╷         ┌───┬────┐             ╷  
                 Light        ├─────────┤   │    ├─────────────┤  
   AlcoholUse                 ╵         └───┴────┘             ╵  
                           ╷            ┌──┬───┐         ╷        
               Abstain     ├────────────┤  │   ├─────────┤        
                           ╵            └──┴───┘         ╵        
                               ╷   ┌─────┬────┐    ╷              
                 Heavy         ├───┤     │    ├────┤              
                               ╵   └─────┴────┘    ╵              
                       └                                        ┘ 
                        -2                 0                   2  
                                     CognitionZscore  
=#


#OneWayANOVATest(group_data...)

#= 
One-way analysis of variance (ANOVA) test
-----------------------------------------
Population details:
    parameter of interest:   Means
    value under h_0:         "all equal"
    point estimate:          NaN

Test summary:
    outcome with 95% confidence: fail to reject h_0
    p-value:                     0.0790

Details:
    number of observations: [120, 83, 34, 16]
    F statistic:            2.2892
    degrees of freedom:     (3, 249)
=#

