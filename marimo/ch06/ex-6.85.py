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
    mo.md(r"""# Ex 6.85 — College SAT samples (AvgSAT histogram)

Port of `UnitC/ch06/ex-6.85.jl`: dot plot of `CollegeScores4yr.AvgSAT`.""")
    return


@app.cell
def _(lock5, np, stats):
    desc = lock5.Lock5Table(453, "CollegeScores4yr", "College SAT Samples", ["AvgSAT"])
    data = lock5.load_csv(desc.name).select(desc.feature)
    avg_sat = data["AvgSAT"].to_numpy().astype(float)
    xs = np.linspace(avg_sat.min(), avg_sat.max(), 200)
    dist = stats.norm(1135, 130)
    return desc, data, avg_sat, xs, dist


@app.cell
def _(avg_sat, lock5, plt):
    fig, ax = lock5.plot_dotplot(avg_sat, nbins=50, title="AvgSAT (50 bins)", xlabel="AvgSAT")
    fig
    return fig, ax


if __name__ == "__main__":
    app.run()
