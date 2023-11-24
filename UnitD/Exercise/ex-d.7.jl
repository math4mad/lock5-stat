#= 
D.7 Do larger parties tend to leave a larger tip?
=#

## 1.load package
include("../../utils.jl")

## 2. load data 
include("restaurant-tips-data.jl")
data=select(df,:Guests,:Tip)


## 3. plot cor relation
fig=let
    fig,ax,plt=scatter(eachcol(data)...,marker='o',color=:red)
    ax.xlabel,ax.ylabel=names(data)
    fig
end;
#save("UnitD/Exercise/ex-d.7-cor-plot.png",fig)

## 4. cor of two variables
cor(eachcol(data)...)  #0.5039595

CorrelationTest(eachcol(data)...)

#= 
Test for nonzero correlation
----------------------------
Population details:
    parameter of interest:   Correlation
    value under h_0:         0.0
    point estimate:          0.50396
    95% confidence interval: (0.3771, 0.6123)

Test summary:
    outcome with 95% confidence: reject h_0
    two-sided p-value:           <1e-10

Details:
    number of observations:          157
    number of conditional variables: 0
    t-statistic:                     7.26415
    degrees of freedom:              155
=#

## 5. results
#= 
   相关系数不为 0
=#

