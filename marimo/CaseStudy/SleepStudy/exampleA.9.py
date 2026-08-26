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
    mo.md(r"""# Example A.9 — Simple linear regression of PoorSleepQuality on DASScore

Port of `UnitA/CaseStudy/exampleA.9.jl`. Least-squares fit of
`PoorSleepQuality ~ DASScore` with the fitted line overlaid on the data.""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(205, "SleepStudy", "Sleep Quality and DAS Score",
                            ["DASScore", "PoorSleepQuality"])
    df = lock5.load_csv(desc.name).select(desc.feature)
    x = df["DASScore"].to_numpy().astype(float)
    y = df["PoorSleepQuality"].to_numpy().astype(float)
    res = stats.linregress(x, y)
    return desc, df, res, x, y


@app.cell
def _(lock5, mo, pl, res):
    coef_df = pl.DataFrame({
        "term": ["intercept", "slope (DASScore)", "correlation (r)"],
        "value": [res.intercept, res.slope, res.rvalue],
    })
    mo.Html(lock5.gt_table(
        coef_df,
        title="PoorSleepQuality ~ DASScore",
        decimals={"value": 6},
    ).as_raw_html())
    return coef_df


@app.cell
def _(lock5, res, x, y):
    fig, ax = lock5.scatter_fit(x, y, res.slope, res.intercept,
                                title="Sleep Quality and DAS Score",
                                xlabel="DASScore", ylabel="PoorSleepQuality")
    fig
    return fig, ax


if __name__ == "__main__":
    app.run()
