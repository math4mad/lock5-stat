## 1. load package
    include("../../utils.jl")
    

## 2. load data
desc = Lock5Table(201, "SleepStudy", "Sleep Study with College Students", [])
df = @pipe load_csv(desc.name)

#list_features(df) 
#= 
["Gender", "ClassYear", "LarkOwl", "NumEarlyClass", "EarlyClass", "GPA", "ClassesMissed", "CognitionZscore", "PoorSleepQuality", "DepressionScore", "AnxietyScore", "StressScore", "DepressionStatus", "AnxietyStatus", "Stress", "DASScore", "Happiness", "AlcoholUse", "Drinks", "WeekdayBed", "WeekdayRise", "WeekdaySleep", "WeekendBed", "WeekendRise", "WeekendSleep", "AverageSleep", "AllNighter"]
=#