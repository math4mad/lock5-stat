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
    mo.md(r"""# Ex 6.231 — Note-taking (longhand vs laptop), two-sample t-test

Port of `UnitC/ch06/ex-6.231.jl`: `EqualVarianceTTest` from the summary
statistics `(n, x̄, s)` of the two groups.""")
    return


@app.cell
def _(lock5):
    longhand = [38, 25.6, 10.8]
    laptop = [40, 18.3, 9.0]
    nx, mx, vx = longhand
    ny, my, vy = laptop
    return nx, mx, vx, ny, my, vy


@app.cell
def _(lock5, mo, mx, my, nx, ny, vx, vy):
    res = lock5.equal_var_ttest_stats(nx, ny, mx, my, vx, vy)
    mo.Html(lock5.gt_ttest(res).as_raw_html())
    return res


if __name__ == "__main__":
    app.run()
