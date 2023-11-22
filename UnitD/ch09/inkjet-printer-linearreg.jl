"""
喷墨打印机的价格是否与打印速度(PPM,每分钟打印页数)相关?

打印速度快的内在原因是喷墨喷头数多,这需要更快的CPU,更多的内存来处理数据,考虑到这一点, 速度越快, 价格应该越高

和mtcar 数据集一样, 如果我们有一组内存和 cpu的数据, 可以从这些属性上推断打印机的价格. 或者推断打印速度
"""

include("../../utils.jl")

desc=Lock5Table(617,"InkjetPrinters","predict laserjet printer price",[:PPM,:Price])
data= @pipe load_csv(desc.name)|>select(_,desc.feature)
    

function plot_raw_data()
    fig=Figure()
    ax=Axis(fig[1,1],xlabel="PPM",ylabel="Price",title="InkjetPrinter-linearreg")
    scatter!(ax,data[!,:PPM],data[!,:Price];markersize=12,color=(:lightgreen,0.2),
    strokecolor = :black, strokewidth =2)
    #save("inkjet-printer-ppm-price-scatter.png",fig)
    fig
end




X=data[!,:PPM]
y=data[!,:Price]


res=lm(@formula(Price ~ PPM), data)

xs=range(extrema(X)...,50)

function f(x)
    input=[1,x]
    coef(res)'⋅input
end

function plot_reg_data()
    fig=Figure()
    ax=Axis(fig[1,1],xlabel="PPM",ylabel="Price",title="InkjetPrinter-linearreg")
    scatter!(ax,data[!,:PPM],data[!,:Price];markersize=12,color=(:lightgreen,0.2),
    strokecolor = :black, strokewidth =2)
    lines!(ax, xs, f.(xs),label="fitting line")
    axislegend()
    #save("inkjet-printer-ppm-price-linearreg.png",fig)
    fig
end

plot_reg_data()


