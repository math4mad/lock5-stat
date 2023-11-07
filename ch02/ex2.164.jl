include("utils.jl")
using HypothesisTests,GLMakie,CSV,DataFrames,ScientificTypes
using Statistics,DataFramesMeta,Pipe

desc=Lock5Table(134,"YoungBlood","年轻生物的血浆是对衰老的大脑是否有帮助?",[])
data= @pipe load_csv(desc.name) #|>select(_,desc.feature)
gdf=groupby(data,:Plasma)


function plot_res()
    
    fig=Figure()
    ax=Axis(fig[1,1];xlabel="Plasma",ylabel="Runtime", xticks = (1:2, ["Old","Young"]))
    Box(fig[1,1];color = (:orange,0.1),strokewidth=0.5)
    for (idx,df) in enumerate(gdf)
        cat=levels(df.Plasma)
        n=nrow(df)
        boxplot!(ax,fill(idx,n),df.Runtime,label=cat)
        
    end
    axislegend(ax)
    fig
end

fig=plot_res() #;save("./ch02/youngblood-ability.png",fig)