#= 
 chapter:ch06 
 lock5stat page 500
 Split the Bill?
 ttest results:
    point estimate:          0.708333
    95% confidence interval: (-1.553, 2.97)
    with 95% confidence: fail to reject h_0
=#

## 1. load package
include("../../utils.jl")
using UnicodePlots
## 2. data processing
    desc=Lock5Table(501,"SplitBill","Split the Bill?",["Sex","Cost"])
    df= @pipe load_csv(desc.name)

    gdf=groupby(df,desc.feature[1])
    cats= @pipe keys(gdf).|>values(_)[1] 
    data = [gdf[1].Cost, gdf[2].Cost]  

## 3. desc summary data

    summary_df = DataFrame(Group=cats,
    n=size.(data, 1),
    Mean=mean.(data),
    Stddev=std.(data)
    )
    @pt summary_df

    #= 
    ┌─────────┬───────┬─────────┬─────────┐
    │   Group │     n │    Mean │  Stddev │
    │ String1 │ Int64 │ Float64 │ Float64 │
    ├─────────┼───────┼─────────┼─────────┤
    │       F │    24 │ 44.4583 │ 15.4835 │
    │       M │    24 │   43.75 │ 14.8126 │
    └─────────┴───────┴─────────┴─────────┘
    =#

## 4. box plot
UnicodePlots.boxplot(cats, data, title="cost in different sex", xlabel="cost", ylabel="group")

#= 
 cost in different sex           
           ┌                                        ┐ 
             ╷         ┌───┬───────┐           ╷      
         F   ├─────────┤   │       ├───────────┤      
   group     ╵         └───┴───────┘           ╵      
            ╷             ┌──┬─┐           ╷          
         M  ├─────────────┤  │ ├───────────┤          
            ╵             └──┴─┘           ╵          
           └                                        ┘ 
            10                50                  90  
                              cost        
=#

## 5. pair ttest
pair_ttest(summary_df)
#= 
Two sample t-test (equal variance)
----------------------------------
Population details:
    parameter of interest:   Mean difference
    value under h_0:         0
    point estimate:          0.708333
    95% confidence interval: (-1.553, 2.97)

Test summary:
    outcome with 95% confidence: fail to reject h_0
    two-sided p-value:           0.5315

Details:
    number of observations:   [24,24]
    t-statistic:              0.6304494821459777
    degrees of freedom:       46
    empirical standard error: 1.1235370214315195
=#