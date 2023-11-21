"""
matrix  高亮显示
"""

include("utils.jl")
using DataFrames, DataFramesMeta,PrettyTables
x1=[1,0,0]
x2=[0,1,0]
x3=[0,0,1]
data=DataFrame(c1=x1,c2=x2,c3=x3)

h1 = Highlighter(f= (data, i, j) -> i==j,crayon = crayon"red bold" )
#h1 = Highlighter(f= (data, i, j) -> i==j,crayon=Crayon(background = :red) )
pretty_table(data;tf=tf_matrix,show_header = false,highlighters =h1)
