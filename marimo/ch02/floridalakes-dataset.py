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
    mo.md(r"""# Florida lakes — alkalinity histogram with mean/median

Port of `UnitA/ch02/floridalakes-dataset.jl`. Histogram of `Alkalinity` with
vertical lines for the mean and median.""")
    return


@app.cell
def _(lock5):
    df = lock5.load_data("FloridaLakes")
    return df


@app.cell
def _(df, plt, np):
    alkalinity = df["Alkalinity"].to_numpy().astype(float)
    mea, med = alkalinity.mean(), np.median(alkalinity)
    fig, ax = plt.subplots(figsize=(7, 4))
    ax.hist(alkalinity, bins="auto", color="gray", alpha=0.6, edgecolor="black", linewidth=1)
    ax.axvline(mea, color="blue", label="mean", linewidth=2)
    ax.axvline(med, color="orange", label="median", linewidth=2)
    ax.set_title("floridalakes alkalinity")
    ax.set_xlabel("alkalinity")
    ax.set_ylabel("frequency")
    ax.legend()
    fig
    return alkalinity, fig, ax, mea, med


if __name__ == "__main__":
    app.run()
