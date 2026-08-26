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
    mo.md(r"""# F-test — equal variances

Port of `UnitB/ch04/ftest-1.jl`. F-test for the variance ratio of two samples.""")
    return


@app.cell
def _(lock5):
    x = [18, 19, 22, 25, 27, 28, 41, 45, 51, 55]
    y = [14, 15, 15, 17, 18, 22, 25, 25, 27, 34]
    return x, y


@app.cell
def _(lock5, mo, pl, x, y):
    res = lock5.variance_ftest(x, y)
    res_df = pl.DataFrame({"item": list(res.keys()), "value": [str(v) for v in res.values()]})
    mo.Html(lock5.gt_table(res_df, title="Variance F-test").as_raw_html())
    return res, res_df


if __name__ == "__main__":
    app.run()
