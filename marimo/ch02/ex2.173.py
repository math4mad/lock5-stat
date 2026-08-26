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
    mo.md(r"""# Ex 2.173 — Physical activity by region

Port of `UnitA/ch02/ex2.173.jl`. Box plot of `PhysicalActivity` by `Region`.""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(136, "USStates", "Physical Activity by Region of the Country in the US",
                            ["State", "Region", "PhysicalActivity"])
    data = lock5.load_csv(desc.name).select(desc.feature)
    return data


@app.cell
def _(data, lock5, plt):
    cats, groups, _ = lock5.group_summary(data, "Region", "PhysicalActivity")
    fig, ax = lock5.grouped_boxplot(cats, groups, title="physical activity in different region",
                                    xlabel="Region", ylabel="PhysicalActivity", vert=True)
    plt.setp(ax.get_xticklabels(), rotation=45, ha="right")
    fig
    return fig, ax, cats, groups


if __name__ == "__main__":
    app.run()
