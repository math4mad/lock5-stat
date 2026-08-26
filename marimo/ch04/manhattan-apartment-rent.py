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
    mo.md(r"""# Manhattan apartment rent — bootstrap CI

Port of `UnitB/ch04/manhattan-apartment-rent.jl`. Bootstrap the mean rent (2000
samples) and report bias, standard error and a basic 95% CI. Bootstrap results
are random, so values differ from the Julia run.""")
    return


@app.cell
def _(lock5, np):
    data = np.array([3800, 1650, 1850, 2132, 2850, 2600, 3295, 2350, 2900, 2158,
                     2150, 5400, 2649, 3695, 2450, 2195, 1995, 2495, 2990, 3850],
                    dtype=float)
    return data


@app.cell
def _(data, lock5, mo, np, pl):
    boots = lock5.boot_sampling(data, n=2000, method=np.mean, seed=343434)
    estimate = float(data.mean())
    bci = lock5.basic_confint(boots, estimate, 0.95)
    res_df = pl.DataFrame({
        "item": ["estimate", "bias", "std error", "basic 95% CI lower", "basic 95% CI upper"],
        "value": [round(estimate, 2), round(float(boots.mean() - estimate), 2),
                  round(float(boots.std(ddof=1)), 2), round(bci[1], 2), round(bci[2], 2)],
    })
    mo.Html(lock5.gt_table(res_df, title="Manhattan rent bootstrap (2000 samples)").as_raw_html())
    return bci, boots, estimate, res_df


if __name__ == "__main__":
    app.run()
