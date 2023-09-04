"""
 data:PumpkinBeer
 夫妻对啤酒的评分是否相关?
 page 154
"""

include("utils.jl")
using HypothesisTests,GLMakie,CSV,DataFrames,ScientificTypes
using Statistics,DataFramesMeta,Pipe,ColorSchemes

  df= (let str="PumpkinBeer"
      df=load_data(str)
  end)

  #names(df)
  data=select(df,[:WifeRating,:HusbandRating])
  data2=select(df,[:Year,:Average])
  
  
  function plot_spouse_cor(df)
    fig=Figure()
    ax=Axis(fig[1,1],title="Spouse rating",xlabel="WifeRating",ylabel="HusbandRating")
    scatter!(ax,df[!,1],df[!,2],markersize=16,color=(:blue,0.3),strokewidth=3,strokecolor=:black) 
    fig
    #save("bear_spouse_cor.png",fig)
  end

  #plot_spouse_cor(data)

  function plot_year_rating(df)
    fig=Figure()
    ax=Axis(fig[1,1],title="Year Rating",xlabel="Year",ylabel="Avg")
    scatter!(ax,df[!,1],df[!,2],markersize=16,color=(:blue,0.3),strokewidth=3,strokecolor=:black) 
    fig
    #save("./imgs/bear_Year_Rating.png",fig)
  end

  #plot_year_rating(data2)
