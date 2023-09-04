"""
measure  GeneticDiversity and  distance from Africa
page 153
"""

include("utils.jl")
using HypothesisTests,GLMakie,CSV,DataFrames,ScientificTypes
using Statistics,DataFramesMeta,Pipe,ColorSchemes

  df= (let str="GeneticDiversity"
      df=load_data(str)
  end)

  data=select(df,[:Distance,:GeneticDiversity,:Continent])
  gdf=@pipe data|>sort(_, :Distance,rev = true)|>groupby(_,[:Continent],sort=true)
  continent_cats=@pipe gdf|>keys.|>values.|>_[1]
  cbarPal = :thermal
  cmap = cgrad(colorschemes[cbarPal], length(continent_cats), categorical = true)
  markers=[:circle,:rect,:cross,:xcross,:star4,:utriangle,:pentagon]
  
  function plot_res()
    fig=Figure()
    ax=Axis(fig[1,1],title="GeneticDiversity with Distance",xlabel="Distance from East Africa",ylabel="GeneticDiversity")

    for (idx,df) in enumerate(gdf)
        scatter!(ax,df[!,1],df[!,2], label = "$(continent_cats[idx])",marker=markers[idx],markersize=18,color=cmap[idx],strokewidth=3,strokecolor=:black) 
    end
    axislegend(ax)
    #save("./imgs/geneticdiversity.png",fig)
    fig
  end
  plot_res()

  