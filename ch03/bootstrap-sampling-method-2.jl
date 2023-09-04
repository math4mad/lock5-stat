"""
using Bootstrap.jl 软件包 
page 273

"""


include("utils.jl")
using GLMakie,CSV,DataFrames,Random,PrettyTables,Pipe
using Bootstrap,StatsBase
using CategoricalArrays
#Random.seed!(3434343) 


# 获取分组数据:  csv|>dataframe

desc=Lock5Table(273,"BaseballSalaries2019","bootstrap sampling ",[:Name,:Salary])
data=@pipe load_data(str)|>select(_,feature[2])|>Array


"""
    samplen(data::Array,n::Int)
    从数组 data 中随机抽取一个样本, 样本容量为 n

"""
samplen(data::Array,n::Int)=@pipe data|>Vector(1:length(_))|>data[rand(_,n)]

n_boot = 500   #repeat sampling times


## basic bootstrap
cil = 0.95
data=[28.06 ,29.21, 28.43 ,28.97 ,29.95, 28.67, 30.57 ,29.22, 27.78, 29.58]
"""
    bs(data)
    bootstraping 包装方法
    bs(data) = bootstrap(mean,data, BasicSampling(n_boot))
"""
bs(data) = bootstrap(mean,data, BasicSampling(n_boot))
get_mean(data)=@pipe  bs(data)|>_.t1[1]|>mean|>round(_,digits=3)
res=[get_mean(data) for i  in  1:1000 ]

#fig,ax,pl=stephist(res,bins=100)
#save("bootstrap-distribution.png",fig)
#fig,ax,pl=GLMakie.density(res,npoints=100,color=(:green,0.5))

# function plot_density()
    
#     d=DataFrame(x=res)
#     plt = AlgebraOfGraphics.data(d) * mapping(:x)*AlgebraOfGraphics.density(npoints=50)
#     draw(plt * visual(Scatter)) # plot as heatmap (the default)
# end
# plot_density()

#bin_arr=cut(res,25)
#len=length(bin_arr)


#plot_bs()


h = fit(Histogram, res,nbins=20)
xs,freq=h.edges,h.weights

fig=Figure()
ax=Axis(fig[1,1])

function plot_bs()
    xs,freq=h.edges,h.weights
    len=length(freq)
    
    for i in 1:len
        local x=fill(xs[1][i],freq[i])
        local y=Vector(1:freq[i])
        scatter!(ax,x,y,markersize=14,marker=:diamond)
    end

    fig
end
#plot_bs()





