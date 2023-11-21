"""
Professor Brad Baldwin is interested in how water chemistry might affect gill beat rates. 

data: FishGills3
"""

include("$(pwd())/utils.jl")
using HypothesisTests,GLMakie,CSV,DataFrames,Distributions,RCall,Pipe
str="FishGills3"
feature=["Calcium","GillRate"]
gdf=@pipe load_data(str)|>groupby(_,feature[1])

function anova_test(gdf)
    sample=DataFrame(group1=gdf[1][!,feature[2]],group2=gdf[2][!,feature[2]],group3=gdf[3][!,feature[2]])
    OneWayANOVATest(eachcol(sample)...)
end

#anova_test(gdf)
#= 
outcome with 95% confidence: reject h_0
 p-value:                     0.0121
=#


function Tukey_hsd(data)
    
	@rput data
	R"""
	 data$Calcium <- as.factor(data$Calcium)
     model <- aov(GillRate~Calcium, data=data)
	 TukeyHSD(model) 
     plot(TukeyHSD(model, conf.level=.95), las = 2)
	"""
end
 
@pipe load_data(str)|>Tukey_hsd(_)
#= 
    RObject{VecSxp}
    Tukey multiple comparisons of means
        95% family-wise confidence level

    Fit: aov(formula = GillRate ~ Calcium, data = data)

    $Calcium
                    diff        lwr        upr     p adj
    Low-High    10.333333   1.219540 19.4471264 0.0222533
    Medium-High  0.500000  -8.613793  9.6137931 0.9906108
    Medium-Low  -9.833333 -18.947126 -0.7195402 0.0313247
=#

