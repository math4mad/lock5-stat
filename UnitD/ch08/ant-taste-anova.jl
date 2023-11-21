"""
test  ant favorite with different filling  in 3 group
reference: https://www.statology.org/one-way-anova-r/

使用OneWayANOVATest 检测蚂蚁对三明治三种不同馅的喜好是否有差异?(以三明治上的蚂蚁数量度量)

julia  使用 OneWayANOVATest 检测三组均值差异 
如果组间均值有差异(pvalue<0.05), 使用 R   TukeyHSD 检测两个组间的差异


"""

include("../../utils.jl")
include("data-8.1-SandwichAnts.jl")


function anova_test()
    gdf=select(df,[:Filling,:Ants])|>d->groupby(d,:Filling)
    #groupsname=keys(gdf).|>values.|>d->d[1]
    sample=[df.Ants for df in gdf ]
    OneWayANOVATest(sample...)
end

"""
One-way analysis of variance (ANOVA) test
-----------------------------------------
Population details:
    parameter of interest:   Means
    value under h_0:         "all equal"
    point estimate:          NaN

Test summary:
    outcome with 95% confidence: reject h_0
    p-value:                     0.0110

Details:
    number of observations: [8, 8, 8]
    F statistic:            5.62667
    degrees of freedom:     (2, 21)
"""

function Tukey_hsd(df)
    
    data=select(df,[:Filling,:Ants])
	@rput data
	R"""
	 data$Filling <- as.factor(data$Filling)
     model <- aov(Ants~Filling, data=data)
	 #summary(model )
	 TukeyHSD(model) 
     #plot(TukeyHSD(model, conf.level=.95), las = 2)
	"""
end

Tukey_hsd(df)

"""
Filling
                              diff       lwr        upr     p adj
Peanut Butter-Ham & Pickles -15.25 -30.09326 -0.4067363 0.0433492
Vegemite-Ham & Pickles      -18.50 -33.34326 -3.6567363 0.0131006
Vegemite-Peanut Butter       -3.25 -18.09326 11.5932637 0.8466376

蚂蚁似乎更喜欢 Pickles&Ham 口味的三明治
"""
