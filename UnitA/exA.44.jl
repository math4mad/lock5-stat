include("../utils.jl")
using FreqTables
## 2. load data
desc = Lock5Table(216, "StudentSurvey", "Who Smokes More: Males or Females", ["Sex", "Smoke"])
df = @pipe load_csv(desc.name)|>select(_,desc.feature)  

ft=freqtable(df,desc.feature...)|>transpose


df2=@pipe values(ft)|>Matrix|>DataFrame(_,["Female","Male"])
freq_df=freq_table(df2;typename=["noSmoke", "Smoke","Total"])
@pt  freq_df

#= 
    ┌─────────┬────────┬───────┬───────┐
    │    Type │ Female │  Male │ Total │
    │  String │  Int64 │ Int64 │ Int64 │
    ├─────────┼────────┼───────┼───────┤
    │ noSmoke │    135 │   150 │   285 │
    │   Smoke │     16 │    24 │    40 │
    │   Total │    151 │   174 │   325 │
    └─────────┴────────┴───────┴───────┘
=#
@info "smoker-proportion"=>freq_df.Total[2]/freq_df.Total[3]*100
@info "male-smoke-proprotion"=>freq_df.Male[2]/freq_df.Male[3]*100
@info "female-smoke-proprotion"=>freq_df.Female[2]/freq_df.Female[3]*100

#= 
    [ Info: "male-smoke-proprotion" => 6.896551724137931
    [ Info: "female-smoke-proprotion" => 5.298013245033113
=#