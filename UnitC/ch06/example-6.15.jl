# 1. load package
include("../../utils.jl")


## 2. load data

desc=Lock5Table(457,"ManhattanApartments"," price of a one-bedroom apartment in Manhattan",["Rent"])
data=@pipe load_csv(desc.name)

## 3. plot dot 
h=fit(Histogram,data.Rent,nbins=20)
#fig=plot_dotplot(h)#;save("UnitC/ch06/example-6-15.png",fig)