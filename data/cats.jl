

using Pipe,DataFrames

struct  Lock5Table
    page::Int
    name::AbstractString
    question:: AbstractString
    feature::Vector{Union{AbstractString,Symbol}}
end

csvlists::Dict{AbstractString,Lock5Table}=Dict(
    "AreFemaleorMaleHomingPigeonsFaster?"=>Lock5Table(351,"HomingPigeons","AreFemaleorMaleHomingPigeonsFaster?",["Sex","Speed"]),
    "DoesHeatAffectMathReactionTime?"=>Lock5Table(351,"HeatCognition","DoesHeatAffectMathReactionTime?",["AC","MathZRT"]),
    "Does Heat Affect Color Dissonance Reaction Time?"=>Lock5Table(352,"HeatCognition","Does Heat Affect Color Dissonance Reaction Time?",["AC","ColorsZRT"])
)

#@pipe values(csvlists)



collect(csvlists)