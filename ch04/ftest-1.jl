
"""
参见: https://www.statology.org/f-test-in-r/
Test summary:
    outcome with 95% confidence: reject h_0
    two-sided p-value:           0.0383
因此有证据表明两个总体的方差不同    

"""

using HypothesisTests

x=[18, 19, 22, 25, 27, 28, 41, 45, 51, 55]
y=[14, 15, 15, 17, 18, 22, 25, 25, 27, 34]

VarianceFTest(x,y)

#= Variance F-test
---------------
Population details:
    parameter of interest:   variance ratio
    value under h_0:         1.0
    point estimate:          4.38712

Test summary:
    outcome with 95% confidence: reject h_0
    two-sided p-value:           0.0383

Details:
    number of observations: [10, 10]
    F statistic:            4.387122002085505
    degrees of freedoåm:     [9, 9] =#


