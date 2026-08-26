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
    mo.md(r"""# Bootstrap sampling — method 2 (distribution of the mean)

Port of `UnitB/ch03/bootstrap-sampling-method-2.jl`. Bootstrap the mean of a
10-value sample, repeat 1000 times, and dot-plot the resulting distribution.
Bootstrap results are random, so values differ from the Julia run.""")
    return


@app.cell
def _(lock5, np):
    data = np.array([28.06, 29.21, 28.43, 28.97, 29.95, 28.67, 30.57, 29.22, 27.78, 29.58])

    def get_mean(rng):
        return float(rng.choice(data, size=len(data), replace=True).mean())

    rng = np.random.default_rng(3434343)
    res = np.array([get_mean(rng) for _ in range(1000)])
    return data, res


@app.cell
def _(lock5, res):
    fig, ax = lock5.plot_dotplot(res, nbins=20, title="Bootstrap mean distribution",
                                 xlabel="mean", ylabel="count", color="cyan")
    fig
    return fig, ax


if __name__ == "__main__":
    app.run()
