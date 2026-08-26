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

    return lock5, mo, np, stats


@app.cell
def _(mo):
    mo.md(r"""
    # Gaussian distributions — mean vs. variance shifts

    Port of `UnitC/ch05/gaussian-dist.jl`: left panel varies μ (σ fixed at 1),
    right panel varies σ (μ fixed at 0).
    """)
    return


@app.cell
def _(np, stats):
    colors = ["#FF410D", "#6EE2FF", "#F7C530", "#95CC5E", "#D0DFE6", "#F79D1E"]
    mu_sig_pairs = [[-3, 1], [-0.3, 1], [0, 1], [1.2, 1], [4, 1], [5, 1]]
    mu_sig_pairs2 = [[0, 0.8], [0, 1], [0, 2], [0, 3], [0, 4], [0, 5]]
    ts = np.linspace(-10, 10, 200)
    dists1 = [stats.norm(loc=p[0], scale=p[1]) for p in mu_sig_pairs]
    dists2 = [stats.norm(loc=p[0], scale=p[1]) for p in mu_sig_pairs2]
    return colors, dists1, dists2, ts


@app.cell
def _(colors, dists1, dists2, lock5, ts):
    fig, axes = lock5.plot_normal_density([dists1, dists2], ts, colors)
    fig
    return


if __name__ == "__main__":
    app.run()
