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
    mo.md(r"""# Example 2.31 — mean and std of TV watching by sex

Port of `UnitA/ch02/example.2-31.jl`. Descriptive statistics of `TV` for each
`Sex` group.""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(132, "StudentSurvey", "mean and std in boy and girl watch tv",
                            ["Sex", "TV"])
    data = lock5.load_csv(desc.name).select(desc.feature)
    return data


@app.cell
def _(data, lock5, mo, pl):
    stats_df = data.group_by("Sex", maintain_order=True).agg([
        pl.col("TV").count().alias("n"),
        pl.col("TV").mean().alias("mean"),
        pl.col("TV").std(ddof=1).alias("std"),
    ])
    mo.Html(lock5.gt_table(stats_df, title="TV hours by sex").as_raw_html())
    return stats_df


if __name__ == "__main__":
    app.run()
