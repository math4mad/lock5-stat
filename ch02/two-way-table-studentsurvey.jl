
include("utils.jl")
using HypothesisTests,GLMakie,CSV,DataFrames,ScientificTypes,PrettyTables
using Statistics,DataFramesMeta
desc=Lock5Table(81,"StudentSurvey","studentsuvey two way table ",["Sex","Award"])
data= @pipe load_csv(desc.name)|>select(_,desc.feature)

function make_freqtable(data::AbstractDataFrame)
    academy=filter(row -> row.Award == "Academy", data)
    nobel=filter(row -> row.Award == "Nobel", data)
    olympic=filter(row -> row.Award == "Olympic", data)
    c1= size.([groupby(academy,:Sex)...],1)
    c2= size.([groupby(nobel,:Sex)...],1)
    c3= size.([groupby(olympic,:Sex)...],1)
    typename=["Male","Female","Total"]
    df=freq_table(DataFrame(Academy=c1,Nobel=c2,Olympic=c3);typename=typename)
    return df
end

function  print_freqtable(data::AbstractDataFrame)
    row,col=size(data)
    h1 = Highlighter(f= (data, i, j) -> i==row,crayon = crayon"red bold" )
    h2 = Highlighter(f= (data, i, j) -> j==col,crayon = crayon"blue bold" )
    pretty_table(data, highlighters =(h1,h2))
end

data|>make_freqtable|>print_freqtable