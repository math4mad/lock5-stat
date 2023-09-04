"""
page 537  Case Study: Golden State Warriors Free Throws
data:GSWarriors2019

"FTA": 罚球次数
"FT" : 投中罚球
"OppFTA" : 对手罚球
"OppFT"  :  对手投中的罚球
"""


include("$(pwd())/utils.jl")

using GLMakie,CSV,DataFrames,Pipe
using DataFramesMeta,StatsBase



str="GSWarriors2019"
feature=["FTA","FT","OppFTA","OppFT"]
data=@pipe load_data(str)|> select(_,feature)

# function plot_hist()
#     fig=Figure()
#     for (idx,f) in enumerate(feature)
#         local ax=Axis(fig[fldmod1(idx,2)...],title="feature=$f")
#         d=data[!,f]
#         hist!(ax,d)
#     end
#     fig
#     #save("$(pwd())/GSWarriro2018-2019-Season/imgs/hist.png",fig)
# end



