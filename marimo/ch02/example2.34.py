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
    return mo, sys, Path, np, pl, plt, stats, GT, lock5


@app.cell
def _(mo):
    mo.md(r"""# Example 2.34 — Florida lakes scatter plots

Port of `UnitA/ch02/example2.34.jl`. A 2×2 grid of scatter plots for four
feature pairs.""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(141, "FloridaLakes", "Scatterplots from Florida Lakes",
                            ["Alkalinity", "pH", "AvgMercury", "ThreeYrStdMercury"])
    data = lock5.load_csv(desc.name).select(desc.feature)
    return data


@app.cell
def _(data, plt):
    features = [["pH", "AvgMercury"],
                ["Alkalinity", "AvgMercury"],
                ["pH", "Alkalinity"],
                ["ThreeYrStdMercury", "AvgMercury"]]
    fig, axes = plt.subplots(2, 2, figsize=(9, 9))
    for (idx, ax), fe in zip(enumerate(axes.ravel()), features):
        x = data[fe[0]].to_numpy().astype(float)
        y = data[fe[1]].to_numpy().astype(float)
        ax.scatter(x, y, s=20, color="lightgreen", alpha=0.5,
                   edgecolors="black", linewidths=0.5)
        ax.set_xlabel(fe[0])
        ax.set_ylabel(fe[1])
    fig.tight_layout()
    fig
    return fig, axes, features


if __name__ == "__main__":
    app.run()
