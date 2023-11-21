"""
from    https://www.statology.org/welch-t-test-in-r/
"""



function welch_ttest()
    R"""
        booklet <- c(90, 85, 88, 89, 94, 91, 79, 83, 87, 88, 91, 90)
        no_booklet <- c(67, 90, 71, 95, 88, 83, 72, 66, 75, 86, 93, 84)
        #boxplot(booklet, no_booklet, names=c("Booklet","No Booklet"))
        t.test(booklet, no_booklet)
    """
end


welch_ttest()