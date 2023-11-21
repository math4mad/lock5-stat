
include("../../utils.jl")

desc=Lock5Table(491,"NBAPlayers2019","Are player has 160 fouls average?",["Fouls"])
μ₀=160

SingleSampleTTest(desc,μ₀)


#= 
One sample t-test
-----------------
Population details:
    parameter of interest:   Mean
    value under h_0:         160
    point estimate:          152.239
    95% confidence interval: (144.4, 160.0)

Test summary:
    outcome with 95% confidence: fail to reject h_0
    two-sided p-value:           0.0511

Details:
    number of observations:   188
    t-statistic:              -1.963168132027635
    degrees of freedom:       187
    empirical standard error: 3.9531195373759704

=#