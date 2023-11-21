include("utils.jl")
using HypothesisTests,GLMakie,CSV,DataFrames,ScientificTypes,PrettyTables
using Statistics,DataFramesMeta,FreqTables,TableTransforms
desc=Lock5Table(113,"ICUAdmissions","description",[:ID,:Systolic,:HeartRate])
data= @pipe load_csv(desc.name)|>select(_,desc.feature)

standard_data=data|>Coerce(:Systolic=> Continuous,:HeartRate=> Continuous)|>ZScore(:Systolic,:HeartRate)
patient(id)=filter(row -> row.ID ==id,standard_data)

patient(772)
