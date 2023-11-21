using Bootstrap

bs(data) = bootstrap(mean,data, BasicSampling(1000))
sd=bs([0])
