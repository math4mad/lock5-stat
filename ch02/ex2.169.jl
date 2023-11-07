#= 
   feature =["Movie", "LeadStudio", "RottenTomatoes", "AudienceScore", "Genre", "TheatersOpenWeek", "OpeningWeekend", "BOAvgOpenWeekend", "Budget", "DomesticGross", "WorldGross", "ForeignGross", "Profitability", "OpenProfit", "Year"]
=#


## 1. load package
    include("utils.jl")
    using HypothesisTests,GLMakie,CSV,DataFrames,ScientificTypes
    using Statistics,DataFramesMeta,Pipe

## 2. data processing
    desc=Lock5Table(135,"HollywoodMovies","How Profitable Are Hollywood Movies?",["Profitability"])
    data= @pipe load_csv(desc.name)|>select(_,desc.feature)
    n=nrow(data)

## 3. plot data
    function plot_res()
        fig=Figure()
        ax=Axis(fig[1,1],title="hollywood movie profitablity")
        Box(fig[1,1];color = (:orange,0.1),strokewidth=0.5)
        boxplot!(ax, fill(1,n),data.Profitability)
        fig
    end

    #fig=plot_res()
    #save("./ch02/imgs/hollywood movie profitability.png",fig)

## 4. data anlysis
summary_df=@chain data begin
    @combine :mean=mean(data.Profitability)
    @combine :median=median(data.Profitability)

end


