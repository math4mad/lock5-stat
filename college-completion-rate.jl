"""
page 197
data: CollegeScores4yr
"""
using .Utils
using GLMakie,CSV,DataFrames,GLMakie,LinearAlgebra
using GLM


str="CollegeScores4yr"
feature=["FacSalary","CompRate","Control"]
data=@pipe load_data(str)|>select(_,feature)
gdf=groupby(data,feature[3])
cats=keys(gdf)
college_type=@pipe cats.|>values(_)[1]
colors=[:blue,:red,:green]
markers=[:rect,:circle,:cross]
linestyles=[:dot,:dashdot,:dash]


function plot_res()
    fig=Figure(resolution=(1000,600))
    ax=Axis(fig[1,1])
    Box(fig[1, 1], color = (:orange,0.05))

    for (idx,data) in enumerate(gdf)
        local res=lm(@formula(CompRate~FacSalary), data)
        local xs=range(extrema(data[!,feature[1]])...,50)
        function f(x)
            input=[1,x]
            coef(res)'⋅input
        end
        scatter!(ax,data[!,1],data[!,2],marker=markers[idx],markersize=12,color=(colors[idx],0.2),strokewidth=2,strokecolor=:black,label="$(college_type[idx])")
        lines!(xs,f.(xs),color=colors[idx],linestyle=linestyles[idx],linewidth=4)
    end
    axislegend(ax)
    fig
    #save("college-completion-rate.png",fig)
end 
plot_res()