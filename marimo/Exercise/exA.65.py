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
    mo.md(r"""# Ex A.65 — Arsenic in toenails

Port of `UnitA/exercise/exA.65.jl`. Descriptive statistics (mean/std,
five-number summary, IQR, range), the z-score of the maximum, and a dot plot.""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(220, "ToenailArsenic", "Arsenic in Toenails", ["Arsenic"])
    df = lock5.load_csv(desc.name)
    a = df["Arsenic"].to_numpy().astype(float)
    mn, sd = lock5.mean_and_std(a)
    stat = lock5.summarystats(a)
    zmax = lock5.zscore([a.max()], mn, sd)[0]
    iqr = stat["q3"] - stat["q1"]
    rng = stat["max"] - stat["min"]
    return a, desc, df, iqr, mn, rng, sd, stat, zmax


@app.cell
def _(iqr, lock5, mn, mo, pl, rng, sd, stat):
    res_df = pl.DataFrame({
        "statistic": ["n", "mean", "std (sample)", "min", "q1", "median", "q3", "max", "iqr", "range"],
        "value": [
            float(stat["n"]), mn, sd, stat["min"], stat["q1"], stat["median"],
            stat["q3"], stat["max"], iqr, rng,
        ],
    })
    mo.Html(lock5.gt_table(res_df, title="Arsenic summary", decimals={"value": 6}).as_raw_html())
    return res_df


@app.cell
def _(a, mo, zmax):
    mo.md(f"**z-score of the maximum** ({a.max():.3f}) = `{zmax}`")
    return


@app.cell
def _(a, lock5):
    fig, ax = lock5.plot_dotplot(a, nbins=12, title="dotplot", xlabel="Arsenic", ylabel="count")
    fig
    return fig, ax


if __name__ == "__main__":
    app.run()
