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
    mo.md(r"""# Ex 2.169 — Hollywood movie profitability

Port of `UnitA/ch02/ex2.169.jl`. Box plot of `Profitability` plus mean/median.""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(135, "HollywoodMovies", "How Profitable Are Hollywood Movies?",
                            ["Profitability"])
    data = lock5.load_csv(desc.name).select(desc.feature)
    return data


@app.cell
def _(data, plt):
    vals = data["Profitability"].to_numpy().astype(float)
    fig, ax = plt.subplots(figsize=(7, 4))
    ax.boxplot([vals], vert=True, tick_labels=["Profitability"], patch_artist=True)
    ax.set_title("hollywood movie profitability")
    fig
    return fig, ax, vals


@app.cell
def _(data, lock5, mo, pl):
    summary = pl.DataFrame({
        "statistic": ["mean", "median"],
        "Profitability": [data["Profitability"].mean(), data["Profitability"].median()],
    })
    mo.Html(lock5.gt_table(summary, title="Profitability summary").as_raw_html())
    return summary


if __name__ == "__main__":
    app.run()
