
include("./types.jl")  # struct
using  DataFrames,DataFramesMeta,CSV,NamedArrays,FreqTables,ScientificTypes
using  Pipe,ColorSchemes,PrettyTables
using  UnicodePlots,GLMakie
using  StatsBase,Combinatorics,HypothesisTests,Distributions,Bootstrap,AnovaBase,AnovaGLM
using  RCall
#export  load_data,freq_table,plot_pair_cor,pair_corletation, pair_data,Lock5Table,SingleSampleTTest,
#make_cor_ttest


"""
    load_data(str::String)
    读取 csv|>df|>dropmissing

"""
function load_data(str::String)
    fetch(str) = str |> d -> CSV.File("./data/$str.csv") |> DataFrame |> dropmissing
    #to_ScienceType(d)=coerce(d,:Condition=>Multiclass)
    df = fetch(str)
    return df
end

function load_csv(str::String,drop=true)
    fetch(str) = str |> d -> CSV.File("./data/$str.csv") |> DataFrame 
    #to_ScienceType(d)=coerce(d,:Condition=>Multiclass)
    df =drop ? fetch(str)|> dropmissing : fetch(str)
    return df
end



"""
    list_features(df::AbstractDataFrame)

列出 dataframe  names
"""
list_features(df::AbstractDataFrame) = show(names(df))::Nothing


"""
    freq_table(df;typename=nothing)
    返回 df 的列联表
    typename 为可选参数为第一列,表示列联表的目录项和合计
    typename=["Agree","Disagree","Don't know","Total"]
TBW
"""
function freq_table(df; typename=nothing)
    if typename === nothing
        typename = [["cat$i" for i in 1:size(df, 1)]..., "Total"]
    end
    transform!(df, (names(df)) => ByRow(+) => :Total)
    d = sum.(eachcol(df))
    push!(df, d)
    df.Type = typename
    df = select(df, [:Type, Symbol.(names(df[!, 1:end-1]))...])
    #@pt df
    return df
end


"""
    plot_pair_cor(df::AbstractDataFrame,save_imgs::Bool=false)
    两列 dataframe  plot cor
"""
function plot_pair_cor(df::AbstractDataFrame, save_imgs::Bool=false)
    name_arr = names(df)
    if length(name_arr) == 2
        fig = Figure()
        ax = Axis(fig[1, 1], title="$(name_arr[1])-$(name_arr[2])-Cor", xlabel="$(name_arr[1])", ylabel="$(name_arr[2])")
        Box(fig[1, 1], color=(:orange, 0.05))
        scatter!(ax, df[!, 1], df[!, 2], markersize=16, color=(:green, 0.1), strokewidth=3, strokecolor=:black)
        save_imgs && save("$(name_arr[1])_$(name_arr[2])_cor.png", fig)
        fig

    else
        @error "df must has two cols in pair plot"
    end

end



"""
    plot_cor_group(data::SubDataFrame)
    plot 多组配对属性scatter

"""
function plot_cor_group(data::SubDataFrame)
    cats = names(data)
    combinations_x = combinations(1:length(cats), 2)
    cbarPal = :thermal
    cmap = cgrad(colorschemes[cbarPal], length(combinations_x), categorical=true)
    fig = Figure(resolution=(900, 600))

    for (idx, c) in enumerate(combinations_x)
        local row, col = fldmod1(idx, 3)
        local ax = Axis(fig[row, col], xlabel=cats[c[1]], ylabel=cats[c[2]])
        Box(fig[row, col], color=(:orange, 0.1))
        scatter!(ax, data[!, c[1]], data[!, c[2]]; marker=:circle, markersize=12, color=(cmap[idx], 0.2), strokewidth=2, strokecolor=:black)
    end
    fig
    #save("./imgs/iris-scatter-plot.png",fig)
end



