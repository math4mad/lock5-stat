include("../utils.jl")
using HypothesisTests,GLMakie,CSV,DataFrames,ScientificTypes,PrettyTables
using Statistics,DataFramesMeta
desc=Lock5Table(81,"StudentSurvey","studentsuvey two way table ",["Pulse","Exercise","Piercings"])
data= @pipe load_csv(desc.name)|>select(_,desc.feature)
#show(names(data))  #["Year", "Sex", "Smoke", "Award", "HigherSAT", "Exercise", "TV", "Height", "Weight", "Siblings", "BirthOrder", "VerbalSAT", "MathSAT", "SAT", "GPA", "Pulse", "Piercings"]



function plot_hist()
    fig=Figure(resolution=(900,300))
   
    for (idx, fe) in enumerate(desc.feature)
         ax=Axis(fig[1,idx];xlabel="$fe",ylabel="frequency")
         hist!(ax,data[:,fe];color=:green,strokewidth = 1, strokecolor = :black)
    end
    fig
end
#fig=plot_hist()
#save("./ch02/imgs/3-histograms-studentsurveydata.png",fig)

function plot_density()
    fig=Figure(resolution=(900,300))
   
    for (idx, fe) in enumerate(desc.feature)
         ax=Axis(fig[1,idx];xlabel="$fe",ylabel="frequency")
         density!(ax,data[:,fe];color=(:green,0.05),strokewidth = 2, strokecolor=:green)
    end
    fig
end

fig=plot_density();save("./ch02/imgs/3-density-studentsurveydata.png",fig)