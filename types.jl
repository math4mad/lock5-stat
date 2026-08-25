"""
 lock5stat  data struct 
"""
Base.@kwdef struct  Lock5Table
    page::Int
    name::AbstractString
    question:: AbstractString
    feature::Vector{Union{AbstractString,Symbol}}
end

"""
ProportionTTest

params::Array :[observation,n,h0-rating]
 
"""
Base.@kwdef struct ProportionTTest
    page::Int
    name::AbstractString
    question::AbstractString
    params::Array
end
