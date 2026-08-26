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
    mo.md(r"""# Data 2.12 — Restaurant tips: Bill vs Tip

Port of `UnitA/ch02/data2.12.jl`. Scatter of `Bill` against `Tip`.""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(159, "RestaurantTips", "Bill-Tip-relation", ["Bill", "Tip"])
    data = lock5.load_csv(desc.name).select(desc.feature)
    return desc, data


@app.cell
def _(data, desc, lock5):
    fig, ax = lock5.plot_pair_cor(data)
    ax.set_title("Bill-Tip relation")
    ax.set_xlabel(desc.feature[0])
    ax.set_ylabel(desc.feature[1])
    fig
    return fig, ax


if __name__ == "__main__":
    app.run()
