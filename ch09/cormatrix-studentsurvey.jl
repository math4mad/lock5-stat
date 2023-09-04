"""
page 648 SAT Scores: Math vs Verbal
data:StudentSurvey
"""

include("$(pwd())/utils.jl")

using GLMakie,CSV,DataFrames
using DataFramesMeta,Pipe,ColorSchemes



function plot_cormatrix(desc::Lock5Table,ma::Matrix)
    fig=Figure()
    ax=Axis(fig[1,1],yreversed=true)
    ax.xticks=(1:5,desc.feature)
    ax.yticks=(1:5,desc.feature)
    hm=heatmap!(ax,ma)
    Colorbar(fig[1, 2], hm)
    fig
    #save("./ch09/studentsurvey-cormatrix.png",fig)
end

desc=Lock5Table(648,"StudentSurvey","studentsuvey-cormatrix",["Exercise", "TV", "Height", "Weight","GPA"])

@pipe load_data(desc.name)|>select(_,desc.feature)|>Matrix|>cor|>plot_cormatrix(desc,_)