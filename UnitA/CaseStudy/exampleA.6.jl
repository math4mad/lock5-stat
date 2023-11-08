## 1. load package
include("../../utils.jl")
using FreqTables,StatsBase
## 2. load data
desc = Lock5Table(203, "SleepStudy", "histogram of DAS scores", ["DASScore","Stress","LarkOwl","AlcoholUse","PoorSleepQuality","CognitionZscore"])
df = @pipe load_csv(desc.name)|>select(_,"DASScore")
stat=summarystats(df.DASScore)

##  3. freq
    function plot_hist()
        fig,ax,_=hist(df.DASScore;strokewidth=1,strokecolor=:black,axis = (; title = "DASScore histrogram", xlabel = "DASScore",ylabel="Frequency"))
        vlines!(ax,[res.mean],label="mean",linestyle=:dot,linewidth=3)
        vlines!(ax,[res.median],label="median",linestyle=:dash,linewidth=3)
        axislegend(ax)
        fig
    end
    fig=plot_hist()
    #save("DASScore-histrogram-2.png",fig)
    
##  4. 82 zscore
    @info "82 zscore"=>zscore([82], 20.04, 16.54)
    # [ Info: "82 zscore" => [3.7460701330108828]

