
#= 
  lock5stat page 487
=#

## 1. load package
include("../../utils.jl")

## 2. load data 
desc=Lock5Table(487,"ExerciseHours","can we ust t-dist?",["Sex","Exercise"])
data=@pipe load_csv(desc.name)|>select(_,desc.feature)|>groupby(_,desc.feature[1])
male_data=data[1]

## 3. dot plot of  male data 
    h=fit(Histogram,male_data.Exercise,nbins=12)
    #fig=plot_dotplot(h);save("UnitC/ch06/example-6.25-1.png",fig)



