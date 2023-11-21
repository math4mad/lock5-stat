include("../../utils.jl")
using HypothesisTests,GLMakie,CSV,DataFrames,ScientificTypes,PrettyTables
using Statistics,DataFramesMeta,FreqTables
desc=Lock5Table(108,"AllCountries","birthrate dist shape",["BirthRate"])
data= @pipe load_csv(desc.name)|>select(_,desc.feature)
#fig,_,_=hist(data[:,1]);save("distribution-birth-rate.png",fig)

