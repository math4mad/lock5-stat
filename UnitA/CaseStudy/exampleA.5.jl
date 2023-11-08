
## 1. load package
    include("../../utils.jl")
    using FreqTables
## 2. load data
    desc = Lock5Table(203, "SleepStudy", "LarkType proportion", ["DASScore","Stress","LarkOwl","AlcoholUse","PoorSleepQuality","CognitionZscore"])
    df = @pipe load_csv(desc.name)|>select(_,"LarkOwl")
## 3. freq  stat
    ft=freqtable(df,:LarkOwl)
    #= 
        LarkOwl  │ 
        ─────────┼────
        Lark     │  41
        Neither  │ 163
        Owl      │  49
    =#
    @info "Lark-type"=>@pipe ft[1]/sum(ft)|>round(_,digits=3)






