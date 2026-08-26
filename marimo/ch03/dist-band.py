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
    mo.md(r"""# Distribution band — t(5) significance levels

Port of `UnitB/ch03/dist-band.jl`. Plot the t-distribution with df = 5 and shade
the two-sided α = 0.05 significance region.""")
    return


@app.cell
def _(lock5, np, plt, stats):
    d = stats.t(df=5)
    xs = np.linspace(-4, 4, 100)
    fig, ax = plt.subplots(figsize=(7, 4))
    ax.plot(xs, d.pdf(xs), color="black", linewidth=2)
    lock5.plot_level_band(ax, xs, d, level=0.05, double=True, color="green", alpha=0.5)
    ax.set_title("t(5) with two-sided α = 0.05 band")
    ax.set_xlabel("x")
    ax.set_ylabel("density")
    fig
    return ax, d, fig, xs


if __name__ == "__main__":
    app.run()
