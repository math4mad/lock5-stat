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
    mo.md(r"""# Example 5.10 — 95% levels of a Normal(40, 5)

Port of `UnitC/ch05/example-5-10.jl`.  The original Julia snippet sampled
`xs = -10..10` (far off the support of `Normal(40, 5)`, producing an empty
plot), so here `xs` spans `20..60` to make the 95% tail bands visible.""")
    return


@app.cell
def _(np, stats):
    d = stats.norm(loc=40, scale=5)
    xs = np.linspace(20, 60, 100)
    return d, xs


@app.cell
def _(d, lock5, plt, xs):
    fig, ax = plt.subplots(figsize=(7, 4))
    ax.plot(xs, d.pdf(xs), color="black", linewidth=2)
    lock5.plot_level_band(ax, xs, d, level=0.05)
    ax.set_title("Normal(40, 5) — 5% significance bands")
    fig
    return fig, ax


if __name__ == "__main__":
    app.run()
