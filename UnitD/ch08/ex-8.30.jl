#= 
LightatNight
lock5stat page 599
LD standard light/dark cycle, 
LL  bright light all the time,
DM  dim light when  normally  darkness.
=#

## 1. load package
include("../../utils.jl")

## 2. data 
## data 
desc=Lock5Table(599,"LightatNight4Weeks","anova",[])
table = NamedArray([10 7.859 3.009; 8 5.926 1.899;9 11.010 2.624], ( ["DM(reduce light at night)","LD(cut off light at night)","LL(always light)"], ["sample size", "mean","St.Dev"] ),("Level","Stat"))
#= 
3×3 Named Matrix{Float64}
              Level ╲ Stat │ sample size         mean       St.Dev
───────────────────────────┼──────────────────────────────────────
DM(reduce light at night)  │        10.0        7.859        3.009
LD(cut off light at night) │         8.0        5.926        1.899
LL(always light)           │         9.0        11.01        2.624
=#

