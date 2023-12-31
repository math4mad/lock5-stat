## 1. load package
    include("utils.jl")
    using HypothesisTests, GLMakie, CSV, DataFrames, ScientificTypes
    using StatsBase, DataFramesMeta, Pipe

## 2. data processing
desc = Lock5Table(155, "StudentSurvey", "SAT Scores: Math vs Verbal", ["MathSAT","VerbalSAT"])
data = @pipe load_csv(desc.name)|>select(_,desc.feature)


## 3. plot cor

    function plot_cor()
        fig=Figure()
        ax=Axis(fig[1,1])
        ax.xlabel=desc.feature[1]
        ax.ylabel=desc.feature[2]
        scatter!(ax,eachcol(data)...; markersize=10, color=(:lightgreen, 0.5), strokecolor=:black, strokewidth=1)

    fig
    end
    fig=plot_cor()
    #save("./ch02/imgs/ex2.226-math-verbal-cor.png",fig)

    