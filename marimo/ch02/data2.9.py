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
    mo.md(r"""# Data 2.9 — Presidential approval and re-election margin

Port of `UnitA/ch02/data2.9.jl`. Scatter of `Approval` vs `Margin` with a dashed
zero line, plus the correlation.""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(139, "ElectionMargin", "Presidential Approval Ratings and Re-election",
                            ["Approval", "Margin"])
    data = lock5.load_csv(desc.name).select(desc.feature)
    return desc, data


@app.cell
def _(data, plt):
    fig, ax = plt.subplots(figsize=(7, 4))
    ax.scatter(data["Approval"], data["Margin"], s=45, color="lightgreen",
               alpha=0.5, edgecolors="black", linewidths=1)
    ax.axhline(0, linestyle="--", color="red", linewidth=2)
    ax.set_title("correlation of Approval and Margin")
    ax.set_xlabel("Approval")
    ax.set_ylabel("Margin")
    fig
    return fig, ax


@app.cell
def _(data, lock5, mo):
    r = lock5.pair_corletation(data.select(["Approval", "Margin"]))
    mo.md(f"Correlation of Approval and Margin: **{r}**")
    return r


if __name__ == "__main__":
    app.run()
