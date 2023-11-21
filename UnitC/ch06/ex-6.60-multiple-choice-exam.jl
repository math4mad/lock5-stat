"""
page 447
data: "APMultipleChoice"
question :"Is B a Good Choice on a Multiple-Choice Exam?
result:    fail to reject h_0, no difference
"""


include("../../utils.jl")
using HypothesisTests,GLMakie,CSV,DataFrames
using Statistics,Pipe


feature=["Answer"]
desc=Lock5Table(447,"APMultipleChoice","Is B a Good Choice on a Multiple-Choice Exam?",["Answer"])

df=@pipe load_csv(desc.name)
bdf=filter(row -> row.Answer == "B", df)
cats=levels(df[!,desc.feature])|>length
x,n=size(bdf,1),size(df,1)

BinomialTest(x,n,1/cats)
#= 
    Binomial test
    -------------
    Population details:
        parameter of interest:   Probability of success
        value under h_0:         0.2
        point estimate:          0.225
        95% confidence interval: (0.185, 0.2691)

    Test summary:
        outcome with 95% confidence: fail to reject h_0
        two-sided p-value:           0.2368

    Details:
        number of observations: 400
        number of successes:    90
=#