"""
    pair_corletation(data::AbstractDataFrame,dig::Int=2)
    从两列 df 计算相关系数
   参数 :

  -  data  为两列 DataFrame

  -   dig  为保留小数位
"""
pair_corletation(data::AbstractDataFrame, dig::Int=2) = @pipe data |> cor(_[!, 1], _[!, 2]) |> round(_, digits=dig)


"""
    pair_data(str::String,feature::Array)::AbstractDataFrame
    使用dataset 字符串和属性数组从 DataFrame中选择两列数据

"""
function pair_data(str::String, feature::Array{Union{String,Symbol},2})::AbstractDataFrame
    return @pipe load_data(str) |> select(_, feature)
end



"""
    plot_2feature_boxplot(gdf::GroupedDataFrame,title::String,feature::Union{Vector{String},Vector{Symbol}})
    
两个属性的 boxplot 

Arugments:

1. gdf:  GroupedDataFrame
2. title: plot name
3. feature 第一个 feature 为分组变量, 第二个为数值变量
"""
function plot_2feature_boxplot(gdf::GroupedDataFrame, title::String, feature::Union{Vector{String},Vector{Symbol}})
    cats = @pipe keys(gdf) .|> values(_)[1]
    fig = Figure(resolution=(600, 400))
    ax = Axis(fig[1, 1]; title=title)
    Box(fig[1, 1]; color=(:orange, 0.1), strokewidth=0.5)
    ax.xticks = (1:length(cats), [cats...])
    for (idx, df) in enumerate(gdf)
        n = nrow(df)
        boxplot!(ax, fill(idx, n), df[!, feature[2]])

    end
    fig
end

"""
xtick 目前工作不正常
"""
function plot_2feature_rotate_boxplot(gdf::GroupedDataFrame, title::String, feature::Union{Vector{String},Vector{Symbol}})
    cats = @pipe keys(gdf) .|> values(_)[1]
    fig = Figure(resolution=(600, 400))
    ax = Axis(fig[1, 1]; title=title)


    Box(fig[1, 1]; color=(:orange, 0.1), strokewidth=0.5)
    ax.yticks = (1:length(cats), [cats...])
    for (idx, df) in enumerate(gdf)
        n = nrow(df)
        plt = boxplot!(ax, fill(idx, n), df[!, feature[2]])
        rotate!(plt, -π / 2)
    end
    fig
end

"""
    peek(df::AbstractDataFrame)

show  first 5 row of  dataframe
"""
function peek(df::AbstractDataFrame)
    first(df, 5)
end


"""
ProportionTTest

params::Array :[observation,n,h0-rating]
 
"""
Base.@kwdef struct ProportionTTest
    page::Int
    name::AbstractString
    question::AbstractString
    params::Array
end


"""
    SingleSampleTTest(desc::Lock5Table,μ₀::Union{Int,Real})
    wrap SampleTTest

## params
    1. desc
       ```
       Base.@kwdef struct  Lock5Table
        page::Int
        name::AbstractString
        question:: AbstractString
        feature::Vector{AbstractString}
    end
       ```
    2. μ₀  总体假设均值

"""
function SingleSampleTTest(desc::Lock5Table, μ₀::Union{Int,Real})
    @pipe load_data(desc.name) |> select(_, desc.feature) |> Matrix |> _[:, 1] |> OneSampleTTest(_, μ₀)
end


"""
    make_cor_ttest(desc::Lock5Table)
    相关性 ttest  包装函数
    params:  desc::Lock5Table  ,feature 为两个属性

"""
function make_cor_ttest(desc::Lock5Table)
    if length(desc.feature) == 2
        @pipe load_data(desc.name) |> select(_, desc.feature) |> CorrelationTest(eachcol(_)...)
    else
        @error "cor_test must setting only two feature!"
    end

end


#end


"""
    make_ttest(desc::Lock5Table)

输入两列 dataframe,执行配对 t 检验
"""
function make_ttest(desc::Lock5Table)
    data = @pipe load_csv(desc.name) |> select(_, desc.feature) |> groupby(_, desc.feature[1])
    #cats=@pipe keys(data).|>values(_).|>_[1] #group1:yes,group2:no
    EqualVarianceTTest(data[1][!, desc.feature[2]], data[2][!, desc.feature[2]])
