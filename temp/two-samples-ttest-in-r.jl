"""
from https://www.statology.org/two-sample-t-test-in-r/
"""

using RCall


function  r_ttest()
    R"""
        #create vectors to hold plant heights from each sample
        group1 <- c(8, 8, 9, 9, 9, 11, 12, 13, 13, 14, 15, 19)
        group2 <- c(11, 12, 13, 13, 14, 14, 14, 15, 16, 18, 18, 19)
        #perform two sample t-test
       res=  t.test(group1, group2, var.equal=TRUE)
    """

end

r_ttest()