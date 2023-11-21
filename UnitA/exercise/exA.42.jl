include("../utils.jl")

## 2. load data
desc = Lock5Table(215, "USStates", "Percent of College Graduates by Region of the US", ["Region", "College"])
df = @pipe load_csv(desc.name) |> select(_, desc.feature)
gdf=groupby(df,desc.feature[1])

##  3. box plot
fig=plot_2feature_boxplot(gdf,"Percent of College Graduates by Region of the US",[:Region,:College])
save("./UnitA/Percent of College Graduates by Region of the US.png",fig)