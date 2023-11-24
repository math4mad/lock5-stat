

## 1. load package
include("../../utils.jl")

## 2. load data
desc=Lock5Table(685,"ForestFires","predict  forest fire  area ",["Wind","Temp","RH","Rain","Area"])
data=@pipe load_data(desc.name)|>select(_,desc.feature)


## 3. fit linear regression
model=lm(@formula(Area ~ Wind+Temp+RH+Rain), data)





