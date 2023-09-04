"""
from https://www.statology.org/one-sample-t-test-in-r/
"""

using RCall


function  r_ttest()
    R"""
    my_data <- c(14, 14, 16, 13, 12, 17, 15, 14, 15, 13, 15, 14)
    t.test(my_data, mu=15)
    """

end

r_ttest()