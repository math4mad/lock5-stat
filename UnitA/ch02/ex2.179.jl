#= 
 feature :["Name", "State", "ID", "Main", "Accred", "MainDegree", "HighDegree", "Control", "Region", "Locale", "Latitude", "Longitude", "AdmitRate", "MidACT", "AvgSAT", "Online", "Enrollment", "White", "Black", "Hispanic", "Asian", "Other", "PartTime", "NetPrice", "Cost", "TuitionIn", "TuitonOut", "TuitionFTE", "InstructFTE", "FacSalary", "FullTimeFac", "Pell", "CompRate", "Debt", "Female", "FirstGen", "MedIncome"]  
=#


## 1. load package
include("utils.jl")
using HypothesisTests,GLMakie,CSV,DataFrames,ScientificTypes
using Statistics,DataFramesMeta,Pipe

## 2. data processing
    desc=Lock5Table(138,"CollegeScores","Completion Rates at US Colleges – Graphi- cal",["Control","CompRate"])
    data= @pipe load_csv(desc.name)

    gdf=groupby(data,desc.feature[1])
    cats= @pipe keys(gdf).|>values(_)[1]

## plot res 

    function plot_boxplot()
        fig=Figure(resolution=(600,400))
        ax=Axis(fig[1,1];title="school type and comrate")
        Box(fig[1,1];color = (:orange,0.1),strokewidth=0.5)
        ax.xticks=(1:length(cats), [cats...])
        for (idx,df) in enumerate(gdf)
            n=nrow(df)
            boxplot!(ax,fill(idx,n),df.CompRate)
        end
        fig
    end
    fig=plot_boxplot()
    #save("./ch02/imgs/diff-school-comprate.png",fig)
    