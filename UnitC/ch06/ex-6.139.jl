# 1. load package
include("../../utils.jl")


## 2. load data
#= 
 feature ["Team", "League", "Wins", "Runs", "Hits", "Doubles", "Triples", "HomeRuns", "RBI", "StolenBases", "CaughtStealing", "Walks", "Strikeouts", "BattingAvg"]
=#
desc=Lock5Table(468,"BaseballHits2019","BaseBall Team Statistics",["Team","BattingAvg"])
data=@pipe load_csv(desc.name)
summarystats(data.BattingAvg)
#= 
Summary Stats:
Length:         30
Missing Count:  0
Mean:           0.252167
Minimum:        0.236000
1st Quartile:   0.245250
Median:         0.249500
3rd Quartile:   0.260250
Maximum:        0.274000
=#

## 3 question

### 3.1 how many teams
"how many team"=>length(data.Team)   #"how many team" => 30

### 3.2 average team batting average=0.260
OneSampleTTest(data.BattingAvg,0.260)
#= 
   95% confidence interval: (0.2481, 0.2562)
   outcome with 95% confidence: reject h_0
   two-sided p-value:           0.0005
=#


