include("utils.jl")
using HypothesisTests,GLMakie,CSV,DataFrames,ScientificTypes,PrettyTables
using Statistics,DataFramesMeta,FreqTables
desc=Lock5Table(94,"MammalLongevity","dotplot ",["Animal","Longevity"])
data= @pipe load_csv(desc.name)|>select(_,desc.feature)

gd = groupby(data, desc.feature[2]);

xs=@pipe keys(gd).|>values(_)[1]
ys=[nrow(g) for g in gd]

function plot_dotplot()
    fig=Figure(resolution=(800,200))
    ax=Axis(fig[1,1],xlabel="Longevity",ylabel="Count")
    Box(fig[1,1];color = (:orange,0.1),strokewidth=0.2)

    for (idx, x) in enumerate(xs)
        for y in 1:ys[idx]
            scatter!(ax,x,y
            ;marker=:circle,markersize=14,color=(:lightgreen,0.5)
            ,strokewidth=1,strokecolor=:black)
        end
    end
fig
end
#fig=plot_dotplot();save("dotplot-longevity-mammals.png",fig)

