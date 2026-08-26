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
    mo.md(r"""# Regular vitamin use — is it different from 35%?

Port of `UnitC/ch06/regular-vitamin-use-rate.jl`: binomial test of the proportion
of `NutritionStudy` subjects taking a vitamin pill regularly against p = 0.35.""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(469, "NutritionStudy", "the proportion taking a vitamin pill regularly is different from 35%?", ["VitaminUse"])
    df = lock5.load_data(desc.name).select(desc.feature)
    vitamin_user = df.filter(pl.col(desc.feature[0]) == "Regular").height
    n = df.height
    return desc, df, vitamin_user, n


@app.cell
def _(lock5, mo, n, vitamin_user):
    res = lock5.binomial_test(vitamin_user, n, 0.35)
    mo.Html(lock5.gt_proportion(res).as_raw_html())
    return res


if __name__ == "__main__":
    app.run()
