include("../../utils.jl")


desc = Lock5Table(94, "MammalLongevity", "dotplot ", ["Animal", "Longevity"])
df = @pipe load_csv(desc.name) |> select(_, desc.feature[2])

@rput df
R"""
    library(ggplot2)
    ggplot(df, aes(x =Longevity )) + 
    geom_dotplot(dotsize = .75, stackratio = 1.2, 
                fill = "steelblue") + 
    scale_y_continuous(NULL, breaks = NULL) + 
    labs(title = "mammal life", x = "Longevity") +
    theme_minimal()
"""

