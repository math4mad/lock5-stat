

## 1. load package
include("../../utils.jl")

##  2. load data 
dists=[Dist(8.0,10.5),Normal(4.9,1.25),Normal(12.6,4.8)]
narr=[50,8,10]
data=[]
for (dist,n) in zip(dists,narr)
     push!(data,rand(d,n))
end

function plot_res()
    fig=Figure(resolution=(900,300))
    axs=[Axis(fig[1,i]) for i in 1:3]
    linkyaxes!(axs...)
    for (idx,d) in enumerate(data)
        μ,σ=Distributions.params(dists[idx])
        axs[idx].title="n=$(narr[idx]),μ=$(μ),σ=$(σ)"
        local h=fit(Histogram,d)
        plot_dotplot(h,axs[idx])
    end
    fig
end

#fig=plot_res()#;save("./UnitC/ch06/example-6.11.png",fig)

