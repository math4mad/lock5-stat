#= 
LightatNight
lock5stat page 600
LD standard light/dark cycle, 
LL  bright light all the time,
DM  dim light when  normally  darkness.
或许小鼠增重是因为在长时间光照条件下有更多的进食时间,从而摄入更多的事物

=#

## 1. load package
include("../../utils.jl")

## 2.load  data 

desc=Lock5Table(599,"LightatNight4Weeks","anova",["Light", "Corticosterone"])
df=@pipe load_csv(desc.name)

## 3. anova test
#anova_lm(@formula(Corticosterone~Light), df)

