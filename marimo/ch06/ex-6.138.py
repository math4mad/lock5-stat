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
    mo.md(r"""# Ex 6.138 — Canton home prices dot plot

Port of `UnitC/ch06/ex-6.138.jl`: dot plot of `HomesForSaleCanton.Price`.""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(468, "HomesForSaleCanton", "Difference price of house", ["Price"])
    data = lock5.load_csv(desc.name)
    return desc, data


@app.cell
def _(data, lock5, plt):
    fig, ax = lock5.plot_dotplot(data["Price"].to_numpy(), nbins=10, title="HomesForSaleCanton Price", xlabel="Price")
    fig
    return fig, ax


if __name__ == "__main__":
    app.run()
