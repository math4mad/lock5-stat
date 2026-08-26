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
    mo.md(r"""# Normal distribution — area rectangles

Port of `UnitB/ch04/normal-dist-hist.jl`. Standard normal density with a set of
rectangles approximating the area under the curve.""")
    return


@app.cell
def _(np, plt, stats):
    d = stats.norm()
    xs = np.linspace(-3, 3, 200)
    ys = d.pdf(xs)
    widths = [1.0, 0.8, 0.5, 0.3, 0.2, 0.1]
    fig, ax = plt.subplots(figsize=(7, 4))
    ax.plot(xs, ys, color="black", linewidth=2)
    for w in widths:
        xb = np.arange(-3, 3 + w, w)
        for x in xb:
            ax.add_patch(plt.Rectangle((x, 0), w, d.pdf(x), fill=True, alpha=0.4,
                                       facecolor="lightblue", edgecolor="black"))
    ax.set_title("Standard normal density with area rectangles")
    ax.set_xlabel("x")
    ax.set_ylabel("density")
    fig
    return ax, d, fig, xs, ys


if __name__ == "__main__":
    app.run()
