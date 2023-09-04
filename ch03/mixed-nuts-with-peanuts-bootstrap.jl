"""
lock5stat page 274
干果中花生的比例
"""


using Bootstrap,GLMakie,StatsBase
  peanut_ratio_in_jar=52/100  
  n_boot = 1000

  ## basic bootstrap
  bs = bootstrap(mean, [peanut_ratio_in_jar], BasicSampling(n_boot))

  bs.t1[1]|>std