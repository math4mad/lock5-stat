using GLMakie, LinearAlgebra,PrettyTables,DataFrames

height=[60,63,66,69,72,75]
weight=[120:20:200...]

res=[703*w/(h^2) for h in height, w in weight].|>d->round(d, digits=1)
df1=DataFrame([height],[:height])
df2=DataFrame(res,Symbol.(weight))
df=hcat(df1,df2)
@pt df
#=
    ┌────────┬─────────┬─────────┬─────────┬─────────┬─────────┐
    │ height │     120 │     140 │     160 │     180 │     200 │
    │  Int64 │ Float64 │ Float64 │ Float64 │ Float64 │ Float64 │
    ├────────┼─────────┼─────────┼─────────┼─────────┼─────────┤
    │     60 │    23.4 │    27.3 │    31.2 │    35.2 │    39.1 │
    │     63 │    21.3 │    24.8 │    28.3 │    31.9 │    35.4 │
    │     66 │    19.4 │    22.6 │    25.8 │    29.0 │    32.3 │
    │     69 │    17.7 │    20.7 │    23.6 │    26.6 │    29.5 │
    └────────┴─────────┴─────────┴─────────┴─────────┴─────────┘
=#

