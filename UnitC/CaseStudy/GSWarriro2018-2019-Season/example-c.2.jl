## 1. load package
include("../../../utils.jl")
include("./data-c.1.jl")

fta=data.FTA

m,s=mean_and_std(fta)
n=length(fta)

"""
    computing_ci(m,s,n,t=1.664;dig=2)

计算置信区间

Arguments 
m,s=mean_and_std
n: size of vector
t :zscore
dig 保留位数

"""
function computing_ci(m,s,n,t=1.664;dig=2)
     v=t*s/sqrt(n)
     return round(m-v,digits=dig),round(m+v,digits=dig)
end

computing_ci(m,s,n)  #(19.12, 21.66)

#quantile(Normal(),0.99)

