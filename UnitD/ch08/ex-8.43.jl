#= 
    lock5stat page 602
    Drug Resistant Pathogens 
    抗药性病菌对药物治疗是否有差异
=#

## 1. load package
include("../../utils.jl")

## 2. data 
desc=Lock5Table(602,"DrugResistance","",["Treatment", "Weight", "RBC","ResistantDensity","DaysInfectious"])
df=@pipe load_csv(desc.name)
cats=levels(df.Treatment)
features=desc.feature[2:end]

## 3. plot response variable boxplot

function plot_boxplots()
    fig=Figure(resolution=(900,600))
    for idx in 1:4
        gdf=@pipe select(df,["Treatment",features[idx]])|>groupby(_,"Treatment")
        cats = @pipe keys(gdf) .|> values(_)[1]
        ax=Axis(fig[fldmod1(idx,2)...])
        
        ax.xticks = (1:length(cats), [cats...])
        ax.ylabel="$(features[idx])"
        for (i, df) in enumerate(gdf)
            n = nrow(df)
            GLMakie.boxplot!(ax, fill(i, n), df[!, features[idx]])
    
        end
    
        
    end
    fig
end

#fig=plot_boxplots()#;save("UnitD/ch08/imgs/ex-8.43-4variables-boxplots.png",fig)





