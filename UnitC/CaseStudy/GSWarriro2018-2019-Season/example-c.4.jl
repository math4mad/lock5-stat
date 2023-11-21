#= 
 lock5stat page 518
 由于在主客场,球员罚球的时候感受到的现场气氛和心理压力不同,所以罚球命中率可能会受到影响
 
=#

## 1. load package
include("../../../utils.jl")
include("./data-c.1.jl")


## 2.  make data
gdf=@pipe select(data,desc.feature)|>groupby(_,:Location)
cats= @pipe keys(gdf).|>values(_)[1] 
group_data= [gdf[1].FT, gdf[2].FT] 


## 3. desc summary data

summary_df = DataFrame(Group=cats,
n=size.(group_data, 1),
Mean=mean.(group_data),
Stddev=std.(group_data)
)
@pt summary_df
#= 
┌─────────┬───────┬─────────┬─────────┐
│   Group │     n │    Mean │  Stddev │
│ String7 │ Int64 │ Float64 │ Float64 │
├─────────┼───────┼─────────┼─────────┤
│    Home │    41 │ 16.4634 │ 5.56371 │
│    Away │    41 │ 16.1951 │  5.8276 │
└─────────┴───────┴─────────┴─────────┘
=#

## 4. plot box plot
UnicodePlots.boxplot(cats, group_data, title="ft in home and away", xlabel="ft", ylabel="group")
#= 
 ft in home and away            
              ┌                                        ┐ 
                 ╷          ┌──┬──┐          ╷           
         Home    ├──────────┤  │  ├──────────┤           
   group         ╵          └──┴──┘          ╵           
                  ╷       ┌────┬─┐         ╷             
         Away     ├───────┤    │ ├─────────┤             
                  ╵       └────┴─┘         ╵             
              └                                        ┘ 
               0                 20                  40  
                                  ft                    
=#

## 5. pair ttest
pair_ttest(summary_df)

## 6. ttest resutls
"""
    检验 h₀: 勇士队在主场和客场罚球得分上没有差别(差值为 0)
    value under h_0:         0
    point estimate:          0.268293
    95% confidence interval: (-0.7807, 1.317)
    with 95% confidence: fail to reject h_0
    wo-sided p-value:           0.6122
    0处于 95%置信区间内, pvalue>0.05 因此接受 0 假设: 主客场罚球得分没有差别
"""



