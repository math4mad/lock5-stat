include("utils.jl")
using HypothesisTests,GLMakie,CSV,DataFrames,ScientificTypes,PrettyTables
using Statistics,DataFramesMeta,FreqTables,TableTransforms
desc=Lock5Table(129,"StudentSurvey","description",[:Sex,:TV])
data= @pipe load_csv(desc.name)|>select(_,desc.feature)

gd=groupby(data,:Sex)
mgd= groupby(gd[1], :TV);
fgd= groupby(gd[2], :TV);

fig=Figure(resolution=(1000,900))
ax1=Axis(fig[1,1],xlabel="TV",ylabel="Count",title="male",limits = (0,40,0,35))
ax2=Axis(fig[2,1],xlabel="TV",ylabel="Count",title="female",limits = (0,40,0,35))
Box(fig[1,1];color = (:yellow,0.1),strokewidth=0.2)
Box(fig[2,1];color = (:yellow,0.1),strokewidth=0.2)

function plot(df,ax)
    xs=@pipe keys(df).|>values(_)[1]
    ys=[nrow(g) for g in df]

    for (idx, x) in enumerate(xs)
        for y in 1:ys[idx]
            scatter!(ax,x,y
            ;marker=:circle,markersize=14,color=(:lightgreen,0.5)
            ,strokewidth=1,strokecolor=:black)
        end
    end

end

plot_dotplot(mgd,ax1)
plot_dotplot(fgd,ax2)
fig