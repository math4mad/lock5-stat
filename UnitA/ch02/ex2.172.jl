#= 
   feature =["Movie", "LeadStudio", "RottenTomatoes", "AudienceScore", "Genre", "TheatersOpenWeek", "OpeningWeekend", "BOAvgOpenWeekend", "Budget", "DomesticGross", "WorldGross", "ForeignGross", "Profitability", "OpenProfit", "Year"]
=#


## 1. load package
include("utils.jl")
using HypothesisTests,GLMakie,CSV,DataFrames,ScientificTypes
using Statistics,DataFramesMeta,Pipe

## 2. data processing
desc=Lock5Table(136,"HollywoodMovies","Do Audience Ratings Differ Based on the Genre of the Movie?",["Genre","AudienceScore"])
data= @pipe load_csv(desc.name)|>select(_,desc.feature)

gdf=groupby(data,"Genre")
cats= @pipe keys(gdf).|>values(_)[1]

## plot  boxplot 
function plot_boxplot()
    fig=Figure(resolution=(900,600))
    ax=Axis(fig[1,1];title="diffeent rating on AudienceScore",xticklabelrotation=0.4)
    Box(fig[1,1];color = (:orange,0.1),strokewidth=0.5)
    ax.xticks=(1:length(cats), [cats...])
    for (idx,df) in enumerate(gdf)
         n=nrow(df)
         boxplot!(ax,fill(idx,n),df.AudienceScore)
    end
    fig
end

fig=plot_boxplot()
#save("./ch02/imgs/hollywood-movie-genre-rating.png",fig)

