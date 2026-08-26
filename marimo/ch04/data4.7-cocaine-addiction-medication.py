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
    mo.md(r"""# Data 4.7 — Cocaine addiction medication

Port of `UnitB/ch04/data4.7-cocaine-addiction-medication.jl`. Relapse table for
three treatments, then Fisher exact tests of Lithium vs Placebo and
Desipramine vs Placebo.""")
    return


@app.cell
def _(lock5):
    df = lock5.freq_table(
        pl.DataFrame({"Relapse": [10, 18, 20], "NoRelapse": [14, 6, 14]}),
        typename=["Desipramine", "Lithium", "Placebo", "Total"],
    )
    return df


@app.cell
def _(df, lock5, mo):
    mo.Html(lock5.gt_table(df, title="Relapse by treatment").as_raw_html())
    return


@app.cell
def _(df, lock5, mo):
    # test1: Lithium (row 1) vs Placebo (row 2)
    a1 = df["Relapse"][1]; c1 = df["Total"][1]; b1 = df["Relapse"][2]; d1 = df["Total"][2]
    res1 = lock5.fisher_exact_test(a1, b1, c1, d1)
    mo.Html(lock5.gt_ttest(res1).as_raw_html())
    return a1, b1, c1, d1, res1


@app.cell
def _(df, lock5, mo):
    # test2: Desipramine (row 0) vs Placebo (row 2)
    a2 = df["Relapse"][0]; c2 = df["Total"][0]; b2 = df["Relapse"][2]; d2 = df["Total"][2]
    res2 = lock5.fisher_exact_test(a2, b2, c2, d2)
    mo.Html(lock5.gt_ttest(res2).as_raw_html())
    return a2, b2, c2, d2, res2


if __name__ == "__main__":
    app.run()
