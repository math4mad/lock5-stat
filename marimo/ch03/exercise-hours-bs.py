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
    mo.md(r"""# Exercise hours — bootstrap setup

Port of `UnitB/ch03/exercise-hours-bs.jl`. Group `Exercise` by `Sex` and show the
mean exercise hours per group.""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(287, "ExerciseHours", "bootstrap sampling", ["Sex", "Exercise"])
    data = lock5.load_data(desc.name).select(desc.feature)
    return data, desc


@app.cell
def _(data, lock5, mo, pl):
    summary = data.group_by("Sex", maintain_order=True).agg(
        pl.col("Exercise").mean().alias("average_exercise"),
        pl.col("Exercise").len().alias("n"),
    )
    mo.Html(lock5.gt_table(summary, title="Average exercise by Sex",
                            decimals={"average_exercise": 3}).as_raw_html())
    return summary


if __name__ == "__main__":
    app.run()
