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
    mo.md(r"""# Example A.5 — Proportion of "Lark" chronotype

Port of `UnitA/CaseStudy/exampleA.5.jl`. Frequency of `LarkOwl` and the
proportion of Larks.""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(203, "SleepStudy", "LarkType proportion", ["LarkOwl"])
    df = lock5.load_csv(desc.name).select("LarkOwl")
    return df


@app.cell
def _(df, lock5, mo):
    ft = lock5.freqtable(df, "LarkOwl")
    total = ft["count"].sum()
    lark = int(ft.filter(ft["LarkOwl"] == "Lark")["count"][0])
    proportion = round(lark / total, 3)
    mo.Html(lock5.gt_table(ft, title="LarkOwl frequencies").as_raw_html())
    mo.md(f"Proportion of Lark type: **{proportion}** ({lark}/{total})")
    return ft, lark, proportion, total


if __name__ == "__main__":
    app.run()
