"""
chapter:10
page 686  data-10.3
data:StatGrades

"""


## 1. load package

include("../../utils.jl")


## 2. load data

desc=Lock5Table(686,"StatGrades","predict final exame score",["Exam1", "Exam2", "Final"])
data=@pipe load_csv(desc.name)



