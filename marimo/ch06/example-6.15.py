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
    mo.md(r"""# Example 6.15 — Manhattan one-bedroom apartment rents

Port of `UnitC/ch06/example-6.15.jl`: dot plot of `ManhattanApartments.Rent`.""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(457, "ManhattanApartments", "price of a one-bedroom apartment in Manhattan", ["Rent"])
    data = lock5.load_csv(desc.name)
    return desc, data


@app.cell
def _(data, lock5, plt):
    fig, ax = lock5.plot_dotplot(data["Rent"].to_numpy(), nbins=20, title="ManhattanApartments Rent", xlabel="Rent")
    fig
    return fig, ax


if __name__ == "__main__":
    app.run()
