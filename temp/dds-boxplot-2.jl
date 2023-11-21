"""
page  180
data :DDS
"""

using GLMakie,CSV,DataFrames,GLMakie,LinearAlgebra
using GLM,Pipe


str="DDS"
feature=["Ethnicity","Expenditures","AgeCohort"]
data=@pipe load_data(str)|>select(_,feature)
hw=filter(row -> row["Ethnicity"] in ["Hispanic","White not Hispanic"], data)
gdf=groupby(hw,[:AgeCohort,:Ethnicity])
cats=keys(gdf)
ages=@pipe cats.|>values(_)[1]|>unique
ethcs=@pipe cats.|>values(_)[2]
groupsize=length(cats)

function plot_boxplot()
    fig=Figure(resolution=(1600,300))
    ax=Axis(fig[1,1],xlabel="ethnicity",ylabel="expenditures",xticklabelrotation=0.2)
    #ax.title="ethnic-expenditures"
    ax.xticks =(1:groupsize,ethcs)
    for (idx,df) in enumerate(gdf)
        row,col=size(df)
        boxplot!(ax, fill(idx,row),gdf[idx][:,"Expenditures"]; label = "$(cats[idx])")
        
    end
    vlines!(ax,[2.5,4.5,6.5,8.5,10.5])
    ax2 = Axis(fig[1, 1], xaxisposition = :top)
    ax2.xticks =([1,2.5,4.5,6.5,8.5,10.5],ages)
    fig
    save("ethnicity-expenditures-2.png",fig)
end

plot_boxplot()


