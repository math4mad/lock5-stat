#= 
  feature  ["State", "HouseholdIncome", "Region", "Population", "EighthGradeMath", "HighSchool", "College", "IQ", "GSP", "Vegetables", "Fruit", "Smokers", "PhysicalActivity", "Obese", "NonWhite", "HeavyDrinkers", "Electoral", "ClintonVote", "Elect2016", "TwoParents", "StudentSpending", "Insured"]
=#

## 1. load package
    include("utils.jl")
    using HypothesisTests,GLMakie,CSV,DataFrames,ScientificTypes
    using Statistics,DataFramesMeta,Pipe

## 2. data processing
    desc=Lock5Table(136,"USStates","Physical Activity by Region of the Country in the US",["State","Region","PhysicalActivity"])
    data= @pipe load_csv(desc.name)|>select(_,desc.feature)
    
    gdf=groupby(data,desc.feature[2])
    cats= @pipe keys(gdf).|>values(_)[1]

## 3.  plot  boxplot 
    function plot_boxplot()
        fig=Figure(resolution=(600,400))
        ax=Axis(fig[1,1];title="physical activity in different region ",xticklabelrotation=0.4)
        Box(fig[1,1];color = (:orange,0.1),strokewidth=0.5)
        ax.xticks=(1:length(cats), [cats...])
        for (idx,df) in enumerate(gdf)
            n=nrow(df)
            boxplot!(ax,fill(idx,n),df.PhysicalActivity)
        end
        fig
    end

    fig=plot_boxplot() 
    #save("./ch02/imgs/physicalactivity-in-different-region.png",fig)  


