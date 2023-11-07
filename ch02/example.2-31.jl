include("../utils.jl")
using HypothesisTests,GLMakie,CSV,ScientificTypes,PrettyTables
using StatsBase,DataFrames,DataFramesMeta
desc=Lock5Table(132,"StudentSurvey","mean and std in boy and girl watch tv",["Sex","TV"])
data= @pipe load_csv(desc.name)|>select(_,desc.feature)

gdf=groupby(data,:Sex)
for  df in gdf
    describe(df[:,:TV])
end


df1=@chain gdf[1] begin
  
  @combine(:mean=mean(:TV))

end




