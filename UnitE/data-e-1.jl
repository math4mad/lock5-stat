include("../utils.jl")
#= 
 features :["DecisionM", "DecisionF", "LikeM", "LikeF", "PartnerYesM", "PartnerYesF", "AgeM", "AgeF", "RaceM", "RaceF", "AttractiveM", "AttractiveF", "SincereM", "SincereF", "IntelligentM", "IntelligentF", "FunM", "FunF", "AmbitiousM", "AmbitiousF", "SharedInterestsM", "SharedInterestsF"]
=#
## 2.  load data
desc=Lock5Table(718,"SpeedDating","",[])
df=@pipe load_csv(desc.name)
first(df,5)
