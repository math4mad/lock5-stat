using Parameters

@with_kw struct Params
    a::String
    b::Float64=10.
    @assert a in ["HT","Desc","LR"] 
    @assert b>=9.
end

# Base.@kwdef struct Params
#     a::String
#     b::Float64=10.
#     @assert a in ["HT","Desc","LR"] 
#     @assert b>=9.
# end

