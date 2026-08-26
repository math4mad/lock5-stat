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
    mo.md(r"""# t-distribution vs normal

Port of `UnitB/ch04/pvalue-tdist.jl`. The t-distribution approaches the normal
as n → ∞. Two panels: full range and the upper tail.""")
    return


@app.cell
def _(np, plt, stats):
    ran = [3, 4, 5, 10, 20]
    d = stats.norm()
    tdists = [stats.t(df=n - 1) for n in ran]
    xs = np.linspace(-4, 4, 200)
    fig, axes = plt.subplots(1, 2, figsize=(12, 5))
    axes[0].plot(xs, d.pdf(xs), linestyle=":", linewidth=3, label="normal")
    for i, t in enumerate(tdists):
        axes[0].plot(xs, t.pdf(xs), linewidth=2, label=f"n={ran[i]}")
    axes[0].legend(); axes[0].set_title("Full range"); axes[0].set_xlabel("x"); axes[0].set_ylabel("density")
    ts = np.linspace(2, 6, 200)
    axes[1].plot(ts, d.pdf(ts), linestyle=":", linewidth=3, label="normal")
    for i, t in enumerate(tdists):
        axes[1].plot(ts, t.pdf(ts), linewidth=2, label=f"n={ran[i]}")
    axes[1].legend(); axes[1].set_title("Upper tail"); axes[1].set_xlabel("x"); axes[1].set_ylabel("density")
    fig.tight_layout()
    fig
    return axes, d, fig, tdists, xs


if __name__ == "__main__":
    app.run()
