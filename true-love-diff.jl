"""
不同性别对真爱的认识
locks5 stat page 79

./imgs/true-love-diff.jpg
"""

include("utils.jl")
using HypothesisTests,GLMakie,CSV,DataFrames,ScientificTypes,PrettyTables
using Statistics

df=(let
c2=[372,807,34];c3=[363,1005,44]
typename=["Agree","Disagree","Don't know","Total"]
df=freq_table(DataFrame(Male=c2,Female=c3);typename=typename)
df end)

"""
df 中每一行是一种态度, 每列是性别, 最外围是 marginal total
计算不同态度使用行,
计算不同性别比例使用列
"""

# 女性中相信有真爱的比例(条件概率,总体为表中所有女性)
select(df,:Female)|>Array|>d->d[1]/d[4]|>d->round(d,digits=2)
#0.26

# 相信真爱的人里女性的比例
filter(row -> row.Type == "Agree", df)|>d->d[1,:Female]/d[1,:Total]|>d->round(d,digits=2)
#0.49

#男性中相信有真爱的比例(条件概率,总体为表中所有男性)
select(df,:Male)|>Array|>d->d[1]/d[4]|>d->round(d,digits=2)
#0.31

#女性在调查中所占比例
filter(row -> row.Type == "Total", df)|>d->d[1,:Female]/d[1,:Total]|>d->round(d,digits=2)
#0.54



