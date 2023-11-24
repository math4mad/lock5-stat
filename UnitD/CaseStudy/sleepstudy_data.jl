
#= 
lockstat page 698
UnitD CaseStudy data
feature : ["Gender", "ClassYear", "LarkOwl", "NumEarlyClass", "EarlyClass", "GPA", "ClassesMissed", "CognitionZscore", "PoorSleepQuality", "DepressionScore", "AnxietyScore", "StressScore", "DepressionStatus", "AnxietyStatus", "Stress", "DASScore", "Happiness", "AlcoholUse", "Drinks", "WeekdayBed", "WeekdayRise", "WeekdaySleep", "WeekendBed", "WeekendRise", "WeekendSleep", "AverageSleep", "AllNighter"]


=#

include("../../utils.jl")


desc = Lock5Table(698, "SleepStudy", "SleepStudy", [])
data = @pipe load_csv(desc.name)
