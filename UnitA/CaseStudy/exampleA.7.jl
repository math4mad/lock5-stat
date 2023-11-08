include("../../utils.jl")
using FreqTables,NamedArrays
## 2. load data
desc = Lock5Table(203, "SleepStudy", "histogram of DAS scores", ["Stress","LarkOwl"])

df = @pipe load_csv(desc.name)|>select(_,desc.feature)

## 3. freq table
ft=freqtable(df,desc.feature...)

df2=@pipe values(ft)|>Matrix|>DataFrame(_,["Lark", "Neither", "Owl"])
freq_df=freq_table(df2;typename=["high", "normal","Total"])

@pt freq_df
#= 
┌────────┬───────┬─────────┬───────┬───────┐
│   Type │  Lark │ Neither │   Owl │ Total │
│ String │ Int64 │   Int64 │ Int64 │ Int64 │
├────────┼───────┼─────────┼───────┼───────┤
│   high │    10 │      38 │     8 │    56 │
│ normal │    31 │     125 │    41 │   197 │
│  total │    41 │     163 │    49 │   253 │
└────────┴───────┴─────────┴───────┴───────┘
=#


