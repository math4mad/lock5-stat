"""
lock5stat page 278
snail can escape from bird  digest system
喂给鸟类的 174 个蜗牛, 其中有 26个在其他地方被排泄出来
"""

using Bootstrap,GLMakie,StatsBase
  ratio=26/174  #成功逃逸率
  n_boot = 1000

  ## basic bootstrap
  bs = bootstrap(mean, [ratio], BasicSampling(n_boot))








