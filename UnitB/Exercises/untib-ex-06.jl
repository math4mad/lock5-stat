include("./init.jl")

## 2. load data

desc=Lock5Table(402,"MarriageAges","Husbands Older Than Wives?",["Husband","Wife"])
data=@pipe load_data(desc.name)
transform!(data, ["Husband","Wife"] => ByRow(-) => :age_diff)

## 3. ttest
OneSampleTTest(data.age_diff)

#= 
  One sample t-test
-----------------
Population details:
    parameter of interest:   Mean
    value under h_0:         0
    point estimate:          2.82857
    95% confidence interval: (1.862, 3.795)

Test summary:
    outcome with 95% confidence: reject h_0
    two-sided p-value:           <1e-07

Details:
    number of observations:   105
    t-statistic:              5.802524207370071
    degrees of freedom:       104
    empirical standard error: 0.48747257701720936
=#


#  夫妻年龄存在差异


