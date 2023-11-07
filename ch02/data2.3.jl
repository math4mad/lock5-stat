#= 
   ICUAdmissions
 show(names(df))=>  ["ID", "Status", "Age", "Sex", "Race", "Service", "Cancer", "Renal", "Infection", "CPR", "Systolic", "HeartRate", "Previous", "Type", "Fracture", "PO2", "PH", "PCO2", "Bicarbonate", "Creatinine", "Consciousness"]
=#

include("../utils.jl")
using GLMakie, CSV, DataFrames, RCall

desc = Lock5Table(99, "ICUAdmissions", "mean", [])
df = @pipe load_csv(desc.name) 

## 1. example2.11 find mean of heart of rate in 20s,and 50s
# combine(_, :HeartRate=> median)
age20_median=@pipe df |>filter(:Age =>x->x==20, _)|>combine(_, :HeartRate=> median)
age20_mean=@pipe df |>filter(:Age =>x->x==20, _)|>combine(_, :HeartRate=> mean)
age55_median=@pipe df |>filter(:Age =>x->x==55, _)|>combine(_, :HeartRate=> median)
age55_mean=@pipe df |>filter(:Age =>x->x==55, _)|>combine(_, :HeartRate=> mean)

