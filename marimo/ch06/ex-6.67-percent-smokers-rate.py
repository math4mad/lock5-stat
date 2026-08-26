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
    mo.md(r"""# Ex 6.67 — Is the proportion of smokers different from 20%?

Port of `UnitC/ch06/ex-6.67-percent-smokers-rate.jl`.""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(447, "NutritionStudy", "the proportion of smokers?", ["Smoke"])
    df = lock5.load_csv(desc.name).select(desc.feature)
    smokers = df.filter(pl.col("Smoke") == "Yes").height
    n = df.height
    return desc, df, smokers, n


@app.cell
def _(lock5, mo, n, smokers):
    res = lock5.binomial_test(smokers, n, 0.2)
    mo.Html(lock5.gt_proportion(res).as_raw_html())
    return res


if __name__ == "__main__":
    app.run()
