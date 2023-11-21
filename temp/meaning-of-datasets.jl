"""
lock5 statistics page 27
数据框里每列数据表述不同的属性, 每行数据就像是一个人在所自我介绍一样, 变现出了不同的特征和喜好

"""

include("utils.jl")
using HypothesisTests,GLMakie,CSV,DataFrames,ScientificTypes
using Statistics

  df= (let str="StudentSurvey"
      df=load_data(str)
  end)


data=select(df,[:Sex,:Smoke,:Award,:Exercise,:TV,:GPA,:Pulse,:BirthOrder])

# fixed_data=coerce(data, (:Sex,:Smoke,:Award)=>Multiclass,
#                      (:Exercise,:TV,:GPA,:Pulse)=>Continuous,
#                      :BirthOrder=>OrderedFactor)     

# student smoke portion
gdf1=groupby(data,:Smoke)
size(gdf1[2],1)/size(gdf1[1],1)|>d->round(d,digits=3) #0.14

# student  exerciese mean time
mean_exercise_time=select(data,:Exercise)|>Array|>mean|>d->round(d,digits=3)

# unuasual  pulse rate
extreme_pulse=select(data,:Pulse)|>Array|>d->extrema(d)

# most award student wanted
wanted_award(award::String="Olympic")=data |>d->filter(:Award => ==("$award"),d)|>d->size(d,1)
awards_cat=levels(data[!,:Award]).|>String
[Symbol(c)=>wanted_award(c)  for c in awards_cat]|>d->sort(d,rev=true)
"""
3-element Vector{Pair{Symbol, Int64}}:
:Olympic => 164
  :Nobel => 131
:Academy => 30
"""

# who smoke more male or female?
smokers(sex::String="M")= data |>d->filter(:Sex => ==("$sex"),d) |>d->filter(:Smoke => ==("Yes"),d)
(:male_smokers=>size(smokers("M"),1),:female_smokers=>size(smokers("F"),1))
#(:male_smokers => 24, :female_smokers => 16)


#Do males or females watch more television?
gdf2=groupby(data,:Sex)
mean_tv_time(df)=select(df,:TV)|>Array|>mean|>d->round(d,digits=3)
(:male_tv=>mean_tv_time(gdf2[1]),:female_tv=>mean_tv_time(gdf2[2]))

