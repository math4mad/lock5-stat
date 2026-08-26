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
    mo.md(r"""# Example 6.11 — Sampling distributions (three normal populations)

Port of `UnitC/ch06/example-6.11.jl`.  The original `Dist(8.0, 10.5)` is not a
Distributions.jl constructor; following the loop's `μ, σ = params(dist)`, it is
interpreted as `Normal(8.0, 10.5)`.""")
    return


@app.cell
def _(np, stats):
    dists = [stats.norm(8.0, 10.5), stats.norm(4.9, 1.25), stats.norm(12.6, 4.8)]
    narr = [50, 8, 10]
    rng = np.random.default_rng(2)
    data = [d.rvs(size=n, random_state=rng) for d, n in zip(dists, narr)]
    return dists, narr, data


@app.cell
def _(data, lock5, narr, plt):
    fig, axes = plt.subplots(1, 3, figsize=(13, 4), sharey=True)
    for idx, (ax, d) in enumerate(zip(axes, data)):
        lock5.plot_dotplot(d, ax=ax, title=f"n={narr[idx]}", xlabel="value")
    fig
    return fig, axes


if __name__ == "__main__":
    app.run()
