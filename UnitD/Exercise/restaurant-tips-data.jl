## 1. load package
include("../../utils.jl")


## 2. load data
#= 
 feature ["Bill", "Tip", "Credit", "Guests", "Day", "Server", "PctTip"]
=#
desc = Lock5Table(159, "RestaurantTips", "Bill-Tip-relation",[])
df = @pipe load_csv(desc.name)
features=["Bill", "Tip", "Credit", "Guests", "Day", "Server", "PctTip"]
