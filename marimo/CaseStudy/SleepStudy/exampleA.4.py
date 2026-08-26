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
    mo.md(r"""# Example A.4 — Stress × LarkOwl, and PoorSleepQuality vs DASScore

Port of `UnitA/CaseStudy/exampleA.4.jl`. Two-way table of `Stress` by `LarkOwl`
(with proportions) and a scatter of `PoorSleepQuality` against `DASScore`.""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(202, "SleepStudy", "Sleep Study with College Students",
                            ["DASScore", "Stress", "LarkOwl", "AlcoholUse",
                             "PoorSleepQuality", "CognitionZscore"])
    df = lock5.load_csv(desc.name).select(desc.feature)
    return desc, df


@app.cell
def _(df, lock5, mo, pl):
    df2 = df.select(["Stress", "LarkOwl"])
    stress_rows = ["high", "normal"]
    lark_cols = ["Lark", "Neither", "Owl"]
    num = pl.DataFrame({
        c: [int(df2.filter((pl.col("Stress") == s) & (pl.col("LarkOwl") == c)).height)
            for s in stress_rows]
        for c in lark_cols
    })
    count_df = num.with_columns(pl.Series("Stress", stress_rows)).select(["Stress", *lark_cols])
    mo.Html(lock5.gt_table(count_df, title="Stress by LarkOwl (counts)").as_raw_html())
    return count_df, df2, lark_cols, num, stress_rows


@app.cell
def _(lock5, lark_cols, mo, num, pl, stress_rows):
    prop_df = (lock5.prop(num)
               .with_columns(pl.Series("Stress", stress_rows))
               .select(["Stress", *lark_cols]))
    mo.Html(lock5.gt_table(prop_df, title="Stress by LarkOwl (proportions)").as_raw_html())
    return prop_df


@app.cell
def _(df, lock5):
    df4 = df.select(["PoorSleepQuality", "DASScore"])
    fig, ax = lock5.plot_pair_cor(df4)
    ax.set_title("PoorSleepQuality-DASScore-Cor")
    fig
    return df4, fig, ax


if __name__ == "__main__":
    app.run()
