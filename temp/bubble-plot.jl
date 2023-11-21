"""
page 175
data :USStates
"""

using GLMakie,CSV,DataFrames,GLMakie,LinearAlgebra
using GLM


str="USStates"
feature=["College","HouseholdIncome","Population","Region"]
data=@pipe load_data(str)|>select(_,feature)
linreg_data=select(data,feature[1:2])
gdf=groupby(data,"Region")
cats= @pipe keys(gdf).|>values(_)[1]
cmap =[:green,:purple,:cyan,:red]


function  line_reg(data)
  res=lm(@formula(HouseholdIncome ~ College), data)
  xs=range(extrema(data[!,"College"])...,50)
  function f(x)
        input=[1,x]
        coef(res)'⋅input
  end

  return (xs,f)

   return 
end

xs,linearfun= line_reg(data)

function plot_bubble()
    fig=Figure()
    ax=Axis(fig[1,1];title="Bubble size: Population",xlabel="$(feature[1])",ylabel="$(feature[2])")
    Box(fig[1,1];color = (:orange,0.1),strokewidth=0.5)
    lines!(ax, xs, linearfun.(xs),label="fitting line",linestyle=:dot,color=:black,linewidth=6)
    for (idx,data) in enumerate(gdf)
        scatter!(ax,data[!,1],data[!,2],markersize=data[!,3].*5,color=(cmap[idx],0.2),strokewidth=3,strokecolor=:black,label="$(cats[idx])")
    end
    
    axislegend()
    fig
    #save("college-income-population-relation-2.png",fig)
end

plot_bubble()