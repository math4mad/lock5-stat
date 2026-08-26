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
    mo.md(r"""# Data 6.3 — Crows Never Forget a Face (Fisher's exact test)

Port of `UnitC/ch06/data-6.3-crows-never-forget-face-proportion.jl`.

The book's counts are 158 of 602 crows scolded the caveman mask and 109 of 1031
scolded the neutral mask (i.e. ``no scold`` = 444 and 922).  The original Julia
source wrote ``444-158`` / ``922-109`` (a bug); this port uses the correct counts.""")
    return


@app.cell
def _(lock5, pl):
    c2 = [158, 444]
    c3 = [109, 922]
    df = lock5.freq_table(
        pl.DataFrame({"cavemanmask(caught crows)": c2, "neutralmask(control)": c3}),
        typename=["scold", "no scold", "Total"],
    )
    return df


@app.cell
def _(GT, df, mo):
    mo.Html(GT(df).tab_header(title="Crow scolding counts").as_raw_html())
    return


@app.cell
def _(df, lock5, mo):
    a = df[0, 1]
    b = df[0, 2]
    c = df[2, 1]
    d = df[2, 2]
    ht = lock5.fisher_exact_test(a, b, c, d)
    mo.Html(lock5.gt_ttest(ht).as_raw_html())
    return a, b, c, d, ht


@app.cell
def _(GT, a, b, c, d, lock5, mo, pl):
    ht90 = lock5.fisher_exact_test(a, b, c, d, level=0.90)
    ci90_df = pl.DataFrame({
        "90% confidence interval": [f"({round(ht90.ci_low, 4)}, {round(ht90.ci_high, 4)})"],
    })
    mo.Html(GT(ci90_df).tab_header(title="Odds ratio — 90% CI").as_raw_html())
    return ht90


if __name__ == "__main__":
    app.run()
