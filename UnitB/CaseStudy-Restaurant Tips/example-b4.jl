## 1. load package
include("./data.jl")
import UnicodePlots:densityplot
using GLM,StatsBase,UnicodePlots,GLMakie
#Random.seed!(343434)

n_boot = 157;cil = 0.95;
#bs1 = bootstrap(mean, data.Tip, BasicSampling(n_boot))
#bci1 = confint(bs1, BasicConfInt(cil))
slopes=Vector{Float64}(undef, 100)

for i in 1:100
    local idx=rand(1:157,100)
    rand_data=data[idx,desc.feature[1:2]]
    model=lm(@formula(Tip ~ Bill), rand_data)
    slopes[i]=coef(model)[2]
    
    

end
histogram(slopes)

"""
   [0.16, 0.17) ┤██████████████▎ 13                        
   [0.17, 0.18) ┤████████████████████████████████████  33  
   [0.18, 0.19) ┤██████████████████████████████████▊ 32    
   [0.19, 0.2 ) ┤██████████████▎ 13                        
   [0.2 , 0.21) ┤█████▌ 5                                  
   [0.21, 0.22) ┤████▍ 4                                   
                └                                        ┘ 
                                 Frequency  
"""




h = fit(Histogram, slopes, nbins=15)

function plot_dotplot(h)
    fig=Figure()
    ax=Axis(fig[1,1])
    xs=h.edges[1]
    ys=h.weights
    
    for (idx, x) in enumerate(xs[1:end-1])
        for y in 1:ys[idx]
            scatter!(ax,x,y
            ;marker=:circle,markersize=14,color=(:lightgreen,0.5)
            ,strokewidth=1,strokecolor=:black)
        end
    end
    fig

end
fig=plot_dotplot(h)


