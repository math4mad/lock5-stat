include("utils.jl")
using HypothesisTests,GLMakie,CSV,DataFrames,ScientificTypes,PrettyTables
using Statistics,DataFramesMeta,FreqTables
desc=Lock5Table(100,"ICUAdmissions","description",["Age","HeartRate"])
data= @pipe load_csv(desc.name)|>select(_,desc.feature)

heart_of_age=(age)->@pipe filter(row -> row.Age==age, data)|>_[:,:HeartRate]

("hr_age20_mean"=>heart_of_age(20)|>mean,"hr_age20_median"=>heart_of_age(20)|>median,
"hr_age55_mean"=>heart_of_age(55)|>mean,"hr_age55_median"=>heart_of_age(55)|>median,
)
#("hr_age20_mean" => 82.2, "hr_age20_median" => 80.0, "hr_age55_mean" => 108.5, "hr_age55_median" => 106.0)
