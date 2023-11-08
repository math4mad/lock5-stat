include("../../utils.jl")
using FreqTables,NamedArrays
## 2. load data
desc = Lock5Table(203, "SleepStudy", "histogram of DAS scores", ["AlcoholUse","CognitionZscore"])

df = @pipe load_csv(desc.name)|>select(_,desc.feature)
gdf=groupby(df,:AlcoholUse)
cats= @pipe keys(gdf).|>values(_)[1]

# blank dataframe
new_df=DataFrame(name=String[],samplesize=Int[],mean=Float64[],std=Float64[])

for (idx,df) in enumerate(gdf)
    row= [cats[idx],nrow(df),mean(df.CognitionZscore),std(df.CognitionZscore)]
    push!(new_df,row)

end

total=["Overall",sum(new_df.samplesize),sum(new_df.mean),sum(new_df.std)]
push!(new_df,total)
@pt new_df
#= 
┌──────────┬────────────┬───────────┬──────────┐
│     name │ samplesize │      mean │      std │
│   String │      Int64 │   Float64 │  Float64 │
├──────────┼────────────┼───────────┼──────────┤
│ Moderate │        120 │   -0.0785 │ 0.671372 │
│    Light │         83 │  0.130241 │ 0.748152 │
│  Abstain │         34 │ 0.0688235 │  0.71574 │
│    Heavy │         16 │  -0.23375 │ 0.646868 │
│  Overall │        253 │ -0.113186 │  2.78213 │
└──────────┴────────────┴───────────┴──────────┘
=#

