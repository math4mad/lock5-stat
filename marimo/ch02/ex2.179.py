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
    mo.md(r"""# Ex 2.179 — College completion rates by control type

Port of `UnitA/ch02/ex2.179.jl`. Box plot of `CompRate` by `Control`.""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(138, "CollegeScores", "Completion Rates at US Colleges",
                            ["Control", "CompRate"])
    data = lock5.load_csv(desc.name)
    return data


@app.cell
def _(data, lock5, plt):
    cats, groups, _ = lock5.group_summary(data, "Control", "CompRate")
    fig, ax = lock5.grouped_boxplot(cats, groups, title="school type and comp rate",
                                    xlabel="Control", ylabel="CompRate", vert=True)
    fig
    return fig, ax, cats, groups


if __name__ == "__main__":
    app.run()
