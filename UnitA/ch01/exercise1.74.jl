include("../../utils.jl")
using Random, DataFrames,Pipe,CSV
Random.seed!(343434)

desc=Lock5Table(53,"HollywoodMovies","random sample",[])

df=@pipe CSV.File("./data/$(desc.name).csv")|>DataFrame
row=size(df,1)
samples=(df[rand(1:row,5),:])