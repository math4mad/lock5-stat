"""
Significance, P values and t-tests-nmeth.2698.pdf   figure3
t-student分布受到样本容量的影响, 一般比正态分布有更大的变异,当 n->∞时, t分布近似正态分布
"""


using GLMakie,Distributions,Pipe

ran=[3,4,5,10,20]
xs=range(-4,4,100)
d=Normal()
tdists=[TDist(n-1) for n in ran]

fig=Figure(resolution=(800,400))
ax1=Axis(fig[1,1])
ax2=Axis(fig[1,2],limits = (2,6,0,0.12))

function plot_l1()
    lines!(ax1,xs,pdf.(d,xs),label=L"normal",linestyle=:dot,linewidth=3)
    for i in 1:5
        lines!(ax1,xs,pdf.(tdists[i],xs),label=L"n=%$(i)",linewidth=4)
    end
    axislegend(ax1)
end

function plot_l2()
    ts=range(2,6,100)
    lines!(ax2,ts,pdf.(d,ts),label=L"normal",linestyle=:dot,linewidth=3)
    for i in 1:5
        lines!(ax2,ts,pdf.(tdists[i],ts),label=L"n=%$(ran[i])",linewidth=4)
    end
    axislegend(ax2)
end

plot_l1()
plot_l2()
fig
#save("normal-tdist.png",fig)