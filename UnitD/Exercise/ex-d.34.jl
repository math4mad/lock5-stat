## 1 load package
include("../../utils.jl")

## 2. load data 
desc=Lock5Table(708,"HomesForSale","Difference price of house",["State", "Price", "Size", "Beds", "Baths"])
df=@pipe load_csv(desc.name)|>select(_,["State","Price"])
gdf=groupby(df,:State)
cats= @pipe keys(gdf).|>values(_)[1] 
group_data=[d.Price for d in gdf]
ny_data=filter(:State=>==("NY"),df)



## 3. feq of price  
histogram(ny_data.Price;nbins=10)
#= 
     Frequency                 

                    ┌                                        ┐ 
   [   0.0,  200.0) ┤████████████████████████████████████  14  
   [ 200.0,  400.0) ┤████████████████████▌ 8                   
   [ 400.0,  600.0) ┤█████▎ 2                                  
   [ 600.0,  800.0) ┤██▌ 1                                     
   [ 800.0, 1000.0) ┤███████▋ 3                                
   [1000.0, 1200.0) ┤██▌ 1                                     
   [1200.0, 1400.0) ┤██▌ 1                                     
                    └                                        ┘ 
                                     Frequency     
=#


## 4. summary df 
summary_table=summary_df(cats, group_data)

#= 
┌─────────┬───────┬─────────┬─────────┐
│   Group │     n │    Mean │  Stddev │
│ String3 │ Int64 │ Float64 │ Float64 │
├─────────┼───────┼─────────┼─────────┤
│      CA │    30 │ 535.367 │ 269.177 │
│      NJ │    30 │ 328.533 │ 157.973 │
│      NY │    30 │ 365.333 │ 317.822 │
│      PA │    30 │ 265.567 │ 137.089 │
└─────────┴───────┴─────────┴─────────┘
=#




