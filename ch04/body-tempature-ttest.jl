
include("$(pwd())/utils.jl")
using HypothesisTests,GLMakie,CSV,DataFrames,Distributions
using StatsBase,DataFramesMeta,Pipe,Bootstrap,AlgebraOfGraphics


desc=Lock5Table(381,"BodyTemp50","Water pH vs mercury has negative relationship",["BodyTemp","Pulse","Sex"])

df=@pipe load_data(desc.name)

function plot_hist(df)

    set_aog_theme!()
    
    plt =AlgebraOfGraphics.data(df)*frequency()* mapping(:BodyTemp)
    fg=draw(plt*visual(Stem))  
    #save("bodytempature-bootstrap-sampling.png", fg, px_per_unit = 4) 
end

#plot_hist()

function  boot(df)
    n_boot=500
    
    local data=df
    bs(data) = bootstrap(mean,data, BasicSampling(n_boot))
    get_mean(data)=@pipe  bs(data)|>_.t1[1]|>mean
    res=[get_mean(data) for i  in  1:1000 ]
    return res
end
#res=boot(df[!,1])
#plot_hist((BodyTemp=res,))
f(x)=x>=98.27 ? true : false
#higherthan9827=filter(f,res)

df[!,1]|>mean
