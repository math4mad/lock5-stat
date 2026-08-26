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
    mo.md(r"""# Mammal longevity — dot plot

Port of `UnitA/ch02/longevity-mammals-dotplot.jl`. Dot plot of `Longevity` built
from per-value counts.""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(94, "MammalLongevity", "dotplot ", ["Animal", "Longevity"])
    data = lock5.load_csv(desc.name).select(desc.feature[1])
    return data


@app.cell
def _(data, plt):
    counts = data.group_by("Longevity", maintain_order=True).len()
    xs = counts["Longevity"].to_list()
    ys = counts["len"].to_list()
    fig, ax = plt.subplots(figsize=(9, 3))
    for x, cnt in zip(xs, ys):
        for y in range(1, int(cnt) + 1):
            ax.scatter(x, y, s=50, color="lightgreen", alpha=0.5,
                       edgecolors="black", linewidths=0.5)
    ax.set_xlabel("Longevity")
    ax.set_ylabel("Count")
    ax.set_ylim(0, max(ys) + 1)
    fig
    return counts, fig, ax, xs, ys


if __name__ == "__main__":
    app.run()