end

function plot_dotplot(h)
    fig = Figure()
    ax = Axis(fig[1, 1])
    xs = h.edges[1]
    ys = h.weights

    for (idx, x) in enumerate(xs[1:end-1])
        for y in 1:ys[idx]
            scatter!(ax, x, y
                ; marker=:circle, markersize=14, color=(:lightgreen, 0.5), strokewidth=1, strokecolor=:black)
        end
    end
    fig

end


function plot_dotplot(h,ax)
    
    xs = h.edges[1]
    ys = h.weights

    for (idx, x) in enumerate(xs[1:end-1])
        for y in 1:ys[idx]
            scatter!(ax, x, y
                ; marker=:circle, markersize=10, color=(:blue, 0.6), strokewidth=0.5, strokecolor=:black)
        end
    end
    

end



"""
    boot_sampling(data::Vector;method=mean,n=1000)

bootstrap sampling  wrap methods

Arguments:

- data:Vector
- methode from StatsBase
- n defalut=1000
"""
function boot_sampling(data::Vector;method=mean,n=1000)
    bootstrap(method, data, BasicSampling(n))
end



# function pair_group_dataframe(df::AbstractDataFrame,feature::Union{String,Symbol})
#     gdf=groupby(df,feature)
#     cats= @pipe keys(gdf).|>values(_)[1] 
#     data = [gdf[1].Cost, gdf[2].Cost]  
#     summary_df = DataFrame(Group=cats,
#     n=size.(data, 1),
#     Mean=mean.(data),
#     Stddev=std.(data)
#     )
#     return  summary_df
# end


"""
    pair_test(summary_df::AbstractDataFrame)
```julia
    gdf=groupby(df,feature)
    cats= @pipe keys(gdf).|>values(_)[1] 
    data = [gdf[1].Cost, gdf[2].Cost] 
    summary_df = DataFrame(Group=cats,
    n=size.(data, 1),
    Mean=mean.(data),
    Stddev=std.(data)
    )
```
    ┌────────────┬───────┬─────────┬─────────┐
    │      Group │     n │    Mean │  Stddev │
    │   String15 │ Int64 │ Float64 │ Float64 │
    ├────────────┼───────┼─────────┼─────────┤
    │ Individual │    24 │ 37.2917 │ 12.5368 │
    │      Split │    24 │ 50.9167 │ 14.3312 │
    └────────────┴───────┴─────────┴─────────┘
    使用 summary_dataframe 执行配对 t 检验
    dataframe 格式如上

"""
function pair_ttest(summary_df::AbstractDataFrame)
    nx, mx, vx = summary_df[1, 2:4]
    ny, my, vy = summary_df[2, 2:4]
    EqualVarianceTTest(Int(nx), Int(ny), mx, my, vx, vy)
end


"""
    summary_df(cats,group_data)

根据 dataframe 分组信息和分组数据返回 summary df(size, mean, stddev)
gdf=@pipe select(df,["Filling","Ants"])|>groupby(_,"Filling")
cats= @pipe keys(gdf).|>values(_)[1] 
group_data=[df.Ants for df in gdf ]
┌───────────────┬───────┬─────────┬─────────┐
│         Group │     n │    Mean │  Stddev │
│      String15 │ Int64 │ Float64 │ Float64 │
├───────────────┼───────┼─────────┼─────────┤
│      Vegemite │     8 │   30.75 │ 9.25434 │
│ Peanut Butter │     8 │    34.0 │ 14.6287 │
│ Ham & Pickles │     8 │   49.25 │ 10.7935 │
└───────────────┴───────┴─────────┴─────────┘
"""
function summary_df(cats,group_data)
    summary_df = DataFrame(Group=cats,
n=size.(group_data, 1),
Mean=mean.(group_data),
Stddev=std.(group_data)
)
end