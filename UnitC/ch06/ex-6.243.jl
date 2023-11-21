"""
chapter:ch06
page 499  exercise  enhance  anti-drepression
data:StressedMice

 
ttest results:
point estimate:          -207.0
 95% confidence interval: (-215.6, -198.4)
 outcome with 95% confidence: reject h_0
"""


## 1 load package
include("../../utils.jl")
using UnicodePlots

## 2. load data
desc = Lock5Table(499, "StressedMice", "exercise  enhance  anti-drepression", ["Time", "Environment"])
# 1:enriched, 2:standard
df = @pipe load_csv(desc.name, false) |> select(_, desc.feature) |> groupby(_, desc.feature[2])

data = [df[1].Time, df[2].Time]

##3.  desc table
Group = @pipe keys(df) .|> values(_)[1]
summary_df = DataFrame(Group=Group,
    n=size.(data, 1),
    Mean=mean.(data),
    Stddev=std.(data)
)
@pt summary_df
#= 
┌──────────┬───────┬─────────┬─────────┐
│    Group │     n │    Mean │  Stddev │
│ String15 │ Int64 │ Float64 │ Float64 │
├──────────┼───────┼─────────┼─────────┤
│ Enriched │     7 │ 231.714 │ 71.2267 │
│ Standard │     7 │ 438.714 │ 37.6816 │
└──────────┴───────┴─────────┴─────────┘
=#

## 4. box-plot
UnicodePlots.boxplot(Group, data, title="time in dark place", xlabel="time", ylabel="group")

#= 
  time in dark place             
                  ┌                                        ┐ 
                      ╷    ┌───┬──┐         ╷                
         Enriched     ├────┤   │  ├─────────┤                
   group              ╵    └───┴──┘         ╵                
                                               ╷ ┌──┬──┐ ╷   
         Standard                              ├─┤  │  ├─┤   
                                               ╵ └──┴──┘ ╵   
                  └                                        ┘ 
                   100               300                500  
                                     time           
=#


## 5. pair ttest
nx, mx, vx = summary_df[1, 2:4]
ny, my, vy = summary_df[2, 2:4]
EqualVarianceTTest(Int(nx), Int(ny), mx, my, vx, vy)

#= 
Two sample t-test (equal variance)
----------------------------------
Population details:
    parameter of interest:   Mean difference
    value under h_0:         0
    point estimate:          -207.0
    95% confidence interval: (-215.6, -198.4)

Test summary:
    outcome with 95% confidence: reject h_0
    two-sided p-value:           <1e-14

Details:
    number of observations:   [7,7]
    t-statistic:              -52.47940404269733
    degrees of freedom:       12
    empirical standard error: 3.9444045483364185
=#