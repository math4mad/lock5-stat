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
    mo.md(r"""# Restaurant tips — data

Port of `UnitB/CaseStudy-Restaurant Tips/data.jl`. Load the `RestaurantTips`
dataset and inspect it.""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(395, "RestaurantTips", "",
                            ["Bill", "Tip", "Credit", "Guests", "Day", "Server", "PctTip"])
    data = lock5.load_data(desc.name)
    return data, desc


@app.cell
def _(data, lock5, mo):
    mo.Html(lock5.gt_table(lock5.peek(data, 8), title="RestaurantTips — first 8 rows").as_raw_html())
    return


@app.cell
def _(data, mo):
    mo.md("Columns: " + ", ".join(f"`{c}`" for c in data.columns))
    return


if __name__ == "__main__":
    app.run()
