#= 
LightatNight
lock5stat page 599
LD standard light/dark cycle, 
LL  bright light all the time,
DM  dim light when  normally  darkness.
=#

## 1. load package
include("../../utils.jl")
using GLMakie
## 2.load  data 

desc=Lock5Table(599,"LightatNight4Weeks","anova",["Light", "BMGain"])
gdf=@pipe load_csv(desc.name)|>select(_,desc.feature)|>groupby(_,:Light)
cats= @pipe keys(gdf).|>values(_)[1] 
group_data=[df.BMGain for df in gdf ]


## 3. summary  data
s_df=summary_df(cats,group_data)
@pt s_df
#= 
┌─────────┬───────┬─────────┬─────────┐
│   Group │     n │    Mean │  Stddev │
│ String3 │ Int64 │ Float64 │ Float64 │
├─────────┼───────┼─────────┼─────────┤
│      LL │     9 │   11.01 │ 2.62399 │
│      DM │    10 │   7.859 │ 3.00929 │
│      LD │     8 │ 5.92625 │ 1.89942 │
└─────────┴───────┴─────────┴─────────┘
=#
sort!(s_df,:Mean)
@pt s_df
#= 
┌─────────┬───────┬─────────┬─────────┐
│   Group │     n │    Mean │  Stddev │
│ String3 │ Int64 │ Float64 │ Float64 │
├─────────┼───────┼─────────┼─────────┤
│      LD │     8 │ 5.92625 │ 1.89942 │
│      DM │    10 │   7.859 │ 3.00929 │
│      LL │     9 │   11.01 │ 2.62399 │
└─────────┴───────┴─────────┴─────────┘
=#


## side by side dotplot

function plot_dot_res()
    fig=Figure(resolution=(1200,600))
    axs=[Axis(fig[i,1]) for i in 1:3]
    linkyaxes!(axs...)
    for (idx,ax) in enumerate(axs)
        ax.title=cats[idx]
        h=fit(Histogram,group_data[idx])
        plt=plot_dotplot(h,ax)
        
    end
    fig
end

#fig=plot_dot_res()#; save("UnitD/ch08/imgs/ex-8.30-dotplot.png",fig)


