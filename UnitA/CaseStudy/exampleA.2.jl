## describe  six variables

## 1. load package
 include("../../utils.jl")

## 2. load data

    desc = Lock5Table(202, "SleepStudy", "Sleep Study with College Students", ["DASScore","Stress","LarkOwl","AlcoholUse","PoorSleepQuality","CognitionZscore"])
    df = @pipe load_csv(desc.name)|>select(_,desc.feature)

## 3. describe of feature 

### 3.1 DASScore
    "抑郁,焦虑,压力程度 1:100"
    das=levels(df.DASScore)
### 3.2  Stress
    "压力程度:high,normal"
    stress=levels(df.Stress)
### 3.3  LarkOwl
    "作息类型:Lark:早睡早起,Neighter:不规律,Owl:夜猫子"
    larkowl=levels(df.LarkOwl)

### 3.4  AlcoholUse
    "饮酒水平:Abstain,Heavy,Light,Moderate"
    alcoholuse=levels(df.AlcoholUse)

### 3.5 PoorSleepQuality
    "睡眠质量"
    poorsleepquality=levels(df.PoorSleepQuality)
### 3.6 CognitionZScore
    "认知标准分"
    cognitionzScore=levels(df.CognitionZscore)