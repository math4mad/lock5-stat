## 1. load package
include("../../utils.jl")
using FreqTables
## 2. load data

    desc = Lock5Table(202, "SleepStudy", "Sleep Study with College Students", ["DASScore","Stress","LarkOwl","AlcoholUse","PoorSleepQuality","CognitionZscore"])
    df = @pipe load_csv(desc.name)|>select(_,desc.feature)

## 3. distributions of  DASScore

    #fig,ax,plt=density(df.DASScore);save("exampleA.4-DASScore-dist.png",fig)
## 4. relationship of stress and  LarkOwl
      df2=select(df,[:Stress,:LarkOwl])
      ft=freqtable(df2,:Stress,:LarkOwl)
    #= 
     2×3 Named Matrix{Int64}
        Stress ╲ LarkOwl │    Lark  Neither      Owl
        ─────────────────┼──────────────────────────
        high             │      10       38        8
        normal           │      31      125       41
    =#

    prop(ft)
     #= 
      2×3 Named Matrix{Float64}
        Stress ╲ LarkOwl │      Lark    Neither        Owl
        ─────────────────┼────────────────────────────────
        high             │ 0.0395257   0.150198  0.0316206
        normal           │   0.12253   0.494071   0.162055
     =#
## 5.  alcohol use and cognitive skills
      two_features=[:AlcoholUse,:CognitionZscore]
      df3=select(df,two_features)
      gdf3=groupby(df3,two_features[1])
      #fig=plot_2feature_boxplot(gdf3,"AlcoholUse and Cognitionscore relation",two_features)
      #save("./UnitA/CaseStudy/imgs/AlcoholUse-Cognitionscore-relation.png",fig)

##  6. relationship between sleep quality and DAS score
     two_features2=[:PoorSleepQuality,:DASScore]
     df4=select(df,two_features2)
     plot_pair_cor(df4)
 