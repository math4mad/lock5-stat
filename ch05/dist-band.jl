using Distributions,GLMakie

d=Normal(80,10)
xs=Vector(range(50,110,100))

fig=Figure()
ax=Axis(fig[1,1])
lines!(ax, xs, pdf.(d,xs))
fig
#ave("significance-levels.png",fig) 
