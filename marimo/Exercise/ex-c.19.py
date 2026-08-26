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
    mo.md(r"""# Exercise C.19 — Summary statistics by credit-card use (2)

Port of `UnitC/Exercise/ex-c.19.jl` (data table only; no test is run in the
Julia source).""")
    return


@app.cell
def _(GT, mo, pl):
    data = pl.DataFrame({
        "Credit?": ["Yes", "No"],
        "n": [51, 106],
        "Mean": [29.4, 19.5],
        "Std.Dev": [14.5, 9.4],
    })
    mo.Html(GT(data).tab_header(title="Summary statistics by credit-card use (2)").as_raw_html())
    return


if __name__ == "__main__":
    app.run()
