#= 
 chapter:ch06 
 lock5stat page 500
 Split the Bill?
 ttest results:
  point estimate:          -13.625
    95% confidence interval: (-15.75, -11.5)
    95% confidence: reject h_0
=#

## 1. load package
include("../../utils.jl")
using UnicodePlots
## 2. data processing
    desc=Lock5Table(500,"SplitBill","Split the Bill?",["Payment","Cost"])
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
    ┌────────────┬───────┬─────────┬─────────┐
    │      Group │     n │    Mean │  Stddev │
    │   String15 │ Int64 │ Float64 │ Float64 │
    ├────────────┼───────┼─────────┼─────────┤
    │ Individual │    24 │ 37.2917 │ 12.5368 │
    │      Split │    24 │ 50.9167 │ 14.3312 │
    └────────────┴───────┴─────────┴─────────┘
  =#

## 4. box plot
UnicodePlots.boxplot(cats, data, title="cost in different payment", xlabel="cost", ylabel="group")
#= 
 cost in different payment         
                    ┌                                        ┐ 
                     ╷        ┌────┬──┐     ╷                  
         Individual  ├────────┤    │  ├─────┤                  
   group             ╵        └────┴──┘     ╵                  
                          ╷        ┌──┬──────┐          ╷      
              Split       ├────────┤  │      ├──────────┤      
                          ╵        └──┴──────┘          ╵      
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
    point estimate:          -13.625
    95% confidence interval: (-15.75, -11.5)

Test summary:
    outcome with 95% confidence: reject h_0
    two-sided p-value:           <1e-16

Details:
    number of observations:   [24,24]
    t-statistic:              -12.87727604428805
    degrees of freedom:       46
    empirical standard error: 1.058065382239252
=#

