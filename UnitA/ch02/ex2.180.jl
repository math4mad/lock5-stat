#= 
 feature  ["Position", "Loft", "Sex", "Distance", "Speed"]
=#

## 1. load package
include("utils.jl")
using HypothesisTests,GLMakie,CSV,DataFrames,ScientificTypes
using Statistics,DataFramesMeta,Pipe

## 2. data processing
    desc=Lock5Table(138,"HomingPigeons","Who Is Faster: Hens or Cocks?",["Sex","Speed"])
    data= @pipe load_csv(desc.name)
    gdf=groupby(data,desc.feature[1])
    cats= @pipe keys(gdf).|>values(_)[1]

## 3. plot res

    function plot_boxplot()
        fig=Figure(resolution=(600,400))
        ax=Axis(fig[1,1];title="pigeon different speed ")
        Box(fig[1,1];color = (:orange,0.1),strokewidth=0.5)
        ax.xticks=(1:length(cats), [cats...])
        for (idx,df) in enumerate(gdf)
            n=nrow(df)
            boxplot!(ax,fill(idx,n),df.Speed)
        end
        fig
    end

    fig=plot_boxplot() 
    #save("./ch02/imgs/pigeon-speed-diff-sex.png",fig)