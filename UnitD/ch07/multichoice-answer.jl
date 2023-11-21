"""
标准化考试中, 学生对多项选择是否有偏好(答案几率相同)
lock5stat page  569

chi-test

检验假设
H0∶ pa=pb=pc=pd=pe=0.2 
Ha∶ Some pi ≠0.2

"""

include("../../utils.jl")

a=85;b=90;c=79;d=78;e=68
observed=[a,b,c,d,e]
expected=[.2, .2, .2, .2, .2]
res=ChisqTest(observed,expected)

#= 
    value under h_0:         [0.2, 0.2, 0.2, 0.2, 0.2]
    point estimate:          [0.2125, 0.225, 0.1975, 0.195, 0.17]
    95% confidence interval: [(0.165, 0.2647), (0.1775, 0.2772), (0.15, 0.2497), (0.1475, 0.2472), (0.1225, 0.2222)]
=#


