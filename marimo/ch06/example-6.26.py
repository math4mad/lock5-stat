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
    mo.md(r"""# Example 6.26 — Atlanta vs St. Louis commute times

Port of `UnitC/ch06/example-6.26.jl`: compare commute `Time` for the two cities
with a summary table and a grouped box plot.""")
    return


@app.cell
def _(lock5):
    desc1 = lock5.Lock5Table(489, "CommuteAtlanta", "CommuteAtlanta", ["Time"])
    desc2 = lock5.Lock5Table(489, "CommuteStLouis", "CommuteStLouis", ["Time"])
    atlanta = lock5.load_csv(desc1.name)["Time"].to_numpy().astype(float)
    stlouis = lock5.load_csv(desc2.name)["Time"].to_numpy().astype(float)
    data = [atlanta, stlouis]
    group = ["Atlanta", "StLouis"]
    summary = lock5.summary_df(group, data)
    return desc1, desc2, atlanta, stlouis, data, group, summary


@app.cell
def _(GT, mo, summary):
    mo.Html(GT(summary).tab_header(title="Commute time by city").fmt_number(columns=["Mean", "Stddev"], decimals=4).as_raw_html())
    return


@app.cell
def _(data, group, lock5):
    fig, ax = lock5.grouped_boxplot(group, data, title="Grouped Boxplot", xlabel="Time", ylabel="City")
    fig
    return fig, ax


if __name__ == "__main__":
    app.run()
