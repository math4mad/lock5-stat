"""
page  180
data :DDS
"""

using GLMakie,CSV,DataFrames,GLMakie,LinearAlgebra
using GLM


str="DDS"
feature=["Ethnicity","Expenditures"]
data=@pipe load_data(str)|>select(_,feature)
gdf=groupby(data,:Ethnicity)
cats= @pipe keys(gdf).|>values(_)[1]
#cmap =[:green,:purple,:cyan,:red]

function plot_boxplot()
    fig=Figure(resolution=(1200,300))
    ax=Axis(fig[1,1],xlabel="ethnicity",ylabel="expenditures")
    ax.title="ethnic-expenditures"
    ax.xticks =(1:length(cats),cats)
    for (idx,df) in enumerate(gdf)
        row,col=size(df)
        boxplot!(ax, fill(idx,row),gdf[idx][:,"Expenditures"]; label = "$(cats[idx])")

    end
    fig
    save("ethnicity-expenditures.png",fig)
end

plot_boxplot()