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
    mo.md(r"""# Exercise C.16 — Overall "Yes" proportion confidence interval

Port of `UnitC/Exercise/ex-c.16.jl`.  Sum the "Yes"/"No" rows across groups and
report the 95% confidence interval of the "Yes" proportion.""")
    return


@app.cell
def _(lock5):
    yes = 21 + 15 + 15
    no = 39 + 50 + 17
    total = yes + no
    return yes, no, total


@app.cell
def _(lock5, mo, total, yes):
    res = lock5.binomial_test(yes, total, 1 / 3, level=0.95)
    mo.Html(lock5.gt_proportion(res).as_raw_html())
    return res


if __name__ == "__main__":
    app.run()
