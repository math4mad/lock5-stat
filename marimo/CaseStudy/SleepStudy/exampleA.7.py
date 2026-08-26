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
    mo.md(r"""# Example A.7 — Stress × LarkOwl contingency table

Port of `UnitA/CaseStudy/exampleA.7.jl`. Two-way table of `Stress` (rows) by
`LarkOwl` (columns) with totals.""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(203, "SleepStudy", "Stress by LarkOwl", ["Stress", "LarkOwl"])
    df = lock5.load_csv(desc.name).select(desc.feature)
    return df


@app.cell
def _(df, lock5, mo, pl):
    ct = lock5.freqtable(df, "Stress", "LarkOwl")
    owl_cols = ["Lark", "Neither", "Owl"]
    num = pl.DataFrame({
        c: [int(ct.filter(pl.col("Stress") == "high")[c][0]),
            int(ct.filter(pl.col("Stress") == "normal")[c][0])]
        for c in owl_cols
    })
    ft = lock5.freq_table(num, typename=["high", "normal", "Total"])
    mo.Html(lock5.gt_table(ft, title="Stress by LarkOwl").as_raw_html())
    return ct, ft, num, owl_cols


if __name__ == "__main__":
    app.run()
