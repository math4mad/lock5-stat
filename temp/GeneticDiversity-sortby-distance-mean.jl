"""
measure  GeneticDiversity and  distance from Africa
page 153

根据 "JuliaBookCode/DataFrames/4. Grouping data frames.ipynb  方法对 gdf依据各大洲到中非
的距离重新排序, 数据未变, 目的方便识图
"""

include("utils.jl")
using .Utils
using HypothesisTests,GLMakie,CSV,DataFrames,ScientificTypes
using Statistics,DataFramesMeta,Pipe,ColorSchemes

  desc=Lock5Table(153,"GeneticDiversity","diance from africa and geneticdiversity?",[:Distance,:GeneticDiversity,:Continent])
  data=@pipe load_data(desc.name)|>select(_,desc.feature)
  #gdf=@pipe data|>groupby(_,[:Continent])|>combine(_, desc.feature[1] => mean=>:DistanceMean)
  
  gdf=@pipe data|>groupby(_,[:Continent])
  #key=keys(gdf)

  ordergdf=@pipe gdf|>combine(_, desc.feature[1] => mean=>:DistanceMean)|>sort!(_, :DistanceMean)
  gdf_keys=keys(gdf)
  order_cats=ordergdf."Continent"
  newgdf=SubDataFrame[]
  #keys(gdf)[1][1]
  for  (idx, c) in enumerate(ordergdf."Continent")
       for (j,key) in  enumerate(gdf_keys)
           if gdf_keys[j][1]==c
            push!(newgdf,gdf[j])
           end
       end
  end
  

  cbarPal = :thermal
  cmap = cgrad(colorschemes[cbarPal], length(order_cats), categorical = true)
  markers=[:circle,:rect,:cross,:xcross,:star4,:utriangle,:pentagon]
  
  function plot_res(gdf)
    fig=Figure()
    ax=Axis(fig[1,1],title="GeneticDiversity with Distance",xlabel="Distance from East Africa",ylabel="GeneticDiversity")

    for (idx,df) in enumerate(gdf)
        scatter!(ax,df[!,1],df[!,2], label = "$(order_cats[idx])",marker=markers[idx],markersize=18,color=cmap[idx],strokewidth=3,strokecolor=:black) 
    end
    axislegend(ax)
    #save("./imgs/geneticdiversity-orderby-distance.png",fig)
    fig
  end

  #plot_res(newgdf)
  

  
  