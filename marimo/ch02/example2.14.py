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
    mo.md(r"""# Example 2.14 — Florida lakes alkalinity histogram

Port of `UnitA/ch02/example2.14.jl`. Histogram of `Alkalinity`.""")
    return


@app.cell
def _(lock5):
    data = lock5.load_csv("FloridaLakes")
    return data


@app.cell
def _(data, plt):
    fig, ax = plt.subplots(figsize=(7, 4))
    ax.hist(data["Alkalinity"].to_numpy(), bins="auto", color="gray", alpha=0.6,
            edgecolor="black", linewidth=1)
    ax.set_xlabel("Alkalinity value")
    ax.set_ylabel("Frequency")
    fig
    return fig, ax


if __name__ == "__main__":
    app.run()
