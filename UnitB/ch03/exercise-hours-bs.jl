include("utils.jl")
using GLMakie,CSV,DataFrames,Random,StatsBase,PrettyTables,Pipe,TableTransforms,Bootstrap
using DataFramesMeta
desc=Lock5Table(287,"ExerciseHours","bootstrap sampling ",[:Sex,:Exercise])
data=@pipe load_data(desc.name)|>select(_,desc.feature)

gd = groupby(data, desc.feature[1])

@combine(gd, :average_exercise= mean(:Exercise))

