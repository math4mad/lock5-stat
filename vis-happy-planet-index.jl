"""
page 184
data="HappyPlanetIndex"
"""

include("utils.jl")

using GLMakie,CSV,DataFrames
using DataFramesMeta,StatsBase
using GLM,LinearAlgebra,ColorSchemes


str="HappyPlanetIndex"
feature=["Footprint","Happiness","Region"]

data=@pipe load_data(str)|>select(_,feature)
gdf=groupby(data,["Region"])
cats=keys(gdf)
regions=@pipe cats.|>values(_)[1]
markers=[:circle,:rect,:diamond,:hexagon,:cross,:ltriangle,:pentagon]
cbarPal = :thermal
cmap = cgrad(colorschemes[cbarPal], length(regions), categorical = true)
conts=["Latin America","Western nations", "Middle East", "Sub-Saharan Africa","South Asia","East Asia"," former Communist countries"]
function plot_raw_data()
    fig=Figure(resolution=(1000,600))
    ax=Axis(fig[1,1],xlabel="Ecological Footprint",ylabel="Happiness")
    for (idx,df) in enumerate(gdf)
        scatter!(ax,df[!,1],df[!,2],marker=markers[idx],label="$(conts[idx])",markersize=18,color=(cmap[idx],0.9),strokewidth=2,strokecolor=:black)
    end
    axislegend(position = :rb)
    fig
    
end

plot_raw_data()