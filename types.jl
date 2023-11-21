"""
 lock5stat  data struct 
"""
Base.@kwdef struct  Lock5Table
    page::Int
    name::AbstractString
    question:: AbstractString
    feature::Vector{Union{AbstractString,Symbol}}
end
