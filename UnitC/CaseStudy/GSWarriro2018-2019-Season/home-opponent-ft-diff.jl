
"""
主客场罚球命中率是否有差异?
比较主客场罚球命中率 
"""


include("../../../utils.jl")
include("data-c.1.jl")


str="GSWarriors2019"
feature=["FTA","OppFTA","FT","OppFT","Location"]

df=load_data(str)
gsft=df[!,feature[3]]|>sum
gsfta=df[!,feature[1]]|>sum
oppft=df[!,feature[4]]|>sum
oppfta=df[!,feature[2]]|>sum

FisherExactTest(gsft,oppft,gsfta,oppfta)

