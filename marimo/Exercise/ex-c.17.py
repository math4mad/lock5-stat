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
    mo.md(r"""# Exercise C.17 — Cash vs card for merchants B and C (Fisher)

Port of `UnitC/Exercise/ex-c.17.jl`.  Compare the cash-payment proportion between
merchants B and C using Fisher's exact test.

| | A | B | C |
|---|---|---|---|
| Yes | 21 | 15 | 15 |
| No | 39 | 50 | 17 |""")
    return


@app.cell
def _(lock5):
    b_card = 15   # Yes, B
    b_cash = 50   # No, B
    b_total = b_card + b_cash
    c_cash = 15   # Yes, C
    c_card = 17   # No, C
    c_total = c_card + c_cash
    return b_card, b_cash, b_total, c_cash, c_card, c_total


@app.cell
def _(b_card, b_total, c_card, c_total, lock5, mo):
    res = lock5.fisher_exact_test(b_card, c_card, b_total, c_total)
    mo.Html(lock5.gt_ttest(res).as_raw_html())
    return res


if __name__ == "__main__":
    app.run()
