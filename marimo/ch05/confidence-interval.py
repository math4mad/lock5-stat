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

    return lock5, mo, np, plt, stats


@app.cell
def _(mo):
    mo.md(r"""
    # Significance-level band (t-distribution)

    Port of `UnitC/ch05/confidence-interval.jl` — draws a `TDist(5)` curve and shades
    the two 5% significance-level tails using `plot_level_band`.
    """)
    return


@app.cell
def _(np, stats):
    d = stats.t(df=5)
    xs = np.linspace(-4, 4, 100)
    return d, xs


@app.cell
def _(d, lock5, plt, xs):
    fig, ax = plt.subplots(figsize=(7, 4))
    ax.plot(xs, d.pdf(xs), color="black", linewidth=2)
    lock5.plot_level_band(ax, xs, d, level=0.05)
    ax.set_title("t-distribution (df=5) — 5% significance bands")
    fig
    return


if __name__ == "__main__":
    app.run()
