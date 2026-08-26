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
    mo.md(r"""# Data 2.2 — Mammal longevity dot plot

Port of `UnitA/ch02/data.2.2.jl` (an R/ggplot2 `geom_dotplot` of `Longevity`),
reproduced with matplotlib.""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(94, "MammalLongevity", "dotplot ", ["Animal", "Longevity"])
    df = lock5.load_csv(desc.name).select(desc.feature[1])
    return desc, df


@app.cell
def _(df, lock5):
    fig, ax = lock5.plot_dotplot(df["Longevity"].to_numpy(), title="mammal life",
                                 xlabel="Longevity", ylabel="count")
    ax.set_yticks([])
    fig
    return fig, ax


if __name__ == "__main__":
    app.run()
