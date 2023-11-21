"""
page 537  Case Study: Golden State Warriors Free Throws
data:GSWarriors2019
"Location" : home or away
"FTA": 罚球次数
"FT" : 投中罚球
"OppFTA" : 对手罚球
"OppFT"  : 对手投中的罚球
"""


include("../../../utils.jl")

"""
"FTA": 罚球次数
"FT" : 投中罚球
"OppFTA" : 对手罚球
"OppFT"  : 对手投中的罚球
"""
desc=Lock5Table(537,"GSWarriors2019","statistics",["Location","FTA","FT","OppFTA","OppFT"])
data=@pipe load_csv(str)


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






