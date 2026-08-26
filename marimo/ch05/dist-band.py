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

    return mo, np, plt, stats


@app.cell
def _(mo):
    mo.md(r"""
    # Normal(80, 10) density line plot

    Port of `UnitC/ch05/dist-band.jl` (the UnicodePlots `lineplot` becomes a
    matplotlib line plot).
    """)
    return


@app.cell
def _(np, stats):
    d = stats.norm(loc=80, scale=10)
    xs = np.linspace(50, 110, 100)
    return d, xs


@app.cell
def _(d, plt, xs):
    fig, ax = plt.subplots(figsize=(7, 4))
    ax.plot(xs, d.pdf(xs), color="black", linewidth=2)
    ax.set_title("Normal(80, 10)")
    fig
    return


if __name__ == "__main__":
    app.run()
