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
    mo.md(r"""# Riemann rectangles under the standard normal PDF

Port of `UnitC/ch05/normal-dist-hist-2.jl` — for several step sizes `Δx`, draw
the normal curve together with Euler-method rectangles of width `Δx`.""")
    return


@app.cell
def _(np, stats):
    ws = [1, 0.8, 0.5, 0.3, 0.2, 0.1]
    d = stats.norm()
    xs = np.arange(-3, 3.1, 0.1)
    ys = d.pdf(xs)
    return ws, d, xs, ys


@app.cell
def _(d, np, plt, ws, xs, ys):
    fig, axes = plt.subplots(2, 3, figsize=(12, 7))
    for idx, w in enumerate(ws):
        ax = axes[idx // 3, idx % 3]
        ax.plot(xs, ys, color="black", linewidth=1.5)
        for x in np.arange(-3, 3, w):
            ax.add_patch(
                plt.Rectangle((x, 0), w, d.pdf(x),
                              facecolor="lightblue", alpha=0.4, edgecolor="black", linewidth=0.5)
            )
        ax.set_title(f"Δx = {w}")
    fig.tight_layout()
    fig
    return fig, axes


if __name__ == "__main__":
    app.run()
