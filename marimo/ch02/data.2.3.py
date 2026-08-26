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
    mo.md(r"""# Data 2.3 — ICU admissions: mean/median heart rate by age

Port of `UnitA/ch02/data2.3.jl`. Mean and median `HeartRate` for patients aged 20
and 55 (Example 2.11 in the text).""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(99, "ICUAdmissions", "mean", [])
    df = lock5.load_csv(desc.name)
    return desc, df


@app.cell
def _(df, lock5, mo, pl):
    def hrate(age):
        return df.filter(pl.col("Age") == age)["HeartRate"]

    res = pl.DataFrame({
        "age": [20, 20, 55, 55],
        "statistic": ["mean", "median", "mean", "median"],
        "HeartRate": [hrate(20).mean(), hrate(20).median(),
                      hrate(55).mean(), hrate(55).median()],
    })
    mo.Html(lock5.gt_table(res, title="HeartRate by age").as_raw_html())
    return hrate, res


if __name__ == "__main__":
    app.run()
