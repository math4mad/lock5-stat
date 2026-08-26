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
    mo.md(r"""# Ex 2.172 — Audience ratings by genre

Port of `UnitA/ch02/ex2.172.jl`. Box plot of `AudienceScore` by `Genre`.""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(136, "HollywoodMovies", "Do Audience Ratings Differ Based on the Genre of the Movie?",
                            ["Genre", "AudienceScore"])
    data = lock5.load_csv(desc.name).select(desc.feature)
    return data


@app.cell
def _(data, lock5, plt):
    cats, groups, _ = lock5.group_summary(data, "Genre", "AudienceScore")
    fig, ax = lock5.grouped_boxplot(cats, groups, title="different rating on AudienceScore",
                                    xlabel="Genre", ylabel="AudienceScore", vert=True,
                                    figsize=(10, 5))
    plt.setp(ax.get_xticklabels(), rotation=45, ha="right")
    fig
    return fig, ax, cats, groups


if __name__ == "__main__":
    app.run()
