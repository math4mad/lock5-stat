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
    mo.md(r"""# Ex A.42 — College graduates by region of the US

Port of `UnitA/exercise/exA.42.jl`. Box plot of `College` (percent of college
graduates) for each `Region`.""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(215, "USStates", "Percent of College Graduates by Region of the US",
                            ["Region", "College"])
    df = lock5.load_csv(desc.name).select(desc.feature)
    cats, group_data, summary = lock5.group_summary(df, "Region", "College")
    return cats, desc, df, group_data, summary


@app.cell
def _(cats, group_data, lock5):
    fig, ax = lock5.grouped_boxplot(
        cats, group_data,
        title="Percent of College Graduates by Region of the US",
        xlabel="Region", ylabel="College", vert=True,
    )
    fig
    return fig, ax


@app.cell
def _(lock5, mo, summary):
    mo.Html(lock5.gt_table(
        summary,
        title="College graduates by region",
        decimals={"Mean": 2, "Stddev": 2},
    ).as_raw_html())
    return


if __name__ == "__main__":
    app.run()
