
## 1. load package
include("../../../utils.jl")
include("./data-c.1.jl")

## plot four stat's  dot 

function plot_dot_res(data)
    fig=Figure(resolution=(800,1200))
    axs=[Axis(fig[i,1]) for i in 1:4]
    linkyaxes!(axs...)
    for (idx,ax) in enumerate(axs)
        ax.title=desc.feature[idx]
        h=fit(Histogram,data[:,desc.feature[idx]])
        plt=plot_dotplot(h,ax)
    end
    fig
end
#save("UnitC/CaseStudy/GSWarriro2018-2019-Season/unitc-casestudy-example-c.1-dotplot.png",fig)
