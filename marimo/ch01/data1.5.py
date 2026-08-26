import marimo

__generated_with = "0.24.0"
app = marimo.App(width="medium")


@app.cell
def _():
    import marimo as mo
    import sys
    from pathlib import Path
    import numpy as np
    import polars as pl
    import matplotlib.pyplot as plt
    from scipy import stats
    from great_tables import GT
    _p = Path(mo.notebook_location()).resolve().parent
    while _p != _p.parent and not (_p / "lock5.py").exists():
        _p = _p.parent
    if str(_p) not in sys.path:
        sys.path.insert(0, str(_p))
    import lock5

    return GT, lock5, mo, pl, plt


@app.cell
def _(mo):
    mo.md(r"""
    # Data 1.5 — Life expectancy and vehicles (confounding variables)

    Port of `UnitA/ch01/data1.5.jl`. Read `LifeExpectancyVehicles`, min-max scale
    `LifeExpectancy` and `Vehicles` to `[0, 1]` (`TableTransforms.Scale(2, 3, low=0, high=1)`),
    then plot both series against `Year` and a scatter of the two variables.
    """)
    return


@app.cell
def _(GT, lock5, mo):
    desc = lock5.Lock5Table(56, "LifeExpectancyVehicles", "Cofounding-Variables",
                            ["Year", "LifeExpectancy", "Vehicles"])
    df = lock5.load_csv(desc.name)
    mo.Html(GT(df.head(20)).tab_header(title=desc.name).as_raw_html())
    return desc, df


@app.cell
def _(df, pl):
    # min-max scale columns 2 and 3 (LifeExpectancy, Vehicles) to [0, 1]
    scaled = df.select([
        pl.col("Year"),
        ((pl.col("LifeExpectancy") - pl.col("LifeExpectancy").min())
         / (pl.col("LifeExpectancy").max() - pl.col("LifeExpectancy").min())).alias("LifeExpectancy"),
        ((pl.col("Vehicles") - pl.col("Vehicles").min())
         / (pl.col("Vehicles").max() - pl.col("Vehicles").min())).alias("Vehicles"),
    ])
    return (scaled,)


@app.cell
def _(desc, plt, scaled):
    def plot_line():
        fig, ax = plt.subplots(figsize=(7, 4))
        ax.plot(scaled["Year"], scaled["LifeExpectancy"], label=desc.feature[1], linewidth=3)
        ax.plot(scaled["Year"], scaled["Vehicles"], label=desc.feature[2], linewidth=3)
        ax.set_xlabel("Year")
        ax.set_ylabel("scaled value")
        ax.set_title("Life expectancy and vehicles over time (scaled)")
        ax.legend()
        return fig

    plot_line()
    return


@app.cell
def _(df, plt):



    fig2, ax2 = plt.subplots(figsize=(7, 4))
    ax2.scatter(df["LifeExpectancy"], df["Vehicles"], s=50, color="lightgreen",
               alpha=0.5, edgecolors="black", linewidths=1)
    ax2.set_xlabel("LifeExpectancy")
    ax2.set_ylabel("Vehicles")
    ax2.set_title("Vehicles vs Life expectancy")
    fig2
    return


if __name__ == "__main__":
    app.run()
