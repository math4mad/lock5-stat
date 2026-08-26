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
    mo.md(r"""# Ex A.94 — Calories, fat and fibre

Port of `UnitA/exercise/exA.94.jl`. Scatter of `Fat` vs `Calories` and `Fiber`
vs `Calories`, with their correlations.""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(227, "NutritionStudy", "Fat and Fiber and Calories",
                            ["Calories", "Fat", "Fiber"])
    df = lock5.load_csv(desc.name).select(desc.feature)
    df1 = df.select(["Fat", "Calories"])
    df2 = df.select(["Fiber", "Calories"])
    return desc, df, df1, df2


@app.cell
def _(df, lock5, mo):
    mo.Html(lock5.gt_table(lock5.peek(df, 5), title="First 5 rows").as_raw_html())
    return


@app.cell
def _(df1, lock5):
    fig1, ax1 = lock5.plot_pair_cor(df1)
    fig1
    return fig1, ax1


@app.cell
def _(df2, lock5):
    fig2, ax2 = lock5.plot_pair_cor(df2)
    fig2
    return fig2, ax2


@app.cell
def _(df1, df2, lock5, mo, pl):
    rows = [
        {"pair": "Fat-Calories", "correlation": lock5.pair_corletation(df1)},
        {"pair": "Fiber-Calories", "correlation": lock5.pair_corletation(df2)},
    ]
    cor_df = pl.DataFrame(rows)
    mo.Html(lock5.gt_table(cor_df, title="Correlations").as_raw_html())
    return cor_df, rows


if __name__ == "__main__":
    app.run()
