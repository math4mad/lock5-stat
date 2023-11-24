## 1 load package
include("../../utils.jl")

## 2. load data 
desc=Lock5Table(708,"HomesForSale","Difference price of house",["State", "Price", "Size", "Beds", "Baths"])
df=@pipe load_csv(desc.name)|>select(_,["State","Price"])
gdf=groupby(df,:State)


