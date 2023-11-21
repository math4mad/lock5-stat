"""
chapter:ch06
page 499  Mind-Set Matters
data:MindsetMatters

"""


## 1 load package
include("../../utils.jl")
using UnicodePlots

## 2. load data
desc = Lock5Table(499, "MindsetMatters", "MindsetMatters", ["Cond", "Wt", "Wt2"])
# 0:control, 1:experimental
df = @pipe load_csv(desc.name, false) |> select(_, desc.feature)
transform!(df, ["Wt2", "Wt"] => ByRow(-) => :WeightDiff)
gdf = groupby(df, :Cond)

data = [gdf[1].WeightDiff, gdf[2].WeightDiff]
##3.  desc table
Group = ["control", "experimental"]
summary_df = DataFrame(Group=Group,
    n=size.(data, 1),
    Mean=mean.(data),
    Stddev=std.(data)
)
@pt summary_df

#= 
┌──────────────┬───────┬──────────┬─────────┐
│        Group │     n │     Mean │  Stddev │
│       String │ Int64 │  Float64 │ Float64 │
├──────────────┼───────┼──────────┼─────────┤
│      control │    34 │     -0.2 │ 2.32079 │
│ experimental │    41 │ -1.78537 │ 2.88215 │
└──────────────┴───────┴──────────┴─────────┘
=#


UnicodePlots.boxplot(Group, data, title="Grouped Boxplot", xlabel="loss weight", ylabel="group")

#= 
     Grouped Boxplot              
                      ┌                                        ┐ 
                                 ╷     ┌──┬─┐       ╷            
              control            ├─────┤  │ ├───────┤            
   group                         ╵     └──┴─┘       ╵            
                       ╷          ┌────┬───┐     ╷               
         experimental  ├──────────┤    │   ├─────┤               
                       ╵          └────┴───┘     ╵               
                      └                                        ┘ 
                       -10                0                  10  
                                      loss weight                
=#

## 5. ttest

nx, mx, vx = summary_df[1, 2:4]
ny, my, vy = summary_df[2, 2:4]
EqualVarianceTTest(Int(nx), Int(ny), mx, my, vx, vy)

#= 
Two sample t-test (equal variance)
----------------------------------
Population details:
    parameter of interest:   Mean difference
    value under h_0:         0
    point estimate:          1.58537
    95% confidence interval: (0.8359, 2.335)

Test summary:
    outcome with 95% confidence: reject h_0
    two-sided p-value:           <1e-04

Details:
    number of observations:   [34,41]
    t-statistic:              4.215857411689027
    degrees of freedom:       73
    empirical standard error: 0.37604826227350574
=#


