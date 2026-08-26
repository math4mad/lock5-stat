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
    mo.md(r"""# Data 3.3 — CommuteAtlanta time dot plot

Port of `UnitB/ch03/data3.3-atlantcommute.jl`. Dot plot of the `Time` variable.""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(270, "CommuteAtlanta", "data3.1",
                            ["City", "Age", "Distance", "Time", "Sex"])
    df = lock5.load_csv(desc.name).select(desc.feature[3])
    times = df["Time"].to_numpy().astype(float)
    return desc, df, times


@app.cell
def _(lock5, times):
    fig, ax = lock5.plot_dotplot(times, nbins=len(set(times)) if len(set(times)) < 60 else 30,
                                 title="CommuteAtlanta Time sampling",
                                 xlabel="Time", ylabel="Count", color="black")
    fig
    return fig, ax


if __name__ == "__main__":
    app.run()
