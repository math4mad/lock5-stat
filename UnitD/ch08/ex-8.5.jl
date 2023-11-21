#= 
 lock5stat page 588
=#

## 1. load package
include("../../utils.jl")

## 2. load data
  desc=Lock5Table(588,"StudentSurvey","希望获得不同成就的学生脉搏是否有差异?",["Award","Pulse"])
  df=@pipe load_csv(desc.name,false)
  gdf=@pipe select(df,desc.feature)|>groupby(_,"Award")
  cats= @pipe keys(gdf).|>values(_)[1] 
  group_data=[df.Pulse for df in gdf ]

## 3. summary data

summary_table=summary_df(cats,group_data);
@pt summary_table
#= 
┌─────────┬───────┬─────────┬─────────┐
│   Group │     n │    Mean │  Stddev │
│ String7 │ Int64 │ Float64 │ Float64 │
├─────────┼───────┼─────────┼─────────┤
│ Olympic │   182 │ 67.2527 │ 10.9707 │
│ Academy │    31 │ 70.5161 │ 12.3582 │
│   Nobel │   149 │ 72.2148 │ 13.0909 │
└─────────┴───────┴─────────┴─────────┘
=#

## 4. anova 
function anova_test()
    OneWayANOVATest(group_data...)
  
end
anova_test()

#= 
  One-way analysis of variance (ANOVA) test
-----------------------------------------
Population details:
    parameter of interest:   Means
    value under h_0:         "all equal"
    point estimate:          NaN

Test summary:
    outcome with 95% confidence: reject h_0
    p-value:                     0.0008

Details:
    number of observations: [182, 31, 149]
    F statistic:            7.32546
    degrees of freedom:     (2, 359)
=#

## 5. boxplot
UnicodePlots.boxplot(cats, group_data, title="different pluse", xlabel="pluse", ylabel="group")
#= 
  figure8.5
  different pluse              
                 ┌                                        ┐ 
                   ╷         ┌──┬──┐       ╷                
         Olympic   ├─────────┤  │  ├───────┤                
                   ╵         └──┴──┘       ╵                
                      ╷        ┌─┬─┐       ╷                
   group Academy      ├────────┤ │ ├───────┤                
                      ╵        └─┴─┘       ╵                
                     ╷         ┌──┬──┐                   ╷  
           Nobel     ├─────────┤  │  ├───────────────────┤  
                     ╵         └──┴──┘                   ╵  
                 └                                        ┘ 
                  30                80                 130  
                                    pluse            
=#


## 6. results
   #= 
    p-value:                     0.0008
    因此有充分的证据显示期望获得不同成绩的学生组之家的脉搏显著不同
   =#


   