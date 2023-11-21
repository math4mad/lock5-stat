
include("utils.jl")
using HypothesisTests,GLMakie,CSV,DataFrames,ScientificTypes,PrettyTables
using Statistics,DataFramesMeta,FreqTables
desc=Lock5Table(81,"StudentSurvey","studentsuvey two way table ",["Sex","Award"])
data= @pipe load_csv(desc.name)|>select(_,desc.feature)

ft = freqtable(df, :Sex, :Award)
