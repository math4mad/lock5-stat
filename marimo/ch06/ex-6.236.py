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
    mo.md(r"""# Ex 6.236 — Comparing two years (two-sample t-test)

Port of `UnitC/ch06/ex-6.236.jl`: `EqualVarianceTTest` from summary statistics
`(n, mean, St.Dev)` for 2010 and 2019.""")
    return


@app.cell
def _(lock5):
    y2010 = [30, 8.12, 7.68]
    y2019 = [37, 5.50, 6.44]
    nx, mx, vx = y2010
    ny, my, vy = y2019
    return nx, mx, vx, ny, my, vy


@app.cell
def _(lock5, mo, mx, my, nx, ny, vx, vy):
    res = lock5.equal_var_ttest_stats(nx, ny, mx, my, vx, vy)
    mo.Html(lock5.gt_ttest(res).as_raw_html())
    return res


if __name__ == "__main__":
    app.run()
