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
    mo.md(r"""# Example B.3 — Simple linear regression of Tip on Bill

Port of `UnitB/CaseStudy-Restaurant Tips/example-b3.jl`. Least-squares fit of
`Tip ~ Bill` with the fitted line overlaid on the data.""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(395, "RestaurantTips", "", ["Bill", "Tip", "Credit", "Guests", "Day", "Server", "PctTip"])
    data = lock5.load_data(desc.name).select(["Bill", "Tip"])
    x = data["Bill"].to_numpy().astype(float)
    y = data["Tip"].to_numpy().astype(float)
    res = stats.linregress(x, y)
    return data, desc, res, x, y


@app.cell
def _(lock5, mo, pl, res):
    coef_df = pl.DataFrame({
        "term": ["intercept", "slope (Bill)", "correlation (r)"],
        "value": [res.intercept, res.slope, res.rvalue],
    })
    mo.Html(lock5.gt_table(coef_df, title="Tip ~ Bill", decimals={"value": 6}).as_raw_html())
    return coef_df


@app.cell
def _(lock5, res, x, y):
    fig, ax = lock5.scatter_fit(x, y, res.slope, res.intercept,
                                title="Tip vs Bill", xlabel="Bill", ylabel="Tip")
    fig
    return fig, ax


if __name__ == "__main__":
    app.run()
