"""
不同性别对奖项的统计
locks5 stat page 81

./imgs/student-award-like.jpg
"""

include("utils.jl")
using HypothesisTests,GLMakie,CSV,DataFrames,ScientificTypes,PrettyTables
using Statistics,Pipe,AlgebraOfGraphics,Distributions
str="StudentSurvey"
feature=[:Sex,:Award] 
data=@pipe load_data(str)|>select(_,feature)
  

#sex_cat=levels(data.Sex);award_cat=levels(data.Award)
#gdf=groupby(data,[:Sex,:Award])
academy=filter(row -> row.Award == "Academy", data)
nobel=filter(row -> row.Award == "Nobel", data)
olympic=filter(row -> row.Award == "Olympic", data)
c1= size.([groupby(academy,:Sex)...],1)
c2= size.([groupby(nobel,:Sex)...],1)
c3= size.([groupby(olympic,:Sex)...],1)

typename=["Male","Female","Total"]
df2=freq_table(DataFrame(Academy=c1,Nobel=c2,Olympic=c3);typename=typename)
#@pt df2

# 学生最希望获得哪个奖项
data2=df2[end,:]|>Array|>d->d[2:end]
cats=names(df2)[2:end-1]
res=[Symbol(c)=>data2[idx]/data2[end]|>d->round(d,digits=3) for (idx,c) in enumerate(cats)]
"""
:Academy => 0.09
   :Nobel => 0.4
 :Olympic => 0.5
"""
function plot_award()
    fig = Figure();
    ax = Axis(fig[1,1],xticks = (1:3,cats));
    barplot!(ax, [1,2,3],[30,131,164], color=:blue,label="F")
    barplot!(ax, [1,2,3],[11,63,100], color=:orange,label="M")
    axislegend(ax)
    fig
    #save("./imgs/sex-preferred-award.png",fig)
end
#plot_award()

function plot_frequency(df)
  set_aog_theme!()
  axis = (width = 225, height = 225)
  award_frequency =AlgebraOfGraphics.data(df) * frequency()*mapping(:Award)* mapping(color =:Sex,stack= :Sex)
  fg=draw(award_frequency; axis)
  #save("sex-preferred-award-3.png", fg, px_per_unit = 3)
end
#plot_frequency(data)

function plot_density()
 xs=Vector(range(-3,3,100))
 ys=pdf.(Normal(),xs)
 d=DataFrame(x=xs,y=ys)
 plt = AlgebraOfGraphics.data(d) * mapping(:x)
 draw(plt * visual(Scatter)) # plot as heatmap (the default)

end


