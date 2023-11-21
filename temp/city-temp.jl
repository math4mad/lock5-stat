"""
page 109

April14Temps 
"""

include("utils.jl")
using HypothesisTests,GLMakie,CSV,DataFrames,ScientificTypes
using Statistics,DataFramesMeta,Pipe

  df= (let str="April14Temps"
      df=load_data(str)
  end)

  res=describe(df)
  
  #temp_of(city,method=mean)=@pipe df|>select(_,city)|>Array|>method|>round(_,digits=2)
  #res=["$i-$(j)"=>temp_of(i,j) for i in [:DesMoines,:SanFrancisco] for j in [mean,median]]

  function plot_spread(df)
    SanFrancisco=df[!,:SanFrancisco]
    DesMoines=df[!,:DesMoines]
    
    fig=Figure(resolution=(300,300))
   
    ax1=Axis(fig[1,1])
    ax2=Axis(fig[2,1])
    hist!(ax1,SanFrancisco;bins=8,label="SanFrancisco",strokewidth = 1, strokecolor = :black,color=(:gray,0.6))
    hist!(ax2,DesMoines,bins=8,label="DesMoines",strokewidth = 1, strokecolor = :black,color=(:gray,0.6))
    axislegend(ax1)
    axislegend(ax2)
    #save("./imgs/city-temp.png",fig)
    fig
end
#plot_spread(df)


function computing_std(df)
    SanFrancisco=df[!,:SanFrancisco]
    DesMoines=df[!,:DesMoines]
    Dict("SanFrancisco-std"=>std(SanFrancisco),"DesMoines-std"=>std(DesMoines))

end
#computing_std(df)
"""
  "SanFrancisco-std" => 3.06106
  "DesMoines-std"    => 11.1809
"""

