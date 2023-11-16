include("./init.jl")

## 2. load data

desc=Lock5Table(401,"ColaCalcium","Diet Cola affect  Calcium ?",["Drink","Calcium"])
data=@pipe load_data(desc.name)|>groupby(_,desc.feature[1])


##3.  ttest
OneSampleTTest(data[1].Calcium,data[2].Calcium)
#= 
    One sample t-test
    -----------------
    Population details:
        parameter of interest:   Mean
        value under h_0:         0
        point estimate:          6.875
        95% confidence interval: (0.9057, 12.84)

    Test summary:
        outcome with 95% confidence: reject h_0
        two-sided p-value:           0.0296

    Details:
        number of observations:   8
        t-statistic:              2.7233825675907335
        degrees of freedom:       7
        empirical standard error: 2.5244341657375133
=#


