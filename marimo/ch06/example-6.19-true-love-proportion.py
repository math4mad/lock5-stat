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
    mo.md(r"""# Example 6.19 — True love by gender (Fisher's exact test)

Do men and women believe in true love at the same rate?
Port of `UnitC/ch06/example-6.19-true-love-proportion.jl`.""")
    return


@app.cell
def _(lock5, pl):
    c2 = [372, 807, 34]
    c3 = [363, 1005, 44]
    df = lock5.freq_table(
        pl.DataFrame({"Male": c2, "Female": c3}),
        typename=["Agree", "Disagree", "Don't know", "Total"],
    )
    return df


@app.cell
def _(GT, df, mo):
    mo.Html(GT(df).tab_header(title="Do you believe in true love?").as_raw_html())
    return


@app.cell
def _(df, lock5, mo):
    a = df[0, 1]
    b = df[0, 2]
    c = df[3, 1]
    d = df[3, 2]
    ht = lock5.fisher_exact_test(a, b, c, d)
    mo.Html(lock5.gt_ttest(ht).as_raw_html())
    return ht


if __name__ == "__main__":
    app.run()
