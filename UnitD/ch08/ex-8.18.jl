#= 
 lock5stat page 595
 Does Synchronized Dancing Boost Feelings of Closeness?
=#

## 1. load package
include("../../utils.jl")

## 2. load data 
desc=Lock5Table(595,"SynchronizedMovement","Does Synchronized Dancing Boost Feelings of Closeness?",["Group","CloseDiff"])
df=@pipe load_csv(desc.name)
transform!(df,:CloseDiff=>ByRow(x->parse(Float64, x))=>:CloseDiff)
gdf=@pipe select(df,desc.feature)|>groupby(_,"Group")

cats= @pipe keys(gdf).|>values(_)[1] 
group_data=[df.CloseDiff for df in gdf ]


## 3. summary data 
summary_table=summary_df(cats,group_data);
@pt summary_table
#= 
┌─────────┬───────┬───────────┬─────────┐
│   Group │     n │      Mean │  Stddev │
│ String7 │ Int64 │   Float64 │ Float64 │
├─────────┼───────┼───────────┼─────────┤
│   HS+HE │    72 │  0.319444 │ 1.85249 │
│   LS+HE │    66 │  0.378788 │ 1.83777 │
│   HS+LE │    64 │  0.328125 │ 1.86066 │
│   LS+LE │    58 │ -0.431034 │ 1.62343 │
└─────────┴───────┴───────────┴─────────┘
=#


## 5. one way anova test
OneWayANOVATest(group_data...)
#= 
One-way analysis of variance (ANOVA) test
-----------------------------------------
Population details:
    parameter of interest:   Means
    value under h_0:         "all equal"
    point estimate:          NaN

Test summary:
    outcome with 95% confidence: reject h_0
    p-value:                     0.0413

Details:
    number of observations: [72, 66, 64, 58]
    F statistic:            2.78577
    degrees of freedom:     (3, 256)
=#

## 6. results
"""
p-value:                     0.0413
不同训练方式下的学生友谊程度有显著性差别
"""

UnicodePlots.boxplot(cats, group_data, title="sync-movement and clossness", xlabel="closediff", ylabel="methods")
#= 
sync-movement and clossness        
                 ┌                                        ┐ 
                           ╷       ┌─┬─┐       ╷            
           HS+HE           ├───────┤ │ ├───────┤            
                           ╵       └─┴─┘       ╵            
                             ╷       ┬─┐         ╷          
           LS+HE             ├───────│ ├─────────┤          
   methods                   ╵       ┴─┘         ╵          
                               ╷   ┌─┬───┐     ╷            
           HS+LE               ├───┤ │   ├─────┤            
                               ╵   └─┴───┘     ╵            
                         ╷         ┌─┐     ╷                
           LS+LE         ├─────────┤ ├─────┤                
                         ╵         └─┘     ╵                
                 └                                        ┘ 
                  -10                0                  10  
                                  closediff     
=#


