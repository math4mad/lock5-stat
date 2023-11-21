# 1. load package
include("../../utils.jl")


## 2. load data

desc=Lock5Table(468,"HomesForSaleCanton","Difference price of house",["Price"])
data=@pipe load_csv(desc.name)

## 3. dot plot
h=fit(Histogram,data.Price,nbins=10)
#fig=plot_dotplot(h);save("UnitC/ch06/ex-6.138-dotplot.png",fig)

