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
    mo.md(r"""# Exercise C.15 — Proportion for group B

Port of `UnitC/Exercise/ex-c.15.jl`.  Contingency table (Attitude × Group):

| | A | B | C |
|---|---|---|---|
| Yes | 21 | 15 | 15 |
| No | 39 | 50 | 17 |

Test whether the "Yes" proportion in group B is 1/3.""")
    return


@app.cell
def _(lock5):
    b_yes = 15
    b_no = 50
    b_total = b_yes + b_no
    return b_yes, b_no, b_total


@app.cell
def _(b_total, b_yes, lock5, mo):
    res = lock5.binomial_test(b_yes, b_total, 1 / 3)
    mo.Html(lock5.gt_proportion(res).as_raw_html())
    return res


if __name__ == "__main__":
    app.run()
