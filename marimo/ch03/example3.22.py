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
    mo.md(r"""# Example 3.22 — Bootstrap confidence interval (CommuteAtlanta)

Port of `UnitB/ch03/example3.22.jl`. Bootstrap the mean `Time` and compute a
basic 95% confidence interval. Bootstrap results are random, so values differ
from the Julia run.""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(270, "CommuteAtlanta", "data3.1",
                            ["City", "Age", "Distance", "Time", "Sex"])
    df = lock5.load_csv(desc.name).select(desc.feature[3])
    times = df["Time"].to_numpy().astype(float)
    return desc, df, times


@app.cell
def _(lock5, mo, np, pl, times):
    n_boot = 1000
    cil = 0.95
    boots = lock5.boot_sampling(times, n=n_boot, method=np.mean, seed=1)
    estimate = float(times.mean())
    bci = lock5.basic_confint(boots, estimate, cil)
    res_df = pl.DataFrame({
        "item": ["estimate", "bias", "std error", "basic 95% CI lower", "basic 95% CI upper"],
        "value": [round(estimate, 3), round(float(boots.mean() - estimate), 3),
                  round(float(boots.std(ddof=1)), 3), round(bci[1], 3), round(bci[2], 3)],
    })
    mo.Html(lock5.gt_table(res_df, title="Bootstrap CI for mean Time").as_raw_html())
    return bci, boots, estimate, res_df


if __name__ == "__main__":
    app.run()
