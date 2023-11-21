
#= 
   outcome with 95% confidence: reject h_0
    p-value:                     0.0140
    不同领域的教材价格均值有差异
=#

include("$(pwd())/utils.jl")

using CSV,DataFrames
using DataFramesMeta,StatsBase
using HypothesisTests,RCall


desc=Lock5Table(629,"TextbookCosts","Do costs tend to differ depending on academic area?",["Field","Books","Cost"])
gdf=@pipe load_data(desc.name)|>select(_,[desc.feature[1],desc.feature[3]])|>groupby(_,desc.feature[1])


function anova_test(gdf)
    len=length(keys(gdf))
    d=[gdf[i][!,desc.feature[3]] for i in  1:len]
    sample=DataFrame(d, :auto)
    OneWayANOVATest(eachcol(sample)...)
    
end
anova_test(gdf)
#= 
   outcome with 95% confidence: reject h_0
    p-value:                     0.0140
    不同领域的教材价格均值有差异
=#


function Tukey_hsd()
    
    data=@pipe load_data(desc.name)|>select(_,["Field","Cost"])
	@rput data
	R"""
	 data$Field <- as.factor(data$Field)
     model <- aov(Cost~Field, data=data)
	 #summary(model )
	 res<-TukeyHSD(model) 
     #plot(TukeyHSD(model, conf.level=.95), las = 2)
	"""
    @rget res
end
data=Tukey_hsd()

#= 
    Tukey multiple comparisons of means
        95% family-wise confidence level

    Fit: aov(formula = Cost ~ Field, data = data)

    $Field
                                diff        lwr        upr     p adj
    Humanities-Arts               25.7  -34.95384  86.353844 0.6669143
    NaturalScience-Arts           76.2   15.54616 136.853844 0.0090147
    SocialScience-Arts            23.7  -36.95384  84.353844 0.7201024
    NaturalScience-Humanities     50.5  -10.15384 111.153844 0.1312366
    SocialScience-Humanities      -2.0  -62.65384  58.653844 0.9997441
    SocialScience-NaturalScience -52.5 -113.15384   8.153844 0.1097759
=#

