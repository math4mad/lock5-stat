# 1. load package
include("../../utils.jl")


## 2. load data

desc=Lock5Table(467,"HomesForSale","Difference price of house",["State", "Price", "Size", "Beds", "Baths"])
data=@pipe load_csv(desc.name)|>select(_,["State","Price"])
cats=levels(data.State)
gdf=groupby(data,"State")
df = DataFrame(State=[],n=[], Mean=[],Std_Dev=[])

for (idx,d) in enumerate(gdf)
    row_data=(State=cats[idx],n=size(d,1),Mean=mean(d.Price),Std_Dev=std(d.Price))
    push!(df,row_data)
    #@info row_data
end
#= 
┌───────┬─────┬─────────┬─────────┐
│ State │   n │    Mean │ Std_dev │
│   Any │ Any │     Any │     Any │
├───────┼─────┼─────────┼─────────┤
│    CA │  30 │ 535.367 │ 269.177 │
│    NJ │  30 │ 328.533 │ 157.973 │
│    NY │  30 │ 365.333 │ 317.822 │
│    PA │  30 │ 265.567 │ 137.089 │
└───────┴─────┴─────────┴─────────┘
=#

## 3. ttest
### 3.1 newyork price  equal  278k?
res1=OneSampleTTest(gdf[3].Price,278)
#= 
One sample t-test
-----------------
Population details:
    parameter of interest:   Mean
    value under h_0:         278
    point estimate:          365.333
    95% confidence interval: (246.7, 484.0)

Test summary:
    outcome with 95% confidence: fail to reject h_0
    two-sided p-value:           0.1431

Details:
    number of observations:   30
    t-statistic:              1.5050713704652983
    degrees of freedom:       29
    empirical standard error: 58.02604118788991
=#
#results:  fail to reject h_0

### 3.2 newjersy price  equal  278k?
res2=OneSampleTTest(gdf[2].Price,278)
#= 
 95% confidence interval: (269.5, 387.5)
 fail to reject h_0
=#


### 3.3 penny  price  equal  278k?
res3=OneSampleTTest(gdf[4].Price,278)
#= 
95% confidence interval: (214.4, 316.8)
outcome with 95% confidence: fail to reject h_0
=#

### 3.4 which stat has most evidence  unequal to 278k
("ny"=>pvalue(res1),"nj"=>pvalue(res2),"penny"=>pvalue(res3))